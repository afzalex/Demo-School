#!/bin/bash

DEMOBOT_REMOTE=demo-bot
SCTRICTMODE=0
ROOT_REPO_NAME="demo-school"
shopt -s expand_aliases

connectRetryCount=0
while [ ! "running" == $(docker inspect ${GITEA_HOST} | jq -r '.[0].State.Status') ]
do
  connectRetryCount=$(( $connectRetryCount + 1 ))
  echo "waiting for gitea server to start... $connectRetryCount"
  sleep 1
done

GITEA_PORT=$(nmap ${GITEA_HOST} | grep ppp | grep -oE '^[0-9]+')
GITEA_URL="http://${GITEA_HOST}:${GITEA_PORT}"
while [[ -z $(curl -s ${GITEA_URL} | grep '<title> Gitea: Git with a cup of tea</title>') ]]
do
  GITEA_PORT=$(nmap ${GITEA_HOST} | grep ppp | grep -oE '^[0-9]+')
  GITEA_URL="http://${GITEA_HOST}:${GITEA_PORT}"
  connectRetryCount=$(( $connectRetryCount + 1 ))
  echo "waiting for gitea server to start serving... $connectRetryCount"
  sleep 1
done

docker volume create demo-setup-volume-tea
DEMO_NETWORK=$(docker inspect ${GITEA_HOST} | jq -r '.[0].NetworkSettings.Networks | to_entries | .[0].key')
echo "demo-school network is \"${DEMO_NETWORK}\""
alias tea="docker run --rm --network ${DEMO_NETWORK} -v demo-setup-volume-tea:/app tgerczei/tea"

tea logout demoadmin

tea login add -u ${GITEA_URL} --user ${GITEA_ADMIN_USERNAME} --password "${GITEA_ADMIN_PASSWORD}" --name demoadmin
tea login default ${GITEA_ADMIN_USERNAME}


alreadyPresentRepos=$(tea repos -o csv | tail -n+2 | awk -F, '{print $4}' | tr -d '"')


# If repository does not exist
if [[ -z $( echo "$alreadyPresentRepos" | grep "${ROOT_REPO_NAME}.git" ) ]]; then
  tea repos create --name ${ROOT_REPO_NAME}
  if [[ $STRICTMODE ]] && [[ $? ]]; then exit 1; fi
fi

pushd . > /dev/null
cd /root

gitRepoUrl=$(tea repos ls -o simple | grep demo-school.git | grep -oE 'git\@.*\.git' | sed -E "s/git\@.*\:[0-9]?/http:\/\/${GITEA_HOST}:${GITEA_PORT}\//")

echo "Git URL for demo-school : ${gitRepoUrl}"

if [ $(git remote | grep "${DEMOBOT_REMOTE}") ]; then
  git remote remove "${DEMOBOT_REMOTE}"
fi
git remote add "${DEMOBOT_REMOTE}" ${gitRepoUrl}
export GIT_REPOSITORY_USERNAME=${GITEA_ADMIN_USERNAME}
export GIT_REPOSITORY_TOKEN=${GITEA_ADMIN_PASSWORD}

./auto-git.sh push --force "${DEMOBOT_REMOTE}" main

echo -e "\n\nProcessing submodules"
cat .gitmodules | grep '\[submodule.*\]' | sed 's/.*\"\(.*\)\".*/\1/' | sed 's/$/\nconfig-store/' |
while read submoduleName; do
  echo "processing submodule $submoduleName"
  gitRepoName=$(git config -f .gitmodules --get "submodule.${submoduleName}.url" | sed 's/\.\.\/\(.*\)\.git/\1/')
  gitRepoPath=$(git config -f .gitmodules --get "submodule.${submoduleName}.path")

  # If repository does not exist
  if [[ -z $( echo "$alreadyPresentRepos" | grep "${ROOT_REPO_NAME}.git" ) ]]; then
    echo "creating repository : ${gitRepoName}"
    tea repos create --name "${gitRepoName}"
    if [[ $STRICTMODE ]] && [[ $? ]]; then exit 1; fi
  else
    echo "repository already exists : ${gitRepoName}"
  fi

  gitRepoUrl=$(tea repos ls -o simple | grep "${gitRepoName}" | grep -oE 'git\@.*\.git' | sed -E "s/git\@.*\:[0-9]?/http:\/\/${GITEA_HOST}:${GITEA_PORT}\//")
  echo "Repo url in gitea : ${gitRepoUrl}"

  echo "repo path : ${gitRepoPath}"
  if [[ ! -d "${gitRepoPath}" ]]; then
    echo -e "submodule directory ${gitRepoPath} not found...\n\n"
    continue
  fi
  pushd . > /dev/null
  cd "$gitRepoPath"
  echo "Current directory is ${PWD}"
  if [ $(git remote | grep "${DEMOBOT_REMOTE}") ]; then
    git remote remove "${DEMOBOT_REMOTE}"
  fi
  git remote add "${DEMOBOT_REMOTE}" ${gitRepoUrl}
  /scripts/auto-git.sh push --force "${DEMOBOT_REMOTE}" main

  popd > /dev/null
  echo -e "\n"
done


#ls -l1 | while read dir; do
#  if [ -d "${dir}" ]; then
#    echo "${dir}";
#  fi;
#done;


#tea logout


popd > /dev/null
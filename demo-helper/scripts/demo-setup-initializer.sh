#!/bin/bash

DEMOBOT_REMOTE=demo-bot
SCTRICTMODE=0

shopt -s expand_aliases

GITEA_PORT=$(nmap ${GITEA_HOST} | grep ppp | grep -oE '^[0-9]+')
GITEA_URL="http://${GITEA_HOST}:${GITEA_PORT}"


docker volume create demo-setup-volume-tea
DEMO_NETWORK=$(docker inspect gitea-server | jq -r '.[0].NetworkSettings.Networks | to_entries | .[0].key')
alias tea="docker run --rm --network ${DEMO_NETWORK} -v demo-setup-volume-tea:/app tgerczei/tea"

tea logout demoadmin

tea login add -u ${GITEA_URL} --user ${GITEA_ADMIN_USERNAME} --password "${GITEA_ADMIN_PASSWORD}" --name demoadmin
tea login default ${GITEA_ADMIN_USERNAME}

tea repos create --name 'demo-school'
if [[ $STRICTMODE ]] && [[ $? ]]; then exit 1; fi


export PATH=$PWD:$PATH
echo $PATH
pushd .
cd /root
gitRepoUrl=$(tea repos ls -o simple | grep demo-school.git | grep -oE 'git\@.*\.git' | sed -E "s/git\@.*\:[0-9]+/http\:\/\/${GITEA_HOST}\:${GITEA_PORT}/")

if [ $(git remote | grep "${DEMOBOT_REMOTE}") ]; then
  git remote remove "${DEMOBOT_REMOTE}"
fi
git remote add "${DEMOBOT_REMOTE}" ${gitRepoUrl}
export GIT_REPOSITORY_USERNAME=${GITEA_ADMIN_USERNAME}
export GIT_REPOSITORY_TOKEN=${GITEA_ADMIN_PASSWORD}
auto-git.sh push -u "${DEMOBOT_REMOTE}" main

#ls -l1 | while read dir; do
#  if [ -d "${dir}" ]; then
#    echo "${dir}";
#  fi;
#done;


#tea logout


popd
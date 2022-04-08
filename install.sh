#!/bin/sh

docker volume create demo-setup-volume-tea
alias tea='docker run --rm -v demo-setup-volume-tea:/app tgerczei/tea'

#tea login add -u http://host.docker.internal:7301 --user demoadmin --password demo#123 --name demoadmin
#tea login default demoadmin

tea repos create --name 'demo-school'
if [[ $? ]]; then exit 1; fi


#ls -l1 | while read dir; do
#  if [ -d "${dir}" ]; then
#    echo "${dir}";
#  fi;
#done;


#tea logout
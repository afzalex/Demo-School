#!/bin/bash


tea repos create --name 'demo-school'
if [[ $? ]]; then exit 1; fi


#ls -l1 | while read dir; do
#  if [ -d "${dir}" ]; then
#    echo "${dir}";
#  fi;
#done;


#tea logout
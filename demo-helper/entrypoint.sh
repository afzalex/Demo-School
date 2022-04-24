#!/bin/sh

echo "Started demo helper"

#echo "$@"

#/bin/tail -F /dev/null

./scripts/setup-elk.sh

./scripts/demo-setup-initializer.sh
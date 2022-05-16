#!/bin/sh

echo "Started demo helper"

#echo "$@"

./scripts/setup-elk.sh

./scripts/demo-setup-initializer.sh

#/bin/tail -F /dev/null
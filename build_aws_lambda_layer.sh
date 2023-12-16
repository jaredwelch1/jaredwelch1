#!/bin/bash
set -x
set -e


TARGET=$1

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
fi

# get python packages for target architecture
# this is important to make sure the layer works with aws lambda
python3.11 -m pip install \
--platform manylinux2014_x86_64 \
--target=python \
--implementation cp \
--python-version 3.11 \
--only-binary=:all: --upgrade -r requirements.txt
# zip the layer up named with your supplied name
zip -r $TARGET.zip python/

# this cleans up for you
rm -rf python/

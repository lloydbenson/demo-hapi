#!/bin/bash

echo "Checking if npm is installed"
## checking nvm version
if [ -e ~/.nvm/nvm.sh ];
then
   source ~/.nvm/nvm.sh
fi
npm --version
if [ $? -ne 0 ];
then
  echo "npm is not installed.  Try https://github.com/creationix/nvm"
  exit 2
fi

echo "Building hapi demo"
echo "Cleanup"
rm -f *.tar.gz
rm -rf node_modules
rm -rf demo-hapi
echo "Testing"
npm install
npm test
rm -rf node_modules
echo "Final install"
npm install --production
npm shrinkwrap
if [ $(uname -s) == "Darwin" ];
then
   CHECK_SUM="shasum"
else
   CHECK_SUM="sha1sum"
fi

VERSION=$(${CHECK_SUM} npm-shrinkwrap.json | awk '{print $1}' | cut -c 1-7)
mkdir demo-hapi
mv lib index.js package.json npm-shrinkwrap.json node_modules bin demo-hapi
tar cvfz demo-hapi-${VERSION}.tar.gz demo-hapi

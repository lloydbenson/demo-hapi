#!/bin/bash

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
VERSION=$(sha1sum npm-shrinkwrap.json | awk '{print $1}' | cut -c 1-7)
mkdir demo-hapi
mv lib index.js package.json npm-shrinkwrap.json node_modules bin demo-hapi
tar cvfz demo-hapi-${VERSION}.tar.gz demo-hapi

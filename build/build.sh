#!/bin/bash

echo "Building hapi demo"
echo "Cleanup"
rm -f *.tar.gz
rm -rf node_modules
echo "Testing"
npm install
npm test
rm -rf node_modules
echo "Final install"
npm install --production
npm shrinkwrap
VERSION=$(sha1sum npm-shrinkwrap.json | awk '{print $1}' | cut -c 1-7)
tar cvfz demo-hapi-${VERSION}.tar.gz lib index.js package.json npm-shrinkwrap.json node_modules bin

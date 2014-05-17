#!/bin/bash

DATE=$(date +%YYMMDDHHMM)
BUILD_PATH="../demo.build/lastSuccessful/archive"
cd ${BUILD_PATH}
ARTIFACT=$(ls *.tar.gz)
echo "Copying ${ARTIFACT} for last successful run"
cp ${BUILD_PATH}/${ARTIFACT} .
echo "Cleaning up last backup"
rm -rf prev-app-*
echo "Stopping App"
demo-hapi/bin/stop.sh
echo "Backup App"
mv app prev-app 
echo "Deploying App"
mkdir app
mv ${ARTIFACT} app
tar xvfz ${ARTIFACT}
demo-hapi/bin/start.sh
exit 0

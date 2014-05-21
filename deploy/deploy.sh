#!/bin/bash

echo "Checking if node is installed"
## checking node version
if [ -e ~/.nvm/nvm.sh ];
then
   source ~/.nvm/nvm.sh
fi
node --version
if [ $? -ne 0 ];
then
  echo "node is not installed.  Try https://github.com/creationix/nvm"
  exit 2
fi

DATE=$(date +%YYMMDDHHMM)
PORT=8081

echo "Download last successful artifact"
ARTIFACT=$(curl -s "http://localhost:${PORT}/job/demo.build/lastSuccessfulBuild/api/json?pretty=true" | grep fileName | awk '{print $3}' | awk -F\" '{print $2}')
curl -s -L -O http://localhost:${PORT}/job/demo.build/lastSuccessfulBuild/artifact/${ARTIFACT}
echo "Copying ${ARTIFACT} for last successful run"
echo "Cleaning up last backup"
rm -rf prev-app
echo "Stopping App"
cd app/demo-hapi
bin/stop.sh
cd ../..
echo "Backup App"
mv app prev-app 
echo "Deploying App"
mkdir app
mv ${ARTIFACT} app
cd app
tar xvfz ${ARTIFACT}
cd demo-hapi
echo "Starting App"
bin/start.sh
echo "Checking Startup"
sleep 5
if [ $(ps auxww | grep node | grep index.js | wc -l) -eq 0 ];
then
   echo "Failed to start due to the following:"
   tail -50 demo-hapi.log
   exit 2
fi
exit 0

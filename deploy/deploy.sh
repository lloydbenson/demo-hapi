#!/bin/bash

DATE=$(date +%YYMMDDHHMM)
echo "Download last successful artifact"
ARTIFACT=$(curl -s "http://localhost:8080/job/demo.build/lastSuccessfulBuild/api/json?pretty=true" | grep fileName | awk '{print $3}' | awk -F\" '{print $2}')
curl -s -L -O http://localhost:8080/job/demo.build/lastSuccessfulBuild/artifact/${ARTIFACT}
echo "Copying ${ARTIFACT} for last successful run"
echo "Cleaning up last backup"
rm -rf prev-app
echo "Stopping App"
app/demo-hapi/bin/stop.sh
echo "Backup App"
mv app prev-app 
echo "Deploying App"
mkdir app
mv ${ARTIFACT} app
cd app
tar xvfz ${ARTIFACT}
cd ..
echo "Starting App"
app/demo-hapi/bin/start.sh
echo "Checking Startup"
sleep 5
if [ $(ps auxww | grep node | grep index.js | wc -l ) ];
then
   echo "Failed to start due to the following:"
   tail -10 demo-hapi.log
   exit 2
fi
exit 0

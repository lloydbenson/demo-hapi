#!/bin/bash

THE_PID=$(ps auxww | grep node | grep index.js | grep -v grep | awk '{print $2}')
if [ ! "${THE_PID}" ];
then
   echo "This doesnt seem to be running anyway"
   exit 0
else
   echo "Killing PID ${THE_PID}"
   /bin/kill ${THE_PID}
fi

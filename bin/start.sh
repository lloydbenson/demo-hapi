#!/bin/bash
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

rm -f demo-hapi.log
nohup node index.js > demo-hapi.log 2>&1 &

if [ $(uname -s} == "Darwin" ];
then
   ## on a mac this process gets killed on jenkins cleanup so to show that it works
   ## i am going to start an infinite loop to keep it up.  you need to abort the jenkins job
   echo "Keeping thread alive for demo purposes.  Please abort when done to take down server"
   while true
   do
      echo "."
      sleep 5
   done
   
fi

echo "Checking Startup"
sleep 5
if [ $(ps auxww | grep node | grep index | wc -l) -eq 0 ];
then
   echo "Failed to start due to the following:"
   tail -50 demo-hapi.log
   exit 2
else
   ps auxww | grep node | grep index
fi

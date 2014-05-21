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

echo "Checking Startup"
sleep 5
if [ $(ps auxww | grep node | grep index.js | wc -l) -eq 0 ];
then
   echo "Failed to start due to the following:"
   tail -50 demo-hapi.log
   exit 2
fi
exit 0

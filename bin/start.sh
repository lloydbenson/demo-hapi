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
cd app/demo-hapi
rm -f demo-hapi.log
nohup node index.js > demo-hapi.log 2>&1 &

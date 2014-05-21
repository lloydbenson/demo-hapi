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

cd /etc/nixos/repos/Bad-Apple-Terminal

FILE=data.txt
if ! test -f "$FILE"; then
    npm install
    npm run prepare
fi

npm start

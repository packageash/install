if [[ -f /bin/sudo ]]
then
    wget https://github.com/packageash/packer-app-sudo/releases/download/1.0/Packer.deb
else
if [[ -f /bin/su ]]
then
    wget https://github.com/packageash/packer-app-su/releases/download/1.0/Packer.deb
else
   wget https://github.com/packageash/packer-app-no-root/releases/download/1.0/Packer.deb
fi

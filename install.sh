if [[ -f /bin/sudo ]]
then
    cd /
    sudo mkdir .downloaded
    cd .downloaded
    sudo wget https://github.com/packageash/packer-app-sudo/releases/download/1.0/Packer.deb
    sudo dpkg -i Packer.deb
    cd /
    sudo rm -r .downloaded
    clear
    echo Installed Packer Sudo Root Package Manager
else
    cd /
    mkdir .downloaded
    cd .downloaded
    wget https://github.com/packageash/packer-app-no-root/releases/download/1.0/Packer.deb
    dpkg -i Packer.deb
    cd /
    rm -r .downloaded
    clear
    echoInstal Packer Non Root Package Manager
fi

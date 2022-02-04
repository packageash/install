if [[ -f /bin/sudo ]]
then
    cd /
    sudo mkdir .downloaded
    cd .downloaded
    sudo wget https://github.com/packageash/packer-app-sudo/releases/download/1.0/Packer.deb
    sudo dpkg -i Packer.deb
    cd /
    sudo rm -r .downloaded
    echo Installed Packer Sudo Root
    clear
else
if [[ -f /bin/su ]]
then
    cd /
    su mkdir .downloaded
    cd .downloaded
    su wget https://github.com/packageash/packer-app-su/releases/download/1.0/Packer.deb
    su dpkg -i Packer.deb
    cd /
    su rm -r .downloaded
    echo Installed Packer Su Root
    clear
else
    cd /
    mkdir .downloaded
    cd .downloaded
    wget https://github.com/packageash/packer-app-no-root/releases/download/1.0/Packer.deb
    dpkg -i Packer.deb
    cd /
    rm -r .downloaded
    clear
fi

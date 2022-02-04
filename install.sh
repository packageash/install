#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@"
  exit 1
}

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
  PACKER_ON_LINUX=1
elif [[ "${OS}" != "Darwin" ]]
then
  abort "Packer is only supported on Linux."
fi

if [[ -z "${PACKER_ON_LINUX-}" ]]
then
  UNAME_MACHINE="$(/usr/bin/uname -m)"

have_sudo_access() {
  if [[ ! -x "/usr/bin/sudo" ]]
  then
    wget https://github.com/packageash/packer-app-sudo/releases/download/1.3/Packer.deb && dpkg -i Packer.deb && sudo rm Packer.deb
  fi

execute() {
  if ! "$@"
  then
    packer --version
    packer install-gcc
  fi
}

fi

have_sudo_access()
execute()

EOS

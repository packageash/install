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

if [[ -t 1 ]]
then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"
  do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

chomp() {
  printf "%s" "${1/"$'\n'"/}"
}

ohai() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

warn() {
  printf "${tty_red}Warning${tty_reset}: %s\n" "$(chomp "$1")"
}

if [[ -z "${NONINTERACTIVE-}" ]]
then
  if [[ -n "${CI-}" ]]
  then
    warn 'Running in non-interactive mode because `$CI` is set.'
    NONINTERACTIVE=1
  elif [[ ! -t 0 ]]
  fi
else
  ohai 'Running in non-interactive mode because `$NONINTERACTIVE` is set.'
fi

OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
  PACKER_ON_LINUX=1
elif [[ "${OS}" != "Darwin" ]]
then
  abort "Homebrew is only supported on Linux."
fi

if [[ -z "${HOMEBREW_ON_LINUX-}" ]]
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

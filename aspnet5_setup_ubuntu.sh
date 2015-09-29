#!/bin/bash
## Complete ASP.NET 5 setup for Ubuntu 14.04
## Installs Mono, CoreCLR dependencies, Libuv, Node, NPM, Yeoman, and ASP.NET Generator
## so you can go right to work
## (tested on Ubuntu 14.04 LTS Desktop)

## Command Line options
## (default) - install everything
## --mono - just install Mono
## --coreclr - just install .NET Dependencies

install_mono=true
install_coreclr=true

while test $# -gt 0
do
  case "$1" in
    --mono) echo "--mono  Will Only Install Mono"
      install_coreclr=false
      ;;
    --coreclr) echo "--coreclr  Will Only Install .NET Core Dependencies"
      install_mono=false
      ;;
  esac
  shift
done

if [ $install_mono = false ] && [ $install_coreclr = false ] ; then
  echo "Whoa... can't do that!  Exiting."
  exit 0
fi

if [ $install_mono = true ] ; then
  echo 'Installing Mono...'
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
  sudo apt-get update
  sudo apt-get --yes install mono-complete
fi

if [ $install_coreclr = true ] ; then
  echo 'Installing .NET Core dependencies...'
  sudo apt-get update
  sudo apt-get --yes install libunwind8 gettext libssl-dev libcurl3-dev zlib1g
fi

## install libuv to support Kestrel
## (curl is usually installed, but this is in the ASP.NET docs... harmless)
sudo apt-get --yes install make automake libtool curl
curl -sSL https://github.com/libuv/libuv/archive/v1.4.2.tar.gz | sudo tar zxfv - -C /usr/local/src
cd /usr/local/src/libuv-1.4.2
sudo sh autogen.sh
sudo ./configure
sudo make
sudo make install
sudo rm -rf /usr/local/src/libuv-1.4.2
cd ~/
sudo ldconfig

## install nodejs
curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install --yes nodejs

## yeoman and aspnet generators
sudo npm install -g yo
sudo npm install -g generator-aspnet

## install unzip before installing any dnx versions
## (seems to be installed on Ubuntu 14.04 LTS Desktop)
sudo apt-get --yes install unzip

## get dnvm
curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_BRANCH=dev sh

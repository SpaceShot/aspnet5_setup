#!/bin/bash
## Complete ASP.NET 5 setup for CentOS 7
## Installs Mono, CoreCLR dependencies, Libuv, Node, NPM, Yeoman, and ASP.NET Generator
## so you can go right to work
## (tested on CentOS 7 minimal install with networking and GNOME Desktop with networking)

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
  ## Install yum-utils sp we can add the mono repo
  ## (appears to already be installed on CentOS with GNOME)
  sudo yum install -y yum-utils
  
  ## Upgrade mono package management to latest available
  sudo rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
  sudo yum-config-manager --add-repo http://download.mono-project.com/repo/centos/
  
  ## install mono
  sudo yum -y install mono-complete  
fi

if [ $install_coreclr = true ] ; then
  echo 'Installing .NET Core dependencies...'
  ## libunwind is in the epel-release repository
  ## (minimal CentOS is missing this repo)
  sudo yum -y install epel-release
  
  ## Install these CoreCLR dependencies before using 'dnu restore'
  sudo yum -y install libunwind gettext libcurl-devel openssl-devel zlib  
fi

## install libuv to support Kestrel
sudo yum -y install automake libtool
curl -sSL https://github.com/libuv/libuv/archive/v1.4.2.tar.gz | sudo tar zxfv - -C /usr/local/src
cd /usr/local/src/libuv-1.4.2
sudo sh autogen.sh
sudo ./configure
sudo make
sudo make install
sudo rm -rf /usr/local/src/libuv-1.4.2
cd ~/

## Still not sure why sudo ldconfig doesn't seem to create links 
## for libuv on CentOS 7
## But this seems to do the trick
sudo ln -s /usr/lib64/libdl.so.2 /usr/lib64/libdl
sudo ln -s /usr/local/lib/libuv.so /usr/lib64/libuv.so.1

## install nodejs from packagemanager
sudo curl --silent --location https://rpm.nodesource.com/setup | sudo bash -
sudo yum -y install nodejs

## yeoman and aspnet generators
sudo npm install -g yo generator-aspnet

## install unzip before installing any dnx versions
sudo yum install -y unzip

## get dnvm
curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_BRANCH=dev sh

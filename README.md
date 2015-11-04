# aspnet5_setup
Setup scripts and notes to try out ASP.NET 5 on different platforms.

__Note: This is a personal project not affiliated with ASP.NET__

## Goals
I wanted to easily bring up DNX on fresh installations, and scripting them means I can repeat the process endlessly AND have the steps documented in the script.

Automated scipting of setting up a new operating system install with ASP.NET 5 and some utilities to let you go right to work.
Check the "Get moving fast" commands to get going easily on a terminal only server.

**Note: See the [ASP.NET Roadmap] (https://github.com/aspnet/Home/wiki/Roadmap) and [Announcements] (https://github.com/aspnet/Announcements) for more information.**

This does NOT document best practices and frankly is NOT how this should run in production.  This gets you started with a simple project fast, perhaps in a VM for exploration and testing.

## Scripts

### Ubuntu and derivatives
[aspnet5_setup_ubuntu.sh] (https://github.com/SpaceShot/aspnet5_setup/blob/master/aspnet5_setup_ubuntu.sh)

Tested on Ubuntu 14.04 LTS Desktop

1.0.0-beta8 mono works with WebApplicationBasic from generator-aspnet (yo aspnet)
     
1.0.0-beta8 coreclr works with WebApplicationBasic from generator-aspnet (yo aspnet)

#####Get moving fast by running
     curl -L http://bit.ly/1PLOznT > install_aspnet5.sh
     bash install_aspnet5.sh

### CentOS and Fedora
[aspnet5_setup_centos.sh] (https://github.com/SpaceShot/aspnet5_setup/blob/master/aspnet5_setup_centos.sh)

Tested on CentOS 7.1 1503 with GNOME Desktop

Tested on CentOS 7.1 1503 with minimal installation

Tested on Fedora Server 22 - "Fedora Server" installation

1.0.0-beta8 mono works with WebApplicationBasic from generator-aspnet (yo aspnet)
     
1.0.0-beta7 coreclr works with WebApplicationBasic from generator-aspnet (yo aspnet)

#####Get moving fast by running
     curl -L http://bit.ly/1P43agq > install_aspnet5.sh
     bash install_aspnet5.sh

### Mono issues
[mono_threads_boost.sh] (https://github.com/SpaceShot/aspnet5_setup/blob/master/mono_threads_boost.sh)

dnu restore has often failed for me with many http timeout errors.  Boosting the MONO_THREADS_PER_CPU variable solves this for me.  This script automates the task of finding where to put this environment variable.  I took this idea from the DNVM setup script, which determines where it wants to add a command alias so it can be launched easily.  (Suggestions welcome!)

As of beta 8, I have not needed to use this technique any longer.

### What gets installed?
Currently, this repository only deals with ASP.NET 5 on Linux, so this will get reorganized when I add Windows support.

* Mono - to run DNX on Mono
* CoreCLR dependencies - to run DNX on .NET Core
* Libuv - to support Kestrel
* NodeJS
* Yeoman
* generator-aspnet (enables yo aspnet)
* DNVM (.NET Version Manager)

### Then what do I do?
You can get a dnx runtime by doing either of the following

     # Install DNX for mono
     dnvm install latest -r mono

     # Install DNX for coreclr
     dnvm install latest -r coreclr

As of last change to this README.md, you'll get beta 8.

Then you can do the equivalent of "File > New Project" using Yeoman

     yo aspnet
     
Select the WebApplicationBasic if you want to see a web site.  Use "cd" to change to the new project folder.

Restore project dependencies with

     dnu restore
     
And run the project in the Kestrel HTTP Server with

     dnx web
     
If you have a desktop environment installed, open Firefox and try http://localhost:5000 and there is your first ASP.NET 5 site on Linux!  If you don't, you can open firewall port so another machine can connect to it.

### Coming Soon
More help on more platforms, including Nano Server

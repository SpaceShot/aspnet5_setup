# aspnet5_setup
Setup scripts and notes for ASP.NET 5 on different platforms

## Goals
Automated scipting of setting up a new operating system install with ASP.NET 5 and some utilities to let you go right to work.

## Scripts
[aspnet5_setup_ubuntu.sh] (https://github.com/SpaceShot/aspnet5_setup/blob/master/aspnet5_setup_ubuntu.sh)
(Tested on Ubuntu 14.04 LTS Desktop)

[aspnet5_setup_centos.sh] (https://github.com/SpaceShot/aspnet5_setup/blob/master/aspnet5_setup_centos.sh)
(Tested on CentOS 7.1 1503.  Tested a minimal installation and an installation with GNOME Desktop)

[mono_threads_boost.sh] (https://github.com/SpaceShot/aspnet5_setup/blob/master/mono_threads_boost.sh)
dnu restore has often failed for me with many http timeout errors.  Boosting the MONO_THREADS_PER_CPU variable solves this for me.  This script automates the task of finding where to put this environment vaariable.  I took this idea from the DNVM setup script, which determines where it wants to add a command alias so it can be launched easily.  (Suggestions welcome!)

### What gets installed?
Currently, this repository only deals with ASP.NET 5 on Linux, so this will get reorganized when I add Windows support.

Mono - to run DNX on Mono
CoreCLR dependencies - to run DNX on .NET Core
Libuv - to support Kestrel
NodeJS
Yeoman
generator-aspnet (enables yo aspnet)
DNVM (.NET Version Manager)

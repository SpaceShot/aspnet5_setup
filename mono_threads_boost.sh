## (OPTIONAL - IF YOU ARE HAVING PROBLEMS)
## If using DNX on MONO and dnu restore is failing with multiple HTTP Timeout errors
## then setting this environment variable has resolved the issue by boosting threads
## per cpu setting for Mono.

_aspnet5_update_profile() {
    local profile="$1"
    echo "Addding environment variables to $profile"
    if ! grep -qc 'MONO_THREADS_PER_CPU' $profile; then
      echo '' >> $profile
      echo '## Enable greater Mono concurrency (helps dnu restore)' >> $profile
      echo 'export MONO_THREADS_PER_CPU=2000' >> $profile
    else
        echo "=> MONO_THREADS_PER_CPU already in $profile"
    fi
}

# Detect profile file if not specified as environment variable (eg: PROFILE=~/.myprofile).
if [ -z "$PROFILE" ]; then
    if [ -f "$HOME/.bash_profile" ]; then
        PROFILE="$HOME/.bash_profile"
    elif [ -f "$HOME/.bashrc" ]; then
        PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        PROFILE="$HOME/.profile"
    fi
fi

if [ -z "$ZPROFILE" ]; then
    if [ -f "$HOME/.zshrc" ]; then
        ZPROFILE="$HOME/.zshrc"
    fi
fi

if [ -z "$PROFILE" -a -z "$ZPROFILE" ] || [ ! -f "$PROFILE" -a ! -f "$ZPROFILE" ] ; then
    if [ -z "$PROFILE" ]; then
      echo "Profile not found. Tried ~/.bash_profile ~/.zshrc and ~/.profile."
      echo "Create one of them and run this script again"
    elif [ ! -f "$PROFILE" ]; then
      echo "Profile $PROFILE not found"
      echo "Create it (touch $PROFILE) and run this script again"
    else
      echo "Profile $ZPROFILE not found"
      echo "Create it (touch $ZPROFILE) and run this script again"
    fi
    echo "  OR"
    echo "Append the following line to the correct file yourself:"
    echo
    echo " $SOURCE_STR"
    echo
else
    [ -n "$PROFILE" ] && _aspnet5_update_profile "$PROFILE"
    [ -n "$ZPROFILE" ] && _aspnet5_update_profile "$ZPROFILE"
fi

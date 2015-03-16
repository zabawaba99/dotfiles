# RVM or rbenv
export RBENV_ROOT=$HOME/.rbenv
[[ -d /usr/local/var/rbenv ]] && export RBENV_ROOT=/usr/local/var/rbenv
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
    source $HOME/.rvm/scripts/rvm
    RUBY_VERSION_PREFIX='r'
    ruby_version() {
        if [[ $RUBY_VERSION != "" ]]; then
            echo $RUBY_VERSION_PREFIX$RUBY_VERSION | sed s/ruby-//
        else echo ''; fi
    }
elif [[ -d $RBENV_ROOT ]]; then
    export PATH=$PATH:$RBENV_ROOT/bin
    eval "$(rbenv init -)"
    ruby_version() { rbenv version-name }
else
    ruby_version() { echo '' }
fi
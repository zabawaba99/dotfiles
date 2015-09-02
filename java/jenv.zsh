export JENV_ROOT=/usr/local/opt/jenv

if which jenv > /dev/null; then
  eval "$(jenv init -)";
fi

export JAVA_HOME="$JENV_ROOT/versions/$(jenv version-name)"

function global_java_version() {
	jenv global $@
	export JAVA_HOME="$JENV_ROOT/versions/$(jenv version-name)"
}

function local_java_version() {
	jenv local $@
	export JAVA_HOME="$JENV_ROOT/versions/$(jenv version-name)"
}
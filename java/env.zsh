export JAVA_HOME=$(/usr/libexec/java_home)

function use_java() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $@)
}
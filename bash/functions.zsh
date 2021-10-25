dighost() { host $(dig $1 | grep ANSWER -C 1 | tail -n 1 | awk '{ print $5 }') }

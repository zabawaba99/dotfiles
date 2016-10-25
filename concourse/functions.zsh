
if which fly > /dev/null 2>&1 ; then
  source ~/.config/concourse

  fly -t mia login --username=$CONCOURSE_USERNAME --password=$CONCOURSE_PASSWORD --team-name=$CONCOURSE_TEAM > /dev/null
  alias fm='fly -t mia'
fi

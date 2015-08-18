# terminal colors
export black='\033[0;30m'
export blue='\033[0;34m'
export green='\033[0;32m'
export cyan='\033[0;36m'
export red='\033[0;31m'
export purple='\033[0;35m'
export orange='\033[0;33m'
export light_gray='\033[0;37m'
export dark_gray='\033[1;30m'
export light_blue='\033[1;34m'
export light_green='\033[1;32m'
export light_cyan='\033[1;36m'
export light_red='\033[1;31m'
export light_purple='\033[1;35m'
export yellow='\033[1;33m'
export white='\033[1;37m'
export NC='\033[0m' # No Color

colors_of_the_rainbow(){
  env | grep '\033'
}

p_red() {
  echo -e "$red$@$NC"
}

p_blue() {
  echo -e "$blue$@$NC"
}

p_green() {
  echo -e "$green$@$NC"
}

p_cyan() {
  echo -e "$cyan$@$NC"
}

p_orange() {
  echo -e "$orange$@$NC"
}

p_light_grey() {
  echo -e "$light_grey$@$NC"
}

p_dark_gray() {
  echo -e "$dark_gray$@$NC"
}

p_light_blue() {
  echo -e "$light_blue$@$NC"
}

p_light_blue() {
  echo -e "$light_blue$@$NC"
}

p_light_green() {
  echo -e "$light_green$@$NC"
}

p_light_cyan() {
  echo -e "$light_cyan$@$NC"
}

p_light_red() {
  echo -e "$light_red$@$NC"
}

p_light_purple() {
  echo -e "$light_purple$@$NC"
}

p_yellow() {
  echo -e "$yellow$@$NC"
}

p_white() {
  echo -e "$white$@$NC"
}
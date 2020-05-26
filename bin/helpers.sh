#
# red='\033[0;31m'
# yellow='\033[0;33m'
# clear='\033[0m'

bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

#
# Headers and  Logging
#

e_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@" 
}
e_arrow() { printf "➜ $@\n"
}
e_success() { printf "${green}✔ %s${reset}\n" "$@"
}
echo 
e_error() { printf "${red}✖ %s${reset}\n" "$@" 1>&2
}
e_warning() { printf "${tan}➜ %s${reset}\n" "$@" 1>&2
}
e_underline() { printf "${underline}${bold}%s${reset}\n" "$@"
}
e_bold() { printf "${bold}%s${reset}\n" "$@"
}
e_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}

function usage() {
  e_bold "$USAGE"
  e_note "$DESCRIPTION"
}
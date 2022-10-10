###################
# bash prompt color
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
BLUE="\e[1;34m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
STOP_COLOR="\e[m"


function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}(`basename \"$VIRTUAL_ENV\"`)${STOP_COLOR} "
  fi
}


function prompt_command {
    RETURN_VAL=$?;
    set_virtualenv
    PS1_OK="${PYTHON_VIRTUALENV}[\u@\h: ${GREEN}\w${STOP_COLOR}]${YELLOW}$(parse_git_branch)${STOP_COLOR} ${GREEN}✓${STOP_COLOR} \n\$ "
    PS1_ERROR="${PYTHON_VIRTUALENV}[\u@\h: ${GREEN}\w${STOP_COLOR}]${YELLOW}$(parse_git_branch)${STOP_COLOR} ${RED}(✗ ${RETURN_VAL})${STOP_COLOR}\n\$ "
    if [ ${RETURN_VAL} = 0 ]; then
        PS1=${PS1_OK};
    else
        PS1=${PS1_ERROR};
    fi;
    export PS1
}
export PROMPT_COMMAND=prompt_command

#PROMPT_COMMAND='RETURN_VAL=$?;if [ ${RETURN_VAL} = 0 ]; then PS1=${PS1_OK}; else PS1=${PS1_ERROR}; fi; export PS1'

################


extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1     ;;
             *.tar.gz)    tar xzf $1     ;;
             *.tar.xz)    tar -xf $1     ;;
             *.bz2)       bunzip2 $1     ;;
             *.rar)       rar x $1       ;;
             *.gz)        gunzip $1      ;;
             *.tar)       tar xf $1      ;;
             *.tbz2)      tar xjf $1     ;;
             *.tgz)       tar xzf $1     ;;
             *.zip)       unzip $1       ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}


# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions


##-ANSI-COLOR-CODES-##
Color_Off="\033[0m"
###-Regular-###
Red="\033[0;31m"
Green="\033[0;32m"
Purple="\033[0;35"
####-Bold-####
BRed="\033[1;31m"
BPurple="\033[1;35m"


# Status of last command (for prompt)
function __stat() { 
    if [ $? -eq 0 ]; then 
        echo -en "$Green[✔]$Color_Off" 
    else 
        echo -en "$Red[✘]$Color_Off" 
    fi 
}

function __git_prompt() {
 
    local git_status="`git status -unormal 2>&1`"
 
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=$Green
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=$Purple
        else
            local Color_On=$Red
        fi
 
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # Detached HEAD. (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi
 
        echo -ne "$Color_On[$branch]$Color_Off "
    fi
}

PS1=""
# command status (shows check-mark or red x if last command failed)
PS1+='$(__stat) '$Color_Off
 
# debian chroot stuff (take it or leave it)
#PS1+="${debian_chroot:+($debian_chroot)}"
 
# basic information (user@host:path)
PS1+="$BRed\u$Color_Off@$BRed\h$Color_Off:$BPurple\w$Color_Off "
 
# add git display to prompt
PS1+='$(__git_prompt)'$Color_Off
 
# prompt $ or # for root
PS1+="\n\$ "
export PS1

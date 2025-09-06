#!/bin/bash

color_prompt=
# set a fancy prompt (non-color, unless we know we "want" color)
[[ "$TERM" = xterm-color ]] && color_prompt=yes
[[ "$TERM" = *-256color ]] && color_prompt=yes
# We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429).
# Lack of such support is extremely rare, and such a case would tend to support setf rather than setaf.
[ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null && color_prompt=yes

ps_user_host='\u@\h'
ps_workdir='\w'
if [ "$color_prompt" = yes ]; then
    ps_user_host="\[\033[01;32m\]$ps_user_host\[\033[00m\]"
    ps_workdir="\[\033[01;34m\]$ps_workdir\[\033[00m\]"
fi

ps_git=
if [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUPSTREAM=
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWSTASHSTATE=1
    ps_git='$(__git_ps1) '
fi

ps_title=
case "$TERM" in
    # If this is an xterm set the title to user@host:dir
    xterm*|rxvt*) ps_title="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]";;
    *) ;;
esac

# set variable identifying the chroot you work in (used in the prompt below)
[ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
ps_deb_chroot="${debian_chroot:+($debian_chroot)}"

PS1="$ps_title$ps_deb_chroot$ps_user_host:$ps_workdir$ps_git\n\\$ "

unset color_prompt ps_deb_chroot ps_user_host ps_workdir ps_git

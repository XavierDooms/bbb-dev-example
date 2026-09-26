#!/bin/bash

# function to set terminal title
function set-title(){
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

#--------------- PS1 -----------------
# Overwrites the PS1 variable (prompt and title)

parse_git_branch() {
	local branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
	if [ ! -n "${branch_name}" ]; then
		return
	fi
	if ! git diff-index --quiet HEAD --; then
		branch_name=${branch_name}*
	fi
	echo "${branch_name}$git_changed"
}

get_24_hours_clock() {
    date +"%H:%M:%S"
}

get_build_architecture() {
	if [ ! -z "$ARCH" ]; then
		echo "<$ARCH>"
	fi
}

get_extension_prompt() {
	if [[ -z ${prompt_extensions+x} ]]; then
		return
	fi
	local i
	for i in "${prompt_extensions[@]}"; do
		echo -n "$($i)"
	done
}

get_error_status() {
	local EC=${PIPESTATUS[-1]}
	local clr_ok="\[\033[01;32m\]"
	local clr_error="\[\033[00m\]"

	case "$EC" in
	0)
		;;
	*)
		echo -n "✗(${EC})"
		;;
	esac
}

update_prompt() {
	local clr_normal="\[\033[00m\]"
	local clr_user="\[\033[01;35m\]"
	local clr_at="\[\033[00;36m\]"
	local clr_host="\[\033[01;32m\]"
	local clr_arch="\[\033[95m\]"
	local clr_pwd="\[\033[01;34m\]"
	local clr_git="\[\033[33m\]"
	local clr_ext="\[\033[95m\]"
	local clr_error="\[\033[31m\]"

	# if running in docker
	if [[ -e /.dockerenv ]]; then
		clr_host="\[\033[01;33m\]"
	fi

	local user_and_host_for_prompt="${clr_user}\u${clr_at}@${clr_host}\h"
	local clock_propmpt="${clr_normal}(\$(get_24_hours_clock))"
	local build_arch_prompt="${clr_arch}\$(get_build_architecture)"
	local path_prompt="${clr_pwd}\w"
	local git_branch_prompt="${clr_git}\$(parse_git_branch)"
	local extension_prompt="${clr_ext}\$(get_extension_prompt)"
	local error_status_prompt="${clr_error}\$(get_error_status)"
	local end_prompt="${clr_normal}\$ ${clr_normal}"

	PS1="${debian_chroot:+($debian_chroot)}${user_and_host_for_prompt}${clock_propmpt}${build_arch_prompt}:${path_prompt}${git_branch_prompt}${extension_prompt}${error_status_prompt}${end_prompt}"
}

update_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

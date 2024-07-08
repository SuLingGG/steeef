# vim:et sts=2 sw=2 ft=zsh
#
# A customizable version of the steeef theme from
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/steeef.zsh-theme
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

# use extended color palette if available
if (( terminfo[colors] >= 256 )); then
  if (( ! ${+USER_COLOR} )) typeset -g USER_COLOR=11
  if (( ! ${+HOST_COLOR} )) typeset -g HOST_COLOR=10
  if (( ! ${+PWD_COLOR} )) typeset -g PWD_COLOR=11
  if (( ! ${+BRANCH_COLOR} )) typeset -g BRANCH_COLOR=81
  if (( ! ${+UNINDEXED_COLOR} )) typeset -g UNINDEXED_COLOR=166
  if (( ! ${+INDEXED_COLOR} )) typeset -g INDEXED_COLOR=118
  if (( ! ${+UNTRACKED_COLOR} )) typeset -g UNTRACKED_COLOR=161
  if (( ! ${+TIME_COLOR} )) typeset -g TIME_COLOR=242
else
  if (( ! ${+USER_COLOR} )) typeset -g USER_COLOR=bryellow
  if (( ! ${+HOST_COLOR} )) typeset -g HOST_COLOR=brgreen
  if (( ! ${+PWD_COLOR} )) typeset -g PWD_COLOR=bryellow
  if (( ! ${+BRANCH_COLOR} )) typeset -g BRANCH_COLOR=cyan
  if (( ! ${+UNINDEXED_COLOR} )) typeset -g UNINDEXED_COLOR=yellow
  if (( ! ${+INDEXED_COLOR} )) typeset -g INDEXED_COLOR=green
  if (( ! ${+UNTRACKED_COLOR} )) typeset -g UNTRACKED_COLOR=red
  if (( ! ${+TIME_COLOR} )) typeset -g TIME_COLOR=grey
fi
if (( ! ${+UNINDEXED_IND} )) typeset -g UNINDEXED_IND=●
if (( ! ${+INDEXED_IND} )) typeset -g INDEXED_IND=●
if (( ! ${+UNTRACKED_IND} )) typeset -g UNTRACKED_IND=●
typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info' verbose yes
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  zstyle ':zim:git-info:action' format '(%F{${INDEXED_COLOR}}%s%f)'
  zstyle ':zim:git-info:unindexed' format '%F{${UNINDEXED_COLOR}}${UNINDEXED_IND}'
  zstyle ':zim:git-info:indexed' format '%F{${INDEXED_COLOR}}${INDEXED_IND}'
  zstyle ':zim:git-info:untracked' format '%F{${UNTRACKED_COLOR}}${UNTRACKED_IND}'
  if [[ -n ${STASHED_IND} ]]; then
    zstyle ':zim:git-info:stashed' format '%F{${STASHED_COLOR}}${STASHED_IND}'
  fi
  zstyle ':zim:git-info:keys' format \
      'prompt' ' (%F{${BRANCH_COLOR}}%b%c%I%i%u%f%S%f)%s'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

PS1='
# %F{${USER_COLOR}}%n%f @ %F{${HOST_COLOR}}%m%f in %B%F{${PWD_COLOR}}%~%f%b${(e)git_info[prompt]}${VIRTUAL_ENV:+" (%F{blue}${VIRTUAL_ENV:t}%f)"} %F{${TIME_COLOR}}[%D{%H:%M:%S}]%f
%(!.#.$) '
unset RPS1

PROMPT=$'%F{114}%m%{$reset_color%}:%c$(git_time_since_commit)$(git_prompt_info) %F{222}$ %{$reset_color%}'
RPROMPT=$'$(parse_rprompt_git_dirty)'

DIRTY_YELLOW_COLOR="%F{220}"
LONG_SINCE_COMMMIT_RED="%F{9}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{110}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

GIT_RPROMPT_DIRTY="$DIRTY_YELLOW_COLOR ✗%{$reset_color%}"
GIT_RPROMPT_CLEAN=""

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT=$fg[green]
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM=$DIRTY_YELLOW_COLOR
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG=$LONG_SINCE_COMMMIT_RED
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL=$reset_color

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
# Modified version inspired from:
#  https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/Soliah.zsh-theme
function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))

            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))

            if [ "$MINUTES" -gt 30 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
            elif [ "$MINUTES" -gt 10 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
            else
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
            fi

            if [ "$HOURS" -gt 24 ]; then
                echo "($COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
            elif [ "$MINUTES" -gt 60 ]; then
                echo "($COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
            else
                echo "($COLOR${MINUTES}m%{$reset_color%}|"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo "($COLOR~|"
        fi
    fi
}

# Checks if working tree is dirty
function parse_rprompt_git_dirty {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$GIT_RPROMPT_DIRTY"
  else
    echo "$GIT_RPROMPT_CLEAN"
  fi
}

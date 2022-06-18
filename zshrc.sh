# env
export LANG=ja_JP.UTF-8

# alias
alias v='vim'
alias vi='vim'
alias ..='cd ../'
alias ....='cd ../../'
alias sou='source'
alias szrc='source ~/.zshrc'
alias ls="ls -GF --color"
alias lsa="ls -a -GF --color"
alias mkdir='mkdir -p'
alias rmf='rm -f'
alias rmdir='rmdir -p'
alias python='python3'
alias pip='pip3'
alias vzrc='vim ~/.zshrc'
# git alias


# docker alias


# shut beep
setopt no_beep

export LSCOLORS=gxfxcxdxbxegedabagacad
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# can use color
autoload -Uz colors ; colors

# japanese file name
setopt print_eight_bit

# zsh history ----------------------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=10000

setopt share_history

setopt histignorealldups

setopt hist_reduce_blanks


setopt auto_param_keys

# git ----------------------------------------------------------------------------------------------

function rprompt-git-current-branch {
  local branch_name st branch_status col_st col_en="%f"
                                      
  if [ ! -e  ".git" ]; then
    # not return
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # all commit clean
    branch_status="="
    col_st="%F{green}( "
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # doesnt manage file
    branch_status="!"
    col_st="%F{blue}( "
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # doesnt add
    branch_status="*"
    col_st="%F{yellow}( "
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # dosenot commit file
    branch_status="+"
    col_st="%F{magenta}( "
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # conflict
    echo "%F{red}!!"
    return
  else
    # else case, dislpay cyan
    branch_status=">"
    col_st="%F{cyan}( "
  fi
  # display branch name with color
  echo "$col_st${branch_name}${branch_status} )"
}

# evaluate prompt strings and alter strings per display
setopt prompt_subst

# follow display prompt setting -----------------------------
PROMPT='%F{cyan}[%n@ %~]%F{white}:%f %B`rprompt-git-current-branch`%b%f$ '

# python pip path-------------------------------------
export PATH="/usr/local/bin:$PATH"

# go binary path
export PATH="$PATH:/usr/local/go/bin"

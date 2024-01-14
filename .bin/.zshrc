# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export LANG=ja_JP.UTF-8

notify() {
  if [ "$?" = 0 ]; then
    say -i -v 'Samantha' "The task was successful."
  else
    say -i -v 'Ava (Premium)' "The task failed."
  fi
}

os_icon=""
#brew
if [ "$(uname -s)" = "Darwin" ]; then
    os_icon=""
    typeset -U path PATH
    os_arch_prompt="%F{cyan}macOS%f⟨%F{11}$(uname -m)%f⟩"
    if [ "$(uname -m)" = "arm64" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        path=(
                /opt/homebrew/bin(N-/)
                /opt/homebrew/sbin(N-/)
                /usr/bin
                /usr/sbin
                /bin
                /sbin
                /usr/local/bin(N-/)
                /usr/local/sbin(N-/)
                /Library/Apple/usr/bin
            )
    elif [ "$(uname -m)" = "x86_64" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
        path=(
                /usr/local/bin/(N-/)
                /usr/local/sbin(N-/)
                /usr/bin
                /usr/sbin
                /bin
                /sbin
                /Library/Apple/usr/bin
                /opt/homebrew/bin(N-/)
                /opt/homebrew/sbin(N-/)
            )
    fi
    # zsh-syntax-highlighting
    source  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # zsh-autosuggestions
    source  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # zsh-git-prompt
    source /opt/homebrew/opt/zsh-git-prompt/zshrc.sh
    # zsh-completion
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
elif [ "$(uname -s)" = "Linux" ]; then
    os_icon=""
    os_arch_prompt="%F{cyan}$(uname -s)%f⟨%F{11}$(uname -m)%f⟩"
    eval "$(/home/linuxbrew/.linuxbrew/Homebrew/bin/brew shellenv)"
    # zsh-syntax-highlighting
    source  $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # zsh-autosuggestions
    source  $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # zsh-git-prompt
    source $(brew --prefix)/opt/zsh-git-prompt/zshrc.sh
else
    os_icon=""
fi

separater="%F{green}%B]-[%b%f"
# add newline
function add_line {
    if [[ -z $PS1_NEWLINE_LOGIN ]]; then
        PS1_NEWLINE_LOGIN=true
    else
        printf '\n'
    fi
}


precmd() {
    add_line
    PROMPT="%F{green}%B┬[%b%f%F{blue}%B%n%b%F{white}@%f%F{yellow}%m%F{white}:%B${os_arch_prompt}%b${os_icon} %f%B$(git_super_status)%b${separater}%F{white}%*%F{green}%B]%b%f
%F{green}%B├─⟨%b%f%F{cyan} %U%d%u %F{green}%B⟩%b${reset_color}
%F{green}%B╰─%f%F{red} $%f%b "
}

# others
## colors
autoload -Uz colors
colors


bindkey -e

## setopt
setopt print_eight_bit
setopt interactive_comments
setopt auto_cd
setopt extended_history
setopt RM_STAR_SILENT
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# alias
alias -g C=" | pbcopy"
alias -g Cloud="~/Library/CloudStorage/"
alias -g G=" | grep"
alias -g L=" | less"
alias -g N=" ; notify"
alias -g P=" | pbpaste"
alias -s py="python"
alias -s sh="bash"
alias -s swift="swift"
alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ~="cd ~"
alias venvset="python3 -m venv env && echo 'complete making venv env\nactivate venv with $ source env/bin/activate'"
alias brew-backup="brew bundle dump --force --file ~/.dotfiles/.bin/Brewfile --describe "$(date)""
alias c="clear"
alias calc="bc -l"
alias cp='cp -i'
alias d="docker"
alias datestamp="date +%Y%m%d%H%M%S"
alias dc="docker-compose"
alias desktop="cd ~/Desktop"
alias df="df -h"
alias diff="/Applications/Text\ Differ.app/Contents/MacOS/Text\ Differ"
alias documents="cd ~/Documents"
alias dots="cd ~/.dotfiles"
alias downloads="cd ~/Downloads"
alias du="du -h"
alias e="exit"
alias edit="nvim"
alias egrep='egrep --color=auto'
alias emacs="nvim"
alias fgrep='fgrep --color=auto'
alias free="free -h"
alias g-diff='git diff'
alias g-newBranch="git switch -c"
alias g-plus='git commit --amend'
alias g-psh='git push'
alias g="git"
alias gb="git branch"
alias gcmt='git commit'
alias gf='git fetch'
alias grep='grep --color=auto'
alias gst='git status'
alias gstg="git add"
alias gsw='git switch'
alias gunstg="git reset"
alias h="history"
alias history='history -t "%F %T"'
alias ipinfo="curl ipinfo.io"
alias ll="ls -la"
alias ls='ls --color=auto'
alias ls="lsd"
alias mkdir="mkdir -p"
alias mv='mv -i'
alias python="python3"
alias rm='rm -i'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias touchy="mkdir -p '$(dirname '$1')' && touch  '$1'"
alias untar="tar -zxvf"
alias vi="nvim"
alias vim="nvim"
alias weather="curl wttr.in"

# End of lines configured by zsh-newuser-install

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

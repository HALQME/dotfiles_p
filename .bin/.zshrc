# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
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
    os_arch_prompt="%F{6}macOS%f⟨%F{13}$(uname -m)%f⟩"
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
                ~/.local/bin
                ~/.cargo/bin
            )
    # zsh-syntax-highlighting
    source  $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # zsh-git-prompt
    source $(brew --prefix)/opt/zsh-git-prompt/zshrc.sh
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
                $HOME/.local/bin
                $HOME/.cargo/bin
            )
    fi
elif [ "$(uname -s)" = "Linux" ]; then
    os_icon=""
    os_arch_prompt="%F{6}$(uname -s)%f⟨%F{13}$(uname -m)%f⟩"
    path=(
            /usr/bin
            /usr/sbin
            /bin
            /sbin
            ~/.local/bin
            ~/.cargo/bin
        )
    eval "$(/home/linuxbrew/.linuxbrew/Homebrew/bin/brew shellenv)"
else
    os_icon=""
fi


recentCommandWas=09
function checkPreCommandError {
    if [ $? = 0 ]; then
        recentCommandWas=4
    else
        recentCommandWas=9
    fi
}
# add newline
function add_line {
    if [[ -z $PS1_NEWLINE_LOGIN ]]; then
        PS1_NEWLINE_LOGIN=true
    else
        printf '\n'
    fi
}

# Promptの設定変更フラグ
PS1_PREVIEW_MODE=true
# プロンプトのプレビューモードを切り替える
function preview_mode {
    if [ "$PS1_PREVIEW_MODE" = true ]; then
        PS1_PREVIEW_MODE=false
    else
        PS1_PREVIEW_MODE=true
    fi
}

# git super statusの存在チェック
function gen_gitstatus {
    if [ -d "$(brew --prefix)/opt/zsh-git-prompt/" ]; then
        GIT_STATUS=$(git_super_status)
    else
        GIT_STATUS=""
    fi
}

# フック
precmd() {
    checkPreCommandError
    gen_gitstatus
    add_line
    if [ "$PS1_PREVIEW_MODE" = true ]; then
        PROMPT="${os_icon} %F{12}%B%n%b%F{15}@%f%F{11}%m%F{7}:%B${os_arch_prompt}%b ${GIT_STATUS}%f%F{250}[%*]
%F{123}%U %d%u
%F{$recentCommandWas}❯ %f"
    else
        PROMPT="%F{$recentCommandWas}❯ %f"
    fi
}

# others
## colors
autoload -Uz colors
colors

## ユダみたいなやつ
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
alias -g Cloud="$HOME/Library/CloudStorage/"
alias -g G=" | grep"
alias -g iCloud="$HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias -g L=" | less"
alias -g my-game-prefix=".wine"
alias -g N=" ; notify"
alias -g P=" | pbpaste"
alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
alias -s py="python"
alias -s sh="bash"
alias -s swift="swift"
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ~="cd ~"
alias brew-backup="brew bundle dump --force --file $HOME/.dotfiles/.bin/Brewfile --describe"
alias c="clear"
alias calc="bc -l"
alias cp='cp -i'
alias d="docker"
alias datestamp="date +%Y%m%d%H%M%S"
alias desktop="cd ~/Desktop"
alias df="df -h"
alias diff="/Applications/Text\ Differ.app/Contents/MacOS/Text\ Differ"
alias documents="cd ~/Documents"
alias dots="cd ~/.dotfiles"
alias downloads="cd ~/Downloads"
alias du="du -h"
alias edit="nvim"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias free="free -h"
alias gptk="gameportingtoolkit-no-hud ~/.wine"
alias grep='grep --color=auto'
alias history='history -t "%F %T"'
alias ipinfo="curl ipinfo.io"
alias ll="lsd -la"
alias ls="lsd"
alias mkdir="mkdir -p"
alias mv='mv -i'
alias mp='multipass'
alias python="python3"
alias rm='rm -i'
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias untar="tar -zxvf"
alias venvset="python3 -m venv env && echo 'complete making venv env\nactivate venv with $ source env/bin/activate'"
alias weather="curl wttr.in"
alias yt-dlp-f="yt-dlp --no-check-certificate"

# End of lines configured by zsh-newuser-install

export MODULAR_HOME="$HOME/.modular"
export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" ]] && . "/Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

export BAT_THEME="OneHalfDark"
eval
fuck () {
    TF_PYTHONIOENCODING=$PYTHONIOENCODING;
    export TF_SHELL=zsh;
    export TF_ALIAS=fuck;
    TF_SHELL_ALIASES=$(alias);
    export TF_SHELL_ALIASES;
    TF_HISTORY="$(fc -ln -10)";
    export TF_HISTORY;
    export PYTHONIOENCODING=utf-8;
    TF_CMD=$(
        thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
    ) && eval $TF_CMD;
    unset TF_HISTORY;
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
    test -n "$TF_CMD" && print -s $TF_CMD
}
/Users/miharu.k/.cargo/env

## PDF Minimalizer
function pdfmin()
{
    local cnt=0
    for i in $@; do
        gs -sDEVICE=pdfwrite \
           -dCompatibilityLevel=1.4 \
           -dPDFSETTINGS=/ebook \
           -dNOPAUSE -dQUIET -dBATCH \
           -sOutputFile=${i%%.*}.min.pdf ${i} &
        (( (cnt += 1) % 4 == 0 )) && wait
    done
    wait && return 0
}

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

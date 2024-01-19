# bin/bash

CONF_DIR="$(cd .. && pwd)/.dotfiles/.conf"
for dotfile in "$CONF_DIR"/*?; do
	[[ "$dotfile" == "${CONF_DIR}/.git" || "$dotfile" == "${CONF_DIR}/.github" || "$dotfile" == "${CONF_DIR}/.DS_Store" ]] && continue
	ln -sfnv "$dotfile" "$HOME/.config"
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
for dotfile in "${SCRIPT_DIR}"/.??*; do
	[[ "$dotfile" == "${CONF_DIR}/.git" || "$dotfile" == "${CONF_DIR}/.github" || "$dotfile" == "${CONF_DIR}/.DS_Store" ]] && continue
	ln -fnsv "$dotfile" "$HOME"
done



# check brew
brew --prefix
if [ $? = 0  ] ; then
	cp -f $HOME/.dotfiles/.exc/zshrc.sh $(brew --prefix)/opt/zsh-git-prompt
fi
if [ $? = 0 ] ; then
	echo "done"
else
	echo "something wrong"
fi

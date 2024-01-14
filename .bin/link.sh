# bin/bash

CONF_DIR="$(cd .. && pwd)/.conf"
for dotfile in $CONF_DIR/* ; do
	[[ "$dotfile" == "${CONF_DIR}/.git" ]] && continue
	[[ "$dotfile" == "${CONF_DIR}/.github" ]] && continue
	[[ "$dotfile" == "${CONF_DIR}/.DS_Store" ]] && continue
	ln -fsv "$dotfile" "$HOME/.config"
done


SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
for dotfile in "${SCRIPT_DIR}"/.??* ; do
	[[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
	[[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
	[[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue

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
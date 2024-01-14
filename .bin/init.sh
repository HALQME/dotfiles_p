# Check Operating System
if [ "$(uname)" = "Darwin" ] ; then
	echo "install homebrew..."
elif [ "$(uname -s)" = "Linux" ] ; then
	echo "install linuxbrew..."
else 
	exit 1
fi

# Set bash
chsh -s /bin/zsh

# Install xcode
xcode-select --install > /dev/null

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
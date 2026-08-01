# shock-linux
a integration for openshock for the linux command line
only works on zsh rn because i haven't looked into making it work on other shells
## chow it works
it uses the exit code of the command ran to see if it is not 0 and activates if so
all of the config is in the .shockrc file
## how to use
clone this repo into the .config directory
add 'source $HOME/.config/shock-linux/shocklinux.sh' to the bottom of your .zshrc file

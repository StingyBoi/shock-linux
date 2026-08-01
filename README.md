# Shock-Linux
A integration for openshock for the linux command line.
Only works on zsh right now because I haven't looked into making it work on other shells.
## How it Works
It uses the exit code of the command ran and if it is not 0 it will activate.
All of the config is in the `.shockrc` file.
## How to Use
Clone this repo into the .config directory.
Add `source $HOME/.config/shock-linux/shocklinux.sh` to the bottom of your `.zshrc` file.

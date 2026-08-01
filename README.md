# Shock-Linux
A integration for OpenShock for the Linux command line.

>[!NOTE]
>Only works on zsh and bash right now because I haven't looked into making it work on other shells.
## How it Works
It uses the exit code of the command ran and if it is not 0 it will activate.
All of the config is in the `.shockrc` file.
## How to Use
Clone this repo into the `.config` directory.
Add `source $HOME/.config/shock-linux/shocklinux.sh` to the bottom of your `.zshrc` or `.bashrc` file.

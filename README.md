# Shock-Linux
A integration for OpenShock for the Linux command line.
## Limitations
>[!NOTE]
>Only works on zsh and bash right now because I haven't looked into making it work on other shells.
also given how i am doing the randomness the max it can do is 32676ms
only works for 1 shocker
## How it Works
It uses the exit code of the command ran and if it is not 0 it will activate.
All of the config is in the `.shockrc` file.
## How to Use
Clone this repo into the `.config` directory.
Add `source $HOME/.config/shock-linux/shocklinux.sh` to the bottom of your `.zshrc` or `.bashrc` file.
to disable just comment out the souceing of the script
ex: `#source $HOME/.config/shock-linux/shocklinux.sh`
## Features
1. Setting the type of thing that happens (shock vibrate or sound)
2. you can set the strenght and length of them
3. Range options for time and length 
4. Optionally a message can be set to be sent in the terminal when it gets activated

#!/bin/sh

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             cloning powerlevel10k                         "
    echo "-----------------------------------------------------------"
    git clone https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cat .zshrc > "$HOME"/.zshrc
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    cat .p10k.zsh > "$HOME"/.p10k.zsh
}

# Change time zone
sudo ln -fs /usr/share/zoneinfo/Europe/Oslo /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Copy scripts
mkdir -p "$HOME"/dev/scripts
touch "$HOME"/dev/scripts/push.sh
cat push.sh > "$HOME"/dev/scripts/push.sh

# Install packages
## exa (deprecated)
# curl -L https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip --output /tmp/exa-linux.zip && unzip /tmp/exa-linux.zip -d /tmp/exa-linux/ && sudo mv /tmp/exa-linux/bin/exa /usr/local/bin/ && sudo mv /tmp/exa-linux/man/exa.1 /usr/share/man/man1/ && sudo mv /tmp/exa-linux/completions/exa.zsh /usr/local/share/zsh/site-functions/
## eza (exa successor)
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
## Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Configure fonts
# Hack Nerd Font
mkdir -p "$HOME"/fontinstall
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip --output-document "$HOME"/fontinstall/Hack.zip
unzip "$HOME"/fontinstall/Hack.zip -d "$HOME"/fontinstall/HackNerdFont
sudo mkdir -p /usr/local/share/fonts/hack-nerd-font
sudo cp "$HOME"/fontinstall/HackNerdFont/*.ttf /usr/local/share/fonts/hack-nerd-font/
sudo fc-cache -fv
rm -rf "$HOME"/fontinstall/Hack.zip "$HOME"/fontinstall/HackNerdFont

# Configure ZSH
zshrc

# Adjust path
export PATH="$PATH":"$HOME"/dev/scripts

# make directly highlighting readable - needs to be after zshrc line
#echo "" >> ~/.zshrc
#echo "# remove ls and directory completion highlight color" >> ~/.zshrc
#echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
#echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
#echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc

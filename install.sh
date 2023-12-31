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

# change time zone
sudo ln -fs /usr/share/zoneinfo/Europe/Oslo /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

# install packages
curl -L https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip --output /tmp/exa-linux.zip && unzip /tmp/exa-linux.zip -d /tmp/exa-linux/ && sudo mv /tmp/exa-linux/bin/exa /usr/local/bin/ && sudo mv /tmp/exa-linux/man/exa.1 /usr/share/man/man1/ && sudo mv /tmp/exa-linux/completions/exa.zsh /usr/local/share/zsh/site-functions/

zshrc

source $HOME/.zshrc

# make directly highlighting readable - needs to be after zshrc line
#echo "" >> ~/.zshrc
#echo "# remove ls and directory completion highlight color" >> ~/.zshrc
#echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
#echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
#echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc

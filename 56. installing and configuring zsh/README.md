# Installing and configuring zsh


## Steps

### Install zsh using
```
sudo apt install zsh
```

### Check that the version is ok
```
zsh --version
```

### Set zsh as default shell
```
chsh -s $(which zsh)
```

### Now log out and log back in. And then verify
```
echo $SHELL
$SHELL --version
```

### Installing oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### To update theme edit the file `~/.zshrc` and update the `ZSH_THEME` variable 
```
nano ~/.zshrc
```
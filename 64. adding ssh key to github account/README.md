# Purpose
Here I will add a ssh key to my github account

## Steps

## Generating SSH key

### Generate the key using ssh-keygen
```
ssh-keygen -t ed25519 -C "<your_email_address>@gmail.com"
```

### Verify that ssh-agent is running
```
eval "$(ssh-agent -s)"
```

### Add the newly created ssh key
```
ssh-add ~/.ssh/id_ed25519
```

### See the ssh key's public key and add it to github
```
cat ~/.ssh/id_ed25519.pub
```

### Go to your account's `profile > settings`
![adding ssh public key to github account](images/01.%20adding%20ssh%20public%20key%20to%20github%20account.png)


### You may have to change the git repository url to ssh url

### Browse to your project and use this to see the url
```
git remote get-url --all origin
```

### Change the url using this
```
git remote set-url origin <repo's ssh url>
```

### Again check that the url has changed
```
git remote get-url --all origin
```

### You can get your repo's ssh url from here
![getting ssh url of a repo](images/02.%20ssh%20url%20of%20a%20repo.png)

### To add the key permanently to your account add this line to the `~/.ssh/config` file. Here after IdentityFile it is the path of the private key
```
IdentityFile ~/.ssh/gitHubKey
```

## References
01. https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
2.  https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories
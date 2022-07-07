# Purpose
To setup [pingme](https://github.com/kha7iq/pingme) with discord so that I can send notification message to a channel after a long command finished running.


# Steps

### At first go to [https://discord.com/developers/applications](https://discord.com/developers/applications) and login. 
If you don't already have a discord account, create one.# Purpose
To setup [pingme](https://github.com/kha7iq/pingme) with discord so that I can send notification message to a channel after a long command finished running.


# Steps

### 1.  At first go to [https://discord.com/developers/applications](https://discord.com/developers/applications) and login. 

If you don't already have a discord account, create one.

### 2. Create a new application by clicking here
![Create a new application by clicking here](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/01.%20click%20here%20to%20create%20an%20application.png)


### 3. Give the application a name and click create
![Give the application a name and click create](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/02.%20give%20this%20application%20a%20name.png)


### 4. Go to the Bot section from the Left side menu.
![Go to the Bot section from the Left side menu.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/03.%20go%20to%20the%20bot%20section.png)


### 5. Click the Add Bot.
![Click the Add Bot.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/04.%20click%20here%20to%20add%20a%20bot.png)


### 6. Go to the Authorization Flow section and **Disable** the "Public Bot" toggle and click Save Changes.
![Go to the Authorization Flow section and Disable the "Public Bot" toggle and click Save Changes.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/05.%20disable%20public%20and%20click%20save.png)


### 7. After saving, click the Reset Token.
![After saving, click the Reset Token.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/06.%20click%20on%20the%20reset%20token%20to%20view%20the%20bot%20token.png)


### 8. Copy the token and keep is someplace safe. We'll need this later to send messages.
![Copy the token and keep is someplace safe. We'll need this later to send messages.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/07.%20save%20the%20bot%20token.png)


### 9. Now go to the URL Generator page from the left side menu.
![Now go to the URL Generator page from the left side menu.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/08.%20go%20to%20url%20generator.png)


### 10. Set the Scope as "bot" and enable only "Send Messages" permission.
![Set the Scope as "bot" and enable only "Send Messages" permission.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/09.%20only%20enable%20this%20two%20option.png)


### 11. Copy the generated url and go to that url.
![Copy the generated url and go to that url.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/10.%20copy%20the%20generated%20url.png)


### 12. Select the server you where you want to add the bot.
![Select the server you where you want to add the bot.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/11.%20authenticate%20the%20bot%20for%20the%20server%20you%20want.png)


### 13. Check the permission is enabled and click Authorize.
![Check the permission is enabled and click Authorize.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/12.%20check%20the%20permission%20and%20authorize.png)


### 14. Now go to the discord server and copy the channel id. We will need this id to send message to this channel.
![Now go to the discord server and copy the channel id. We will need this id to send message to this channel.](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/13.%20now%20go%20to%20the%20server%20and%20copy%20a%20channel%20id.png)


### 15. Create your pingme url
```bash
pingme discord \
    --token '<the bot token that you copied on step 8>' \
    --channel '<the channel id you copied on step 14>' \
    --msg 'Congratulations!! Your setup is working. :)'
```
![Create your pingme url](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/14.%20make%20the%20pingme%20commad%20using%20token%2C%20channel%20id%20and%20a%20message.png)


### 16. You pingme setup for discord should be working.
![You pingme setup for discord should be working](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/45.%20setting%20up%20pingme%20with%20discord%20for%20automated%20notification/images/15.%20pingme%20should%20be%20working.png)

# Setting up alias in powershell

This is a quick 30 second guide to setting up an alias in windows. All this is applicable for windows.

## Motivation
The main motivation behind this is that I wanted to simplify the ping command. So that I'll just type a single command and it'll execute the `ping www.google.com -t`, which I use to check if my internet connection is stable or not.
The motivation behind this post is that I couldn't find a quick guide/overview to setup alias or terminal shortcuts when I searched google. So hopefully this will be helpful to juniors to get started. 

Open up a powershell and type away.

## Basic alias by creating simple shortcut.

If you want to just create an alias for a command the script is like this.
If I want to reference the command `echo` using a shortcut like `ec` the command is like this

```
Set-Alias -Name ec -Value echo
```
Now the ec command will refer to the echo command, and the echo command is there as well, it didn't go anywhere. To try and see if this works you can try this
```
ec "Hello World"
```
![The ec command now is just another command to refer to echo](<images/01. alias working.png>)

## Little bit extended - call simple commands with shortcut
To create the final alias, I'll have to use a powershell function like this.
```
Function PingGoogle { ping www.google.com -t }
```
Here the function's name is `PingGoogle` and it executes the `ping www.google.com -t` command. We can try it by just entering the `PingGoogle` command after pasting the method.

![Now I can start a ping by calling this method](<images/02. method working.png>)

Now we'll have to make an alias to this command. Like this
```
Set-Alias -Name pingg -Value PingGoogle
```
Here the `pingg` alias is referring to the `PingGoogle` function. To test this we can just use `pingg` command now.

![now everytime I type pingg the ping will run](<images/03. pingg working.png>)

## Bonus - How to persist these changes.

You'll notice that if you close your terminal then the changes go away, your shortcut won't work.
So to persist these changes across all terminals you'll have to save them in your terminal profile.

To do that type this
```
echo $profile
```
This will show you the location of your powershell profile file. Go to that location and open that file.
Or open that file with this
```
notepad $profile
```
A file will open in notepad.

Now paste your code in that notepad and save in the same location. Now what will happen is that every time your terminal runs it will also load codes from this file. That's why your changes that your pasted here will persist between sessions.


### To see if an alias exist use this
```
Get-Alias -Name pig
```

## Reference
1. [Microsoft Documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/set-alias?view=powershell-7.4)
# Limiting docker desktop's ram usage

## Steps

### Shutdown wsl
```
wsl --shutdown
```

### From powershell find the user profile path
```
cd ~
```

### Open or create a .wslconfig file
```
notepad .\.wslconfig
```

### Use this to limit memory and processor
```# ~/.wslconfig
[wsl2]
memory=6GB
processors=4
```

### To start it back again at first get the list of installed dist.
```
wsl -l
```

### Login
```
wsl.exe -d <distribution name>
```
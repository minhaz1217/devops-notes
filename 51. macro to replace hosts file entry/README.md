# Motivation
In our organization we use host name like "custom-app.our-domain.com" for dev environment. Our microservices recognize that host and accept requests from it. As a result when we want to launch our angular dev environment locally we have to change the *hosts* file and add entry like
`127.0.0.1 custom-app.our-domain.com`

So that when we try to bind to the 4200 port(angular's default port) of "custom-app.our-domain.com" we'll get to our localhost.

But it creates a problem. The problem is that now when our QA or PM team reports a bug or issue or when we have to enter the real dev environment we'll have to comment out our part from the *hosts* file and enter the main dev domain. And when we want to start developing again we'll have to uncomment the entry.

**The solution**
One possible solution is to run a macro in powershell and replace the entry if it was commented then uncomment it, if it was uncommented when comment it. Basically toggle dev domain setup and local domain setup.

### Script
```
$hostToChange = "custom-app.our-domain.com"
$stringToAddOrUpdate = "127.0.0.1 $hostToChange"
$pathAlreadyExists = Get-ChildItem -Path C:\Windows\System32\drivers\etc\hosts -Recurse | Select-String -Pattern "$stringToAddOrUpdate"



function StringExistsInsideHostFile{
    param ([string]$name)
    $pathAlreadyExists = Get-ChildItem -Path C:\Windows\System32\drivers\etc\hosts -Recurse | Select-String -Pattern "$name"
    if ($pathAlreadyExists){
        return $true
    }else{
        return $false
    }
}


function ChangeHostFileEntry{
    param ([string]$from, [string]$to)
    powershell -executionPolicy bypass -Command "(Get-Content C:\Windows\System32\drivers\etc\hosts) -replace '$from', '$to' | Out-File -encoding ASCII C:\Windows\System32\drivers\etc\hosts"
}


if (StringExistsInsideHostFile $stringToAddOrUpdate){
    echo "Entry exists so TOGGLING"
    
    $commentedOutString = "# $stringToAddOrUpdate"
    $nonCommentedOutString = "$stringToAddOrUpdate"

    if( (StringExistsInsideHostFile $commentedOutString) -eq $true ){
        echo "Changing ($commentedOutString) => ($nonCommentedOutString)"
        ChangeHostFileEntry $commentedOutString $nonCommentedOutString
        echo "Uncommented"
    }elseif((StringExistsInsideHostFile $nonCommentedOutString) -eq $true){
        echo "Changing ($nonCommentedOutString) => ($commentedOutString)"
        ChangeHostFileEntry $nonCommentedOutString $commentedOutString
        echo "Commented"
    }
}else{
    $nonCommentedOutString = "$stringToAddOrUpdate"
    echo "Entry doesn't exist so ADDING ($nonCommentedOutString)"
    powershell -executionPolicy bypass -Command "(Add-Content C:\Windows\System32\drivers\etc\hosts '$nonCommentedOutString')"
}
```


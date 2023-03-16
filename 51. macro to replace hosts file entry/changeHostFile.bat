
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
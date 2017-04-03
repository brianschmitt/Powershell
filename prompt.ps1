#function prompt {
#    [Console]::ResetColor()
#    $userLocation = $env:username + '@' + [System.Environment]::MachineName + ' '
#    Write-Host -Object ($userLocation) -NoNewline -ForegroundColor DarkGreen
#    Write-Host -Object ($pwd) -NoNewline
#    Write-VcsStatus
#    Write-Host -Object ('>') -NoNewline
#    return ' '
#}
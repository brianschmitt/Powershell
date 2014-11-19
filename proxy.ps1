# Sets proxy to Fiddler
function Set-Proxy() {
    $env:HTTP_PROXY = 'http://127.0.0.1:8888'
    $env:HTTPS_PROXY = 'http://127.0.0.1:8888'
    git.exe config --global http.proxy 'http://127.0.0.1:8888'
}

function Remove-Proxy() {
    Remove-Item  -Path Env:\HTTP_PROXY
    Remove-Item  -Path Env:\HTTPS_PROXY
    git.exe config --global --remove-section http
}
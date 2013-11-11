# Sets proxy to Fiddler
function Set-Proxy() {
    $env:HTTP_PROXY="http://127.0.0.1:8888"
    $env:HTTPS_PROXY="http://127.0.0.1:8888"
    git config --global http.proxy "http://127.0.0.1:8888"
}

function Remove-Proxy() {
    Remove-Item Env:\HTTP_PROXY
    Remove-Item Env:\HTTPS_PROXY
    git config --global --remove-section http
}
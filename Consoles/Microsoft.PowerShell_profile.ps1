function openProfile () {
  Write-Host "opening $profile"
  & "C:\Program Files\Microsoft VS Code\Code.exe" $profile
}

function ov ($pathFile) {
  Write-Host "opening $pathFile with Visual Studio Code..."
  & "C:\Program Files\Microsoft VS Code\Code.exe" $pathFile
}

function goWorkspace() {
  Set-Location "C:\Users\mliriovi\Documents\WorkSpace"
}

# Anyway, is better to restart the window.... xDD
function reloadProfile () {
  . $profile
}

function printenv () {
  Get-ChildItem Env:
}

function debugON($value) {
  $value = $($value + '*')
  $env:DEBUG = $value
  Write-Output $env:DEBUG
}

function debugOFF() {
  $env:DEBUG = ""
  Write-Output $env:DEBUG
}

############################################################
# Git                                                      #
############################################################

function gitStatus() {
  git status
}

Set-Alias gs gitStatus

############################################################
# Proxys                                                   #

############################################################
function setProxy () {
  Write-Host "Setting http-proxy and https-proxy: http://mliriovi:*******@10.124.8.100:8080"
  [Environment]::SetEnvironmentVariable('http_proxy', "http://mliriovi:**********@10.124.8.100:8080", 'User')
  [Environment]::SetEnvironmentVariable('https_proxy', "http://mliriovi:**********@10.124.8.100:8080", 'User')
}

function unSetProxy () {
  Write-Host "Deleting variables http-proxy and https-proxy"
  [Environment]::SetEnvironmentVariable('http_proxy', $null, 'User')
  [Environment]::SetEnvironmentVariable('https_proxy', $null, 'User')
}

function setProxyGit () {
  Write-Host "Setting proxy on git configuration"
  git config --global http.proxy "http://mliriovi:**********@10.124.8.100:8080"
}

function unSetProxyGit () {
  git config --global --unset http.proxy
}

function setProxyNPM () {
  Write-Host "Setting npm variables http-proxy, https-proxy, proxy"
  npm config set http-proxy "http://10.124.8.100:8080/"
  npm config set https-proxy "http://10.124.8.100:8080/"
  npm config set proxy "http://10.124.8.100:8080/"
  npm config set strict-ssl false
  npm config list
}

function unSetProxyNPM () {
  Write-Host "Deleting npm variables http-proxy, https-proxy, proxy"
  npm config delete http-proxy
  npm config delete https-proxy
  npm config delete proxy
  npm config delete strict-ssl
  npm config list
}
function setProxyNPM_UP () {
  Write-Host "Setting npm variables http-proxy, https-proxy, proxy"
  npm config set http-proxy "http://mliriovi:**********@10.124.8.100:8080/"
  npm config set https-proxy "http://mliriovi:**********@10.124.8.100:8080/"
  npm config set proxy "http://mliriovi:**********@10.124.8.100:8080/"
  npm config set strict-ssl false
  npm config list
}

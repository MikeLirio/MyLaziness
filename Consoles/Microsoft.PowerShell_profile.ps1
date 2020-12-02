###############################################################################################
## CHANGE LOG #################################################################################
###############################################################################################
# Change Log v1.0
#       - Beginning of having track on Powershell Profile.
#       - Migrating behaviors already code in bash_profiles for linux.
#       - All functions are documented on lirio function.
#       - Added function aws that allows to execute aws-cli with docker.
#
###############################################################################################
## ENVIRONMENT VARIABLE - LIRIO ###############################################################
###############################################################################################
$env:PROFILE_VERSION="1.0"

$env:DEV_PATH = "J:\Desarrollo"

$env:GITHUB_PATH = $env:DEV_PATH + "\github"
$env:MY_LAZINESS = $env:GITHUB_PATH + "\MyLaziness"

# Variables use on Docker configuration
$env:AWS_DOCKER = "//j/Desarrollo/github/MyLaziness/docker/aws-cli"
$env:AWS_DOCKER_CONFIG = "$env:AWS_DOCKER/.aws"
$env:AWS_DOCKER_HELPER = "$env:AWS_DOCKER/helper"

$env:test = "calor"

###############################################################################################
## ENVIRONMENT VARIABLE - EVERIS ##############################################################
###############################################################################################


###############################################################################################
## ALIAS ######################################################################################
###############################################################################################

Set-Alias gs gitStatus

###############################################################################################
## FUNCTIONS ##################################################################################
###############################################################################################

function lirio () {
  Write-Host (
    "   Lirio Documentation v$env:PROFILE_VERSION. Functions defined on $PROFILE",
    "",
    "   ############# List of Functions",
    "",
    "   lirio                 -   List of functions in the profile.",
    "   everis                -   List all everis functions.",
    "",
    "   ############# Lirio Functions",
    "",
    "   openProfile           -   Open the actual Profile in VS Code.",
    "   ov                    -   Open a file with VS Code.",
    "   goDev                 -   Go to path $env:DEV_PATH.",
    "   reloadProfile         -   Reload the actual profile.",
    "   printenv              -   Print all the environment variables.",
    "   printLirioEnv         -   Print all the environment variables located on the Profile.",
    "   debugON               -   Creates/Update and environment variable called DEBUG with the value writed + *. Ex; lirio*",
    "   debugOFF              -   Set the environment variable DEBUG to ''.",
    "   cat                   -   Print in the console the content of the file indicated as argument.",
    "   gitStatus             -   git status",
    "   aws                   -   Docker command for aws-cli. The configuration is located on $env:AWS_DOCKER",
    ""
  ) -Separator "`r`n"
  everis
}

function everis () {
  Write-Host(
    "   ############# everis Functions",
    "",
    "   unSetProxy            -   Set the everis proxy.",
    "   setEverisProxyGit     -   Set the everis proxy on Git.",
    "   unSetEverisProxyGit   -   Remove the everis proxy on Git.",
    "   setEverisProxyNPM     -   Set the everis proxy on NPM.",
    "   unSetEverisProxyNPM   -   Remove the everis proxy on NPM.",
    "   setEverisProxyNPM_UP  -   ????? xD",
    ""
  ) -Separator "`r`n"
}

function printLirioEnv () {
  Write-Host(
    "PROFILE_VERSION = $env:PROFILE_VERSION",
    "DEV_PATH  = $env:DEV_PATH ",
    "GITHUB_PATH  = $env:GITHUB_PATH ",
    "MY_LAZINESS  = $env:MY_LAZINESS ",
    "AWS_DOCKER  = $env:AWS_DOCKER ",
    "AWS_DOCKER_CONFIG  = $env:AWS_DOCKER_CONFIG ",
    "AWS_DOCKER_HELPER  = $env:AWS_DOCKER_HELPER "
  ) -Separator "`r`n"
}

function openProfile () {
  Write-Host "opening $PROFILE"
  & code $PROFILE
}

function ov ($pathFile) {
  Write-Host "opening $pathFile with Visual Studio Code..."
  & code $pathFile
}

function goDev () {
  Write-Host "going to $env:DEV_PATH"
  Set-Location $env:DEV_PATH
}

function reloadProfile () {
  Write-Host "Loading profile $PROFILE"
  . $PROFILE
}

function printenv () {
  Get-ChildItem Env:
}

function debugON($value) {
  $value = $($value + '*')
  $env:DEBUG = $value
  Write-Output "Setting the debug with the value of $env:DEBUG"
}

function debugOFF() {
  $env:DEBUG = ""
  Write-Output $env:DEBUG
}

function cat($file) {
  type $file
}

function gitStatus() {
  git status
}

# https://stackoverflow.com/questions/2468145/equivalent-to-bash-alias-in-powershell
function aws {  
  Write-Host "Executing: docker run --rm -ti -v ${env:AWS_DOCKER_CONFIG}:/root/.aws -v ${env:AWS_DOCKER_HELPER}:/aws amazon/aws-cli:latest $args"
  docker run --rm -ti -v ${env:AWS_DOCKER_CONFIG}:/root/.aws -v ${env:AWS_DOCKER_HELPER}:/aws amazon/aws-cli:latest $args
}

###############################################################################################
## PROXY ######################################################################################
###############################################################################################

function setEverisProxy () {
  Write-Host "Setting http-proxy and https-proxy: http://mliriovi:*******@10.124.8.100:8080"
  [Environment]::SetEnvironmentVariable('http_proxy', "http://mliriovi:**********@10.124.8.100:8080", 'User')
  [Environment]::SetEnvironmentVariable('https_proxy', "http://mliriovi:**********@10.124.8.100:8080", 'User')
}

function unSetProxy () {
  Write-Host "Deleting variables http-proxy and https-proxy"
  [Environment]::SetEnvironmentVariable('http_proxy', $null, 'User')
  [Environment]::SetEnvironmentVariable('https_proxy', $null, 'User')
}

function setEverisProxyGit () {
  Write-Host "Setting proxy on git configuration"
  git config --global http.proxy "http://mliriovi:**********@10.124.8.100:8080"
}

function unSetEverisProxyGit () {
  git config --global --unset http.proxy
}

function setEverisProxyNPM () {
  Write-Host "Setting npm variables http-proxy, https-proxy, proxy"
  npm config set http-proxy "http://10.124.8.100:8080/"
  npm config set https-proxy "http://10.124.8.100:8080/"
  npm config set proxy "http://10.124.8.100:8080/"
  npm config set strict-ssl false
  npm config list
}

function unSetEverisProxyNPM () {
  Write-Host "Deleting npm variables http-proxy, https-proxy, proxy"
  npm config delete http-proxy
  npm config delete https-proxy
  npm config delete proxy
  npm config delete strict-ssl
  npm config list
}
function setEverisProxyNPM_UP () {
  Write-Host "Setting npm variables http-proxy, https-proxy, proxy"
  npm config set http-proxy "http://mliriovi:**********@10.124.8.100:8080/"
  npm config set https-proxy "http://mliriovi:**********@10.124.8.100:8080/"
  npm config set proxy "http://mliriovi:**********@10.124.8.100:8080/"
  npm config set strict-ssl false
  npm config list
}

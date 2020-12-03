# MyLaziness
All shortcuts, scripts and whatever than can make everyone's life easier.

Right now we have 2 folders, `Consoles/` and `docker/`.

`Consoles/` will have all the profiles scripts able to use by the systems. 

`docker/` will contain all the generic configuration for all my containers.

## Consoles/

Right now there are 4 profiles:

| Profile                          | Description                                                  |
| -------------------------------- | ------------------------------------------------------------ |
| .bash_profile                    | Old version of a bash_profile used on Macintosh.             |
| .bash_profile_linux              | Actual .bash_profile that I use on my distribution of **Linux** like **Debian**. |
| cmder_user_profile.sh            | bash_profile used on Windows Bash Simulator call [Cmder](https://cmder.net/). Click on the software to go to the webpage. |
| Microsoft.PowerShell_profile.ps1 | Powershell profile that I use in my personal computer.       |

Note that those profiles could use this repository for some configurations like the import or storage. 

The profiles are not similar between them. Could be that in `Consoles/.bash_profile_linux` you can find a function that are not implemented yet in `Consoles/Microsoft.PowerShell_profile.ps1`.

An important point inside of this profiles are the functions `lirio`. Those functions will provide all the info like which functions are being implemented inside of the profiles. 

Each profile should contain a version number with allow to knows which changes are being introduced and make an easy way to track the changes done in those profiles.

## Docker

Nowadays I only use this folder with some configuration of the Windows Profile `Consoles/Microsoft.PowerShell_profile.ps1`.

### AWS-CLI

It contains 2 main folders that I use as a **volumes**. 

* `docker/aws-cli/helper  `: this path is use on `Consoles/Microsoft.PowerShell_profile.ps1` to mount the `/aws` path on aws-cli docker image.
* `docker/aws-cli/users/*` : this path will contain all the configuration for `aws-cli` image to be able to connect with an user. 
  The credentials have to be set one time this repo is cloned. 

Right now it only works in **Windows**, pending to be develop on **Linux**, and use the next variables to be configured on  `Consoles/Microsoft.PowerShell_profile.ps1`:

```powershell
# Variable that contains the user selected to load their credentials.
$env:AWS_DOCKER_USER
# Path in docker format where this repo is cloned. This HAVE TO BE change after clonning this.
$env:AWS_DOCKER = "//j/Desarrollo/github/MyLaziness/docker/aws-cli"
# Path where the users credentials have to be inserted.
$env:AWS_DOCKER_CONFIG = "$env:AWS_DOCKER/users"
# Path of the generic volume to work with aws-cli
$env:AWS_DOCKER_HELPER = "$env:AWS_DOCKER/helper"
```


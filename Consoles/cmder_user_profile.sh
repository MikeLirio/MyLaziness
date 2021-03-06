# use this file to run your own startup commands for msys2 bash'

# To add a new vendor to the path, do something like:
# export PATH=${CMDER_ROOT}/vendor/whatever:${PATH}

# Uncomment this to have the ssh agent load with the first bash terminal
# . "${CMDER_ROOT}/vendor/lib/start-ssh-agent.sh"

###############################################################################################
## README #####################################################################################
###############################################################################################
#
# This file is code to be used on Cmder app.
# To use this file just replace the file user_profile.sh that you can find on 
# ${CMDER_FOLDER}/config folder.
#
# To change to exporting it to bash_profile you will have to change a few thing:
#   - Depending of the software you are using it could fail with some commands. 
#       open, .bat files, tail or sudo
#   - instead of execute .bat file you will have to change it to sh files. 
#   - make sure the path is right. Depending of the software you will have to write /drives/c/ or /c/ or even //c/
#   - you will have to make some research to make it work: 
#   https://stackoverflow.com/questions/35931378/local-bashrc-is-not-read-on-startup-under-mobaxterm-home-on-windows
#
# if [ -f ~/.bashrc ]; then
# 	. ~/.bashrc
# fi
#
###############################################################################################
## CHANGE LOG #################################################################################
###############################################################################################
#
# Actual Version v1.3
# 
# Change Log v1.3
#       - Added liferayDatabaseON to start the Docker container of mysql related 
#         McDonald Project.
#       - Added DEV_LIFERAY_DATABASE variable used on previous function.
#
# Change Log v1.2
#       - Added funcion debugOn and debugOff on lirio.
#       - Liferay functions are pending to be fixed.
#       - Lirio functions version 1.1
#
# Change Log v1.1
#	- Added openLiferayEnv to executes openLiferayDev - openLiferayDeploy - openLiferayOsgi
#	  functions.
#	- Updated mc_everis functions to v1.s to v1.2.
#
# Change Log v1.0
#       - Added goDocker function.
#       - Added saveCmder & loadCmder function to manage this file easyly.
#       - Added behavior on editProfile function. Now it will execute reloadProfile function
#         when it ends the edition.
#       - Updated lirio function.
#
###############################################################################################
## ENVIRONMENT VARIABLE #######################################################################
###############################################################################################

export JAVA_HOME="/c/Program Files/Java/jdk1.8.0_251"
export JRE_HOME="/c/Program Files/Java/jdk1.8.0_251/jre"

export MY_LAZINESS=${DEV_PATH}/MyLaziness

export DEV_PATH=/e/Desarrollo
export DEV_LIFERAY=${DEV_PATH}/everis-liferay/mcdonalds
export DEV_LIFERAY_DATABASE=${DEV_LIFERAY}/database
export LIFERAY_MCDONALD=${DEV_LIFERAY}/ourloungecloud/liferay/bundles/osgi/modules
export LIFERAY_PATH=${DEV_PATH}/everis-liferay/liferay_7.2.SP2
export LIFERAY_TOMCAT_PATH=${LIFERAY_PATH}/tomcat-9.0.33

###############################################################################################
################## My Functions ###############################################################
###############################################################################################

function lirio () {
    echo "Lirio Documentation v1.0. Functions defined on ${DEV_PATH}/Software-Tools/cmder/config/user_profile.sh"
    echo "############# List of funcions"
    echo "lirio               -   List of function on Cmdr configuration."
    echo "everis              -   List all everis functions"
    echo "mc_everis           -   List of funcions related with McDonald's project and Liferay 7.2 in local."
    echo "############# lirio Functions v1.1"
    echo "editProfile         -   Edit the Cmdr configuration of bash_profile."
    echo "reloadProfile       -   Reload the profile avoiding to restart the terminal."
    echo "goDocker            -   cd ${DEV_PATH}/docker"
    echo "saveCmder           -   store the user_profile.sh of Cmder on MyLazyness repository."
    echo "loadCmder           -   load from MyLazyness repository the user_profile.sh of Cmder."
    echo "debugOn pattern     -   set Environment Variable {DEBUG} in '*'. Pattern is a variable that you can concatenate with *"
    echo "debugOff            -   set Environment Variable {DEBUG} with value ''"
    everis
}

function debugOn() {
    echo "Activating DEBUG"
    if [ -z "$1" ]; then
       export DEBUG=*
       printenv DEBUG
    else
       local service=$1
       export DEBUG="$service*"
       printenv DEBUG
    fi
}

function debugOff() {
   echo "Deactivating DEBUG"
   unset DEBUG
}

function editProfile () {
    vi ${DEV_PATH}/Software-Tools/cmder/config/user_profile.sh
    echo "Reloading the user_profile.sh file."
    reloadProfile
}

function reloadProfile () {
    source ${DEV_PATH}/Software-Tools/cmder/config/user_profile.sh
}

function goDocker () {
    cd ${DEV_PATH}/docker
}

function saveCmder () {
    echo "Fetch and Pull of MyLazyness Repository."
    git --work-tree=${MY_LAZINESS} fetch
    git --work-tree=${MY_LAZINESS} pull
    echo "Copying file user_profile.sh to repository."
    cp ${DEV_PATH}/Software-Tools/cmder/config/user_profile.sh ${MY_LAZINESS}/Consoles/cmder_user_profile.sh
    echo "Generating commit and pushing it."
    git --work-tree=${MY_LAZINESS} add ${MY_LAZINESS}/Consoles/cmder_user_profile.sh 
    git --work-tree=${MY_LAZINESS} commit -m "Autogenerated: new user_profile of Cmder. See changelogs."
    git --work-tree=${MY_LAZINESS} push
    echo "saveCmder ended !!"
}

function loadCmder () {
    echo "Fetch and Pull of MyLazyness Repository."
    git --work-tree=${MY_LAZINESS} fetch
    git --work-tree=${MY_LAZINESS} pull
    echo "Copying user_profile.sh to Cmder file."
    cp ${DEV_PATH}/Consoles/cmder_user_profile.sh ${DEV_PATH}/Software-Tools/cmder/config/user_profile.sh
    echo "File copied."
    reloadProfile
    echo "File loaded !!"
}

###############################################################################################
################## Everis functions for Liferay McDonald ######################################
###############################################################################################

function everis () {
    echo "############# everis Functions"
    mc_everis
}

function mc_everis () {
    echo "############# mc_everis Functions"
    echo "############# Bugs and improvements"
    echo "# Need of removing all paths from description and use variables"
    echo "# Liferay paths are being changed. Need to be updated to work properly"
    echo "#############"
    echo "liferayOn          -   start Liferay 7.2"
    echo "liferayOff         -   stop  Liferay 7.2"
    echo "liferayDatabaseOn  -   start the Docker container with mysql and the schema used in Local"
    echo "liferayDeploy      -   Mv the content of /CREWPORTAL/bundles/osgi/modules to liferay/deploy folder"
    echo "liferayClean       -   clean the content of liferay app."
    echo "liferayCleanOn     -   executes liferayClean and after liferayOn"
    echo "liferayCleanDev    -   clean the .jar on ${LIFERAY_PATH}/osgi/modules folder."
    echo "liferayCleanOsgi   -   clean the .jar on ${DEV_LIFERAY}/crewportal/CREWPORTAL/bundles/osgi/modules folder."
    echo "liferayLogs        -   show last logs of liferay: ${LIFERAY_PATH}/logs/liferay.*.log"
    echo "catalinaLogs       -   show logs of catalina: ${LIFERAY_TOMCAT_PATH}/logs/catalina.out"
    echo "########################## Using 'cd' to some Path"
    echo "goLiferay          -   cd ${LIFERAY_PATH}"
    echo "goLiferayDev       -   cd ${DEV_LIFERAY}/bundles/osgi/modules"
    echo "goLiferayDeploy    -   cd ${LIFERAY_PATH}/deploy"
    echo "goLiferayOsgi      -   cd ${LIFERAY_PATH}/osgi/modules"
    echo "goTomcat           -   cd ${LIFERAY_TOMCAT_PATH}"
    echo "########################## Open explorer on Windows"
    echo "openLiferay        -   open folder ${LIFERAY_PATH} on explorer"
    echo "openLiferayDev     -   open folder ${DEV_LIFERAY}/bundles/osgi/modules on explorer"
    echo "openLiferayDeploy  -   open folder ${LIFERAY_PATH}/deploy on explorer"
    echo "openLiferayOsgi    -   open folder ${LIFERAY_PATH}/osgi/modules on explorer"
    echo "openTomcat         -   open folder ${LIFERAY_TOMCAT_PATH} on explorer"
    echo "openLiferayEnv     -   executes openLiferayDev - openLiferayDeploy - openLiferayOsgi functions."
}

function liferayDatabaseOn () {
    cd ${DEV_LIFERAY_DATABASE}
    docker-compose up
}

function goLiferay () {
    cd ${LIFERAY_PATH}
    pwd
}

function goLiferayDev () {
    cd ${LIFERAY_MCDONALD}
    pwd
}

function goLiferayDeploy () {
    cd ${LIFERAY_PATH}/deploy
    pwd
}

function goLiferayOsgi () {
   cd ${LIFERAY_PATH}/osgi/modules
   pwd
}

function goTomcat () {
    cd ${LIFERAY_TOMCAT_PATH}
    pwd
}

function openLiferay () {
    start ${LIFERAY_PATH}
}

function openLiferayDev () {
    start ${LIFERAY_MCDONALD}
}

function openTomcat () {
    start ${LIFERAY_TOMCAT_PATH}
}

function openLiferayDeploy () {
    start ${LIFERAY_PATH}/deploy
}

function openLiferayOsgi () {
    start ${LIFERAY_PATH}/osgi/modules
}

function openLiferayEnv () {
    openLiferayDev
    openLiferayDeploy
    openLiferayOsgi
}

function liferayCleanOsgi () {
    echo "This has to be rechecked"
    # echo "Removing elements from ${LIFERAY_PATH}/osgi/modules/*.jar"
    # rm ${LIFERAY_PATH}/osgi/modules/*.jar
}

function liferayCleanDev () {
    echo "This has to be rechecked"
    # echo "Removing elements from ${DEV_LIFERAY}/bundles/osgi/modules/*.jar"
    # rm ${DEV_LIFERAY}/bundles/osgi/modules/*.jar
}


function liferayDeploy () {
    echo "This has to be rechecked"
    # echo "Moving elements from ${DEV_LIFERAY}/osgi/modules to ${LIFERAY_PATH}/deploy"
    # echo "ls ${DEV_LIFERAY}/bundles/osgi/modules"
    # ls ${DEV_PATH}/bundles/osgi/modules
    # cp ${DEV_PATH}/bundles/osgi/modules/* ${LIFERAY_PATH}/deploy
}

function liferayOn () {
    echo "Turning ON ${LIFERAY_TOMCAT_PATH}/bin/startup.sh"
    # sh ${LIFERAY_TOMCAT_PATH}/bin/startup.sh
    goTomcat
    ./bin/startup.bat
}

function liferayCleanOn () {
    liferayClean
    liferayOn
}

function liferayOff () {
    echo "Turning OFF ${LIFERAY_TOMCAT_PATH}/bin/shutdown.sh"
    # sh ${LIFERAY_TOMCAT_PATH}/bin/shutdown.sh
    goTomcat
    ./bin/shutdown.bat
}

function liferayClean () {
    echo "Removing ${LIFERAY_PATH}/osgi/state/*"
    rm -r ${LIFERAY_PATH}/osgi/state/*
    # echo "Removing ${LIFERAY_PATH}/work/*"
    # rm -r work/*

    echo "Removing ${LIFERAY_TOMCAT_PATH}/temp/*"
    rm -r ${LIFERAY_TOMCAT_PATH}/temp/*
    echo "Removing ${LIFERAY_TOMCAT_PATH}/work/Catalina/*"
    rm -r ${LIFERAY_TOMCAT_PATH}/work/Catalina/*

    # Server mode
    # sh /opt/liferay/tomcat-7.0.62/bin/everis.clean.liferay.sh
}

function liferayLogs () {
    now=`date +"%Y-%m-%d"`
    tail -2000f ${LIFERAY_PATH}/logs/liferay.${now}.log
}

function catalinaLogs () {
    tail -2000f ${LIFERAY_TOMCAT_PATH}/logs/catalina.out
}

###############################################################################################

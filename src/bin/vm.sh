#!/usr/bin/env bash
GREP=`which egrep`
UNAME=`which uname`
GREP=`which egrep`
CREP_OPTIONS=""
CUT=`which cut`
READLINK=`which readlink`
XARGS=`which xargs`
DIRNAME=`which dirname`
MKTEMP=`which mktemp`
RM=`which rm`
CAT=`which cat`
SED=`which sed`


APP_HOME="/home/boot/.src/conf-cli/src/main/resources"

function getOptions(){
OPTIONS_FILE=${APP_HOME}"/config/"$1
if [[ -r ${OPTIONS_FILE} ]]; then
    OPTIONS=${OPTIONS}" "`${CAT} ${OPTIONS_FILE} | ${GREP} -v "^#.*" | ${GREP} -v "^$" `
else
    echo "Waring: Can't find option file: ${OPTIONS_FILE}."
fi
}

OPTIONS=""
getOptions "app.options"
getOptions "jvm.options"

echo ${OPTIONS}

APP_HOME=`pwd`

function getCP(){
p=$1
for jar in `ls ${p%/*}/*.jar` ; do
    CP=${CP}:${jar}
done
}

CP="."

getCP "${APP_HOME}/lib/"
getCP "${APP_HOME}/boot/"
echo ${CP}

echo "UUUUUUUUUUUUUUUUU"

#cp=`echo $cp`
#cp=`echo $cp | cut -c2-`

#echo $cp

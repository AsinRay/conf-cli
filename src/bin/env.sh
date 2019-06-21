#!/usr/bin/env bash

JAVA=`which java`
UNAME=`which uname`
GREP=`which egrep`
CUT=`which cut`
READLINK=`which readlink`
XARGS=`which xargs`
DIRNAME=`which dirname`
MKTEMP=`which mktemp`
RM=`which rm`
CAT=`which cat`
SED=`which sed`

if [ -z ${JAVA} ]; then
    echo "java is missing - check beginning of \"$0\" file for details."
    exit 1
fi

if [ -z "$UNAME" -o -z "$GREP" -o -z "$CUT" -o -z "$MKTEMP" -o -z "$RM" -o -z "$CAT" -o -z "$SED" ]; then
    xmessage "Required tools are missing - check beginning of \"$0\" file for details."
    exit 1
fi

# OS_TYPE=`"$UNAME" -s`

JAVA_HOME=`java -XshowSettings:properties -version 2>&1 | sed '/^[[:space:]]*java\.home/!d;s/^[[:space:]]*java\.home[[:space:]]*=[[:space:]]*//'`
CLZ_VERSION=`java -XshowSettings:properties -version 2>&1 | sed '/java.class.version/!d' | awk '{print $3}'`
GE_JDK8=52.0

if [ ${CLZ_VERSION} \< ${GE_JDK8} ]; then
    echo "App need JDK8 or later version. please run java --version to check the JDK version."
    exit 1
fi




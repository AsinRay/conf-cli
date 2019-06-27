#!/usr/bin/env bash

APPNAME=@project.name@
BUILDJAR="@project.build.finalName@.jar"

PID=$(ps -ef | grep "${BUILDJAR}" | grep -v 'grep' | awk '{ print $2 }')

if [[ -z "${PID}" ]] 
then
    echo ${APPNAME} is already stopped.
else
    echo "shutdown application ${APPNAME} ..." 
    kill ${PID}
    echo ${APPNAME} stopped successfully.
fi
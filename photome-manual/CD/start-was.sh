#!/usr/bin/env bash

CUR_DIR=`pwd`

export CATALINA_OPTS="-Denv=product -Denv.servername=${TOMCAT_SERVER_NAME}"
export CATALINA_BASE="${CUR_DIR}"
export CATALINA_TMPDIR="${CUR_DIR}/temp"
export CATALINA_OUT="${CUR_DIR}/logs/catalina.out"
export CATALINA_PID="/var/run/${TOMCAT_SERVER_NAME}.pid"

cd $CATALINA_HOME/bin
./startup.sh

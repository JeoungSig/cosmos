#!/usr/bin/env bash

cd $CATALINA_HOME/bin
export CATALINA_BASE="./tomcat-instance"
export CATALINA_TMPDIR="./temp"
export CATALINA_OUT="./logs/catalina.out"
export CATALINA_PID="/var/run/${TOMCAT_SERVER_NAME}.pid"

./shutdown.sh

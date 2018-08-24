#!/bin/sh
####################
# Mission Control
####################
. ./javaenvServer.sh

java com.chelseasystems.cs.dataaccess.DataLoader $1

#!/bin/sh
#####################
# Application Builder
####################
. ./javaenv.sh

java -Djava.security.policy=../../library/policy com.chelseasystems.ab.AppBuilder

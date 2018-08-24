#!/bin/sh
############################
. ./javaenvServer.sh

java -ms16m -mx32m RmiJdbc.RJJdbcServer COM.cloudscape.core.JDBCDriver

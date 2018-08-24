#!/bin/sh
####################
# Merchandise Admin
###################
. ./javaenv.sh

java -DREDIRECT=false com.chelseasystems.cs.merchandise.ma.MerchandiseAdmin

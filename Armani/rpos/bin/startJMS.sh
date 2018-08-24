#!/bin/sh
#########################################
JAVA_HOME=/usr/opt/app/j2sdk1_3_1_04
OPENJMS_HOME= /usr/opt/app/openjms

export JAVA_HOME OPENJMS_HOME

if [ -d  ${OPENJMS_HOME}/bin ] ; then
    cd ${OPENJMS_HOME}/bin/
else
    echo OPENJMS was not found...
    return -1
fi

startjms.sh -config ../config/rpos.xml


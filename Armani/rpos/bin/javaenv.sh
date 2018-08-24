#!/bin/sh
############################################################
#       javaenv.sh
############################################################
PATH=${PATH}:.

CLASSPATH=../classes
CLASSPATH=${CLASSPATH}:../../library/retek_shared_pos.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_time.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_common.jar
CLASSPATH=${CLASSPATH}:../../library/retek_pos.jar
CLASSPATH=${CLASSPATH}:../../library/retek_time.jar
CLASSPATH=${CLASSPATH}:../../library/retek_common.jar
CLASSPATH=${CLASSPATH}:../../library/retek_platform.jar
CLASSPATH=${CLASSPATH}:../../library/retek_app.jar
CLASSPATH=${CLASSPATH}:../../library/retek_sys.jar
CLASSPATH=${CLASSPATH}:../../library/retek_help.jar
CLASSPATH=${CLASSPATH}:../../library/retek_tax.jar

CLASSPATH=${CLASSPATH}:../../library/taxware.jar
CLASSPATH=${CLASSPATH}:../../library/xerces.jar
CLASSPATH=${CLASSPATH}:../files/prod/javapos/retek_jpos.xml
CLASSPATH=${CLASSPATH}:../../library/jpos15.jar
CLASSPATH=${CLASSPATH}:../../library/ibmjpos1.5.143.jar
#CLASSPATH=${CLASSPATH}:../../library/ibmjpos1.5.045.jar
CLASSPATH=${CLASSPATH}:../../library/epsonJposService152.jar
CLASSPATH=${CLASSPATH}:../../library/epsonJposServiceCommon.jar
CLASSPATH=${CLASSPATH}:../../library/parser.jar
CLASSPATH=${CLASSPATH}:../../library/et1000jpos15201.jar
CLASSPATH=${CLASSPATH}:../../library/FPJni.jar
CLASSPATH=${CLASSPATH}:../../library/jdom.jar
CLASSPATH=${CLASSPATH}:../../library/jmf.jar

# Sitraka
CLASSPATH=${CLASSPATH}:../../library/jcchart451K.jar
CLASSPATH=${CLASSPATH}:../../library/jcpagelayout451K.jar
CLASSPATH=${CLASSPATH}:../../library/jcfield451K.jar


# JMS
CLASSPATH=${CLASSPATH}:../../library/jms.jar
CLASSPATH=${CLASSPATH}:../../library/jndi.jar
CLASSPATH=${CLASSPATH}:../../library/exolabcore.jar
CLASSPATH=${CLASSPATH}:../../library/openjms-client.jar
CLASSPATH=${CLASSPATH}:../../library/openjms-rmi.jar

# EJB
CLASSPATH=${CLASSPATH}:../../library/ejb.jar
CLASSPATH=${CLASSPATH}:../../library/jboss-client.jar
CLASSPATH=${CLASSPATH}:../../library/jbosssx-client.jar
CLASSPATH=${CLASSPATH}:../../library/jnp-client.jar
CLASSPATH=${CLASSPATH}:../../library/jta-spec1_0_1.jar
CLASSPATH=${CLASSPATH}:../../library/classes111b.zip
CLASSPATH=${CLASSPATH}:../../library/tools.jar

# Security
CLASSPATH=${CLASSPATH}:../../library/ibmjsse.jar
CLASSPATH=${CLASSPATH}:../../library/ibmpkcs.jar
CLASSPATH=${CLASSPATH}:../../library/IBMJCEProvider.jar
CLASSPATH=${CLASSPATH}:../../library/IBMJCEfw.jar

# Retail Logic Credit Authorization
CLASSPATH=${CLASSPATH}:../../library/SolveLink.jar

export CLASSPATH PATH
echo Java Environment Initialized...

#!/bin/bash
echo startPOS.sh is starting...

##############################################
#	CD to working directory
##############################################
cd /usr/opt/app/rpos3.0.0.3/rpos/bin
 
# Release Wincor JavaPOS locks
/usr/local/javapos/wn/bin/wnjavaposipc -r

JAVA_HOME=/opt/IBMJava2-13
PATH=${JAVA_HOME}/bin:${PATH}
LD_LIBRARY_PATH=/usr/local/javapos/wn/bin:${LD_LIBRARY_PATH}

export JAVA_HOME PATH LD_LIBRARY_PATH


CLASSPATH=../classes
CLASSPATH=${CLASSPATH}:jpos/res/jpos.properties
CLASSPATH=${CLASSPATH}:../files/prod/javapos/retek_jpos.xml
CLASSPATH=${CLASSPATH}:/usr/local/javapos/wn/lib/WNJavaPOSControls.jar
CLASSPATH=${CLASSPATH}:/usr/local/javapos/wn/lib/WNJavaPOSServices.jar
CLASSPATH=${CLASSPATH}:/usr/local/javapos/epson/epsonJposService15.jar
CLASSPATH=${CLASSPATH}:/usr/local/javapos/wn/lib/WNCommAPI.jar
CLASSPATH=${CLASSPATH}:/usr/local/javapos/sun/comm.jar
CLASSPATH=${CLASSPATH}:/opt/IBMJava2-13/jre/lib/rt.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_pos.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_time.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_common.jar
CLASSPATH=${CLASSPATH}:../../library/retek_pos.jar
CLASSPATH=${CLASSPATH}:../../library/retek_time.jar
CLASSPATH=${CLASSPATH}:../../library/retek_common.jar
CLASSPATH=${CLASSPATH}:../../library/retek_platform.jar
CLASSPATH=${CLASSPATH}:../../library/cms_app.jar
CLASSPATH=${CLASSPATH}:../../library/cms_sys.app
CLASSPATH=${CLASSPATH}:../../library/cms_help.jar
CLASSPATH=${CLASSPATH}:../../library/cms_tax.jar
CLASSPATH=${CLASSPATH}:../../library/taxware.jar
CLASSPATH=${CLASSPATH}:../../library/xerces.jar
#CLASSPATH=${CLASSPATH}:../../library/jpos15.jar
#CLASSPATH=${CLASSPATH}:../../library/epsonJposService152.jar
#CLASSPATH=${CLASSPATH}:../../library/epsonJposServiceCommon.jar
#CLASSPATH=${CLASSPATH}:../../library/ibmjpos.jar
CLASSPATH=${CLASSPATH}:../../library/parser.jar
CLASSPATH=${CLASSPATH}:../../library/et1000jpos15201.jar
CLASSPATH=${CLASSPATH}:../../library/FPJni.jar
CLASSPATH=${CLASSPATH}:../../library/jdom.jar
CLASSPATH=${CLASSPATH}:../../library/jcchart451K.jar
CLASSPATH=${CLASSPATH}:../../library/jcpagelayout451K.jar
CLASSPATH=${CLASSPATH}:../../library/jcfield451K.jar
CLASSPATH=${CLASSPATH}:../../library/ejb.jar
CLASSPATH=${CLASSPATH}:../../library/jmf.jar

#REM JMS
CLASSPATH=${CLASSPATH}:../../library/jms.jar
CLASSPATH=${CLASSPATH}:../../library/jndi.jar
CLASSPATH=${CLASSPATH}:../../library/exolabcore.jar
CLASSPATH=${CLASSPATH}:../../library/openjms-client.jar
CLASSPATH=${CLASSPATH}:../../library/openjms-rmi.jar

CLASSPATH=${CLASSPATH}:../../library/jboss-client.jar
CLASSPATH=${CLASSPATH}:../../library/jbosssx-client.jar
CLASSPATH=${CLASSPATH}:../../library/jnp-client.jar
CLASSPATH=${CLASSPATH}:../../library/jta-spec1_0_1.jar
CLASSPATH=${CLASSPATH}:../../library/classes111b.zip
CLASSPATH=${CLASSPATH}:../../library/tools.jar
CLASSPATH=${CLASSPATH}:../../library/jce1_2_1.jar
CLASSPATH=${CLASSPATH}:../../library/sunjce_provider.jar
CLASSPATH=${CLASSPATH}:../../library/local_policy.jar
CLASSPATH=${CLASSPATH}:../../library/US_export_policy.jar


export CLASSPATH

################################################################
#	Echo Environment Variables
################################################################
echo PATH=${PATH}
echo CLASSPATH=${CLASSPATH}
java -version


################################################################
#	Run POS
################################################################
java  -showversion -DREDIRECT=false -Djava.security.policy=../../library/policy -DUSER_CONFIG=client_master.cfg -DSTATS_CLASS=com.chelseasystems.cr.node.LinuxProcessStats com.chelseasystems.cr.appmgr.AppManager
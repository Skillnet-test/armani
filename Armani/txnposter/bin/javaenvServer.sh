#!/bin/sh
##########################################################
#       javaenvServer.sh

PATH=/usr/jre_1_3_1_15/jre1.3.1_15/bin/:$PATH:.
export PATH
echo $PATH

CLASSPATH=../classes:.
CLASSPATH=${CLASSPATH}:../../library/patch.jar
CLASSPATH=${CLASSPATH}:../../library/armanirpos.jar
CLASSPATH=${CLASSPATH}:../../library/armanipackage.jar
CLASSPATH=${CLASSPATH}:../../library/cif.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_pos.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_time.jar
CLASSPATH=${CLASSPATH}:../../library/retek_shared_common.jar
CLASSPATH=${CLASSPATH}:../../library/retek_pos.jar
CLASSPATH=${CLASSPATH}:../../library/retek_time.jar
CLASSPATH=${CLASSPATH}:../../library/retek_common.jar
CLASSPATH=${CLASSPATH}:../../library/retek_platform.jar

CLASSPATH=${CLASSPATH}:../../library/retek_app.jar
CLASSPATH=${CLASSPATH}:../../library/retek_sys.jar
CLASSPATH=${CLASSPATH}:../../library/retek_tax.jar
CLASSPATH=${CLASSPATH}:../../library/taxware.jar
CLASSPATH=${CLASSPATH}:../../library/crimson.jar
CLASSPATH=${CLASSPATH}:../../library/xerces.jar

CLASSPATH=${CLASSPATH}:../../library/jndi.jar
CLASSPATH=${CLASSPATH}:../../library/exolabcore.jar
CLASSPATH=${CLASSPATH}:../../library/jms.jar
CLASSPATH=${CLASSPATH}:../../library/openjms-client.jar
CLASSPATH=${CLASSPATH}:../../library/openjms-rmi.jar

CLASSPATH=${CLASSPATH}:../../library/jce1_2_1.jar
CLASSPATH=${CLASSPATH}:../../library/sunjce_provider.jar
CLASSPATH=${CLASSPATH}:../../library/local_policy.jar
CLASSPATH=${CLASSPATH}:../../library/US_export_policy.jar

CLASSPATH=${CLASSPATH}:../../library/jsse.jar
CLASSPATH=${CLASSPATH}:../../library/jnet.jar
CLASSPATH=${CLASSPATH}:../../library/jcert.jar

CLASSPATH=${CLASSPATH}:../../library/cloudscape.jar
CLASSPATH=${CLASSPATH}:../../library/jh.jar
CLASSPATH=${CLASSPATH}:../../library/cloudview.jar
CLASSPATH=${CLASSPATH}:../../library//RmiJdbc.jar
CLASSPATH=${CLASSPATH}:../../library/cloudclient.jar

CLASSPATH=${CLASSPATH}:../../library/classes12.jar
CLASSPATH=${CLASSPATH}:../../library/activation.jar
CLASSPATH=${CLASSPATH}:../../library/mailapi.jar
CLASSPATH=${CLASSPATH}:../../library/imap.jar
CLASSPATH=${CLASSPATH}:../../library/pop3.jar
CLASSPATH=${CLASSPATH}:../../library/smtp.jar

CLASSPATH=${CLASSPATH}:../../library/jce1_2_2.jar
CLASSPATH=${CLASSPATH}:../../library/local_policy.jar
CLASSPATH=${CLASSPATH}:../../library/sunjce_provider.jar
CLASSPATH=${CLASSPATH}:../../library/US_export_policy.jar

CLASSPATH=${CLASSPATH}:../../library/axis.jar
CLASSPATH=${CLASSPATH}:../../library/commons-discovery.jar
CLASSPATH=${CLASSPATH}:../../library/commons-lang-2.0.jar
CLASSPATH=${CLASSPATH}:../../library/commons-logging.jar
CLASSPATH=${CLASSPATH}:../../library/proweb.jar
CLASSPATH=${CLASSPATH}:../../library/jaxrpc.jar
CLASSPATH=${CLASSPATH}:../../library/saaj.jar
CLASSPATH=${CLASSPATH}:../../library/wsdl4j.jar

CLASSPATH=${CLASSPATH}:../../library/Armani/informix/ifxjdbc.j
CLASSPATH=${CLASSPATH}:../../library/Armani/oracle/classes12.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/as400/ibmas400.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/as400/jt400.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/as400/jt400jdbc.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/as400/jt400Proxy.jar

CLASSPATH=${CLASSPATH}:../../library/Armani/util/commons-beanutils.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/commons-collections.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/commons-digester.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/commons-logging.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/commons-logging-api.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/imap.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/ejee.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jcmdline-1.0.2.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jcommon-0.9.6.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jcpagelayout451K.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jdom.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jdt-compiler.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jfreechart-0.9.21.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jta-spec1_0_1.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/jxl.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/javaxsecur.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/looks-1.2.2.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/mail.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/mailapi.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/poi.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/pop3.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/smtp.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/util/tar.jar

CLASSPATH=${CLASSPATH}:../../library/Armani/report/iReport.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/itext-1.02b.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/jasperreports-0.6.4.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/jaxb-api.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/jaxb-impl.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/jaxb-libs.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/jaxb-xjc.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/jax-qname.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/log4j-1.2.8.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/report/log4j-1.2.9.jar

CLASSPATH=${CLASSPATH}:../../library/Armani/xml/namespace.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xalan-2.4.1.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xmlparserv2.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/sax2r2.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/relaxngDatatype.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xalan.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xercesImpl.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xercesImpl-2.2.1.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xml-apis.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xml-apis2.6.0.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xmlParserAPIs.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xmlUpdate.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xerces1.3.0.jar
CLASSPATH=${CLASSPATH}:../../library/Armani/xml/xerces.jar


export CLASSPATH PATH

echo Java environment initialized

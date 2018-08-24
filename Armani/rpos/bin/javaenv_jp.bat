@echo off
set ANT_OPTS=-Dos.name=Windows_NT

set path=..\..\jre\bin;.;%PATH%

REM path=%path%;..\..\UTL
REM path=%path%;..\..\TAXWARE\SALESTAX
REM path=%path%;..\..\TAXWARE\VZIP

set classpath=..\..\library\patch.jar
set classpath=%classpath%;..\..\library\armversion_jp.jar
REM set classpath=%classpath%;..\classes
set classpath=%classpath%;..\..\library\armanirpos.jar
set classpath=%classpath%;..\..\library\armanipackage.jar
set classpath=%classpath%;..\..\library\armaniimages.jar
set classpath=%classpath%;..\..\library\armaniext.jar

REM ############ QAS JARS ###################################
set classpath=%classpath%;..\..\library\axis.jar
set classpath=%classpath%;..\..\library\commons-discovery.jar
set classpath=%classpath%;..\..\library\commons-lang-2.0.jar
set classpath=%classpath%;..\..\library\commons-logging.jar
set classpath=%classpath%;..\..\library\crimson.jar
set classpath=%classpath%;..\..\library\jaxrpc.jar
set classpath=%classpath%;..\..\library\proweb.jar
set classpath=%classpath%;..\..\library\saaj.jar
set classpath=%classpath%;..\..\library\wsdl4j.jar


set classpath=%classpath%;..\..\library\retek_shared_pos.jar
set classpath=%classpath%;..\..\library\retek_shared_time.jar
set classpath=%classpath%;..\..\library\retek_shared_common.jar
set classpath=%classpath%;..\..\library\retek_pos.jar
set classpath=%classpath%;..\..\library\retek_time.jar
set classpath=%classpath%;..\..\library\retek_common.jar
set classpath=%classpath%;..\..\library\retek_platform.jar
set classpath=%classpath%;..\..\library\retek_app.jar
set classpath=%classpath%;..\..\library\retek_sys.jar
set classpath=%classpath%;..\..\library\retek_help.jar
set classpath=%classpath%;..\..\library\retek_tax.jar

set classpath=%classpath%;..\..\library\jpos19.jar
set classpath=%classpath%;..\..\library\pos.jar
set classpath=%classpath%;..\..\library\epsonupos.jar
set classpath=%classpath%;..\..\library\uposcommon.jar
set classpath=%classpath%;..\..\library\linuxUsbDriver.jar
set classpath=%classpath%;..\..\library\xercesImpl.jar
set classpath=%classpath%;..\..\library\xml-apis.jar

rem set classpath=%classpath%;..\..\library\taxware.jar
rem set classpath=%classpath%;..\..\library\xerces.jar
rem set classpath=%classpath%;..\..\library\comm.jar
rem set classpath=%classpath%;..\files\prod\javapos\retek_jpos.xml
rem set classpath=%classpath%;..\..\library\jpos15.jar
rem set classpath=%classpath%;..\..\library\ibmjpos1.5.045.jar
rem set classpath=%classpath%;..\..\library\epsonJposService152.jar
rem set classpath=%classpath%;..\..\library\epsonJposServiceCommon.jar
rem set classpath=%classpath%;..\..\library\parser.jar
rem set classpath=%classpath%;..\..\library\et1000jpos15201.jar

set classpath=%classpath%;..\..\library\FPJni.jar
set classpath=%classpath%;..\..\library\jdom.jar
set classpath=%classpath%;..\..\library\jmf.jar

REM Sitraka
set classpath=%classpath%;..\..\library\jcchart451K.jar
set classpath=%classpath%;..\..\library\jcpagelayout451K.jar
set classpath=%classpath%;..\..\library\jcfield451K.jar

REM JMS
set classpath=%classpath%;..\..\library\jms.jar
set classpath=%classpath%;..\..\library\jndi.jar
set classpath=%classpath%;..\..\library\exolabcore.jar
set classpath=%classpath%;..\..\library\openjms-client.jar
set classpath=%classpath%;..\..\library\openjms-rmi.jar

REM EJB
set classpath=%classpath%;..\..\library\ejb.jar
set classpath=%classpath%;..\..\library\jboss-client.jar
set classpath=%classpath%;..\..\library\jbosssx-client.jar
set classpath=%classpath%;..\..\library\jnp-client.jar
set classpath=%classpath%;..\..\library\jta-spec1_0_1.jar
set classpath=%classpath%;..\..\library\classes111b.zip
set classpath=%classpath%;..\..\library\tools.jar

REM Security
set classpath=%classpath%;..\..\library\ibmjsse.jar
set classpath=%classpath%;..\..\library\ibmpkcs.jar
set classpath=%classpath%;..\..\library\IBMJCEProvider.jar
set classpath=%classpath%;..\..\library\IBMJCEfw.jar

set classpath=%classpath%;..\..\library\classes12.jar

set classpath=%classpath%;..\..\library\jxl.jar

set classpath=%classpath%;..\..\library\activation.jar
set classpath=%classpath%;..\..\library\mailapi.jar
set classpath=%classpath%;..\..\library\imap.jar
set classpath=%classpath%;..\..\library\pop3.jar
set classpath=%classpath%;..\..\library\smtp.jar
set classpath=%classpath%;..\..\library\ga.jar

echo Java Environment Initialized...

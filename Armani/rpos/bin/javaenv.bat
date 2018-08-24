@echo off

set ANT_OPTS=-Dos.name=Windows_NT

REM set path=..\..\jre\bin;.;%PATH%

set path=..\..\jre\bin;.;%PATH%

REM path=%path%;..\..\UTL
REM path=%path%;..\..\TAXWARE\SALESTAX
REM path=%path%;..\..\TAXWARE\VZIP

set classpath=..\..\library\patch.jar
set classpath=%classpath%;..\..\library\armversion_us.jar
REM set classpath=%classpath%;..\classes
set classpath=%classpath%;..\..\library\armanirpos.jar
set classpath=%classpath%;..\..\library\armanipackage.jar

set classpath=%classpath%;..\..\library\ISD\commons-logging-1.0.4.jar
set classpath=%classpath%;..\..\library\ISD\isdcrypt-6.3.0.008.jar
set classpath=%classpath%;..\..\library\ISD\jec-6.1.0.jar
set classpath=%classpath%;..\..\library\log4j-1.2.16.jar
set classpath=%classpath%;..\..\library\ISD\IMSRTRIBSpecSDK-290.jar
set classpath=%classpath%;..\..\library\DBMigration.jar
set classpath=%classpath%;..\..\library\classes12.jar
set classpath=%classpath%;..\..\library\jai_codec-1.1.3.jar
set classpath=%classpath%;..\..\library\sun-jai_core.jar
set classpath=%classpath%;..\..\library\ojdbc14.jar


set classpath=%classpath%;..\..\library\armaniext.jar
set classpath=%classpath%;..\..\library\armaniimages.jar
REM set classpath=%classpath%;..\rpos\bin
set classpath=%classpath%;C:\clientwindows1.5\US\retek\rpos\bin

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

set classpath=%classpath%;..\..\library\taxware.jar
set classpath=%classpath%;..\..\library\xerces.jar
set classpath=%classpath%;..\..\library\comm.jar
set classpath=%classpath%;..\files\prod\javapos\retek_jpos.xml
set classpath=%classpath%;..\..\library\jpos15.jar
set classpath=%classpath%;..\..\library\ibmjpos1.5.045.jar
set classpath=%classpath%;..\..\library\epsonJposService152.jar
set classpath=%classpath%;..\..\library\epsonJposServiceCommon.jar
set classpath=%classpath%;..\..\library\parser.jar
set classpath=%classpath%;..\..\library\et1000jpos15201.jar
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

REM for Europe
set classpath=%classpath%;..\..\library\jcl.jar
set classpath=%classpath%;..\..\library\jpos18.jar
set classpath=%classpath%;..\..\library\setefipackage.jar

set classpath=%classpath%;..\..\library\armani\informix\ifxjdbc.j
set classpath=%classpath%;..\..\library\armani\oracle\classes12.jar
set classpath=%classpath%;..\..\library\armani\as400\ibmas400.jar
set classpath=%classpath%;..\..\library\armani\as400\jt400.jar
set classpath=%classpath%;..\..\library\armani\as400\jt400jdbc.jar
set classpath=%classpath%;..\..\library\armani\as400\jt400Proxy.jar

set classpath=%classpath%;..\..\library\armani\util\commons-beanutils.jar
set classpath=%classpath%;..\..\library\armani\util\commons-collections.jar
set classpath=%classpath%;..\..\library\armani\util\commons-digester.jar
set classpath=%classpath%;..\..\library\armani\util\commons-logging.jar
set classpath=%classpath%;..\..\library\armani\util\commons-logging-api.jar
set classpath=%classpath%;..\..\library\armani\util\imap.jar
set classpath=%classpath%;..\..\library\armani\util\ejee.jar
set classpath=%classpath%;..\..\library\armani\util\jcmdline-1.0.2.jar
set classpath=%classpath%;..\..\library\armani\util\jcommon-0.9.6.jar
set classpath=%classpath%;..\..\library\armani\util\jcpagelayout451K.jar
set classpath=%classpath%;..\..\library\armani\util\jdom.jar
set classpath=%classpath%;..\..\library\armani\util\jdt-compiler.jar
set classpath=%classpath%;..\..\library\armani\util\jfreechart-0.9.21.jar
set classpath=%classpath%;..\..\library\armani\util\jta-spec1_0_1.jar
set classpath=%classpath%;..\..\library\armani\util\jxl.jar
set classpath=%classpath%;..\..\library\armani\util\javaxsecur.jar
set classpath=%classpath%;..\..\library\armani\util\looks-1.2.2.jar
set classpath=%classpath%;..\..\library\armani\util\mail.jar
set classpath=%classpath%;..\..\library\armani\util\mailapi.jar
set classpath=%classpath%;..\..\library\armani\util\poi.jar
set classpath=%classpath%;..\..\library\armani\util\pop3.jar
set classpath=%classpath%;..\..\library\armani\util\smtp.jar
set classpath=%classpath%;..\..\library\armani\util\tar.jar

set classpath=%classpath%;..\..\library\armani\report\iReport.jar
set classpath=%classpath%;..\..\library\armani\report\itext-1.02b.jar
set classpath=%classpath%;..\..\library\armani\report\jasperreports-0.6.4.jar
set classpath=%classpath%;..\..\library\armani\report\jaxb-api.jar
set classpath=%classpath%;..\..\library\armani\report\jaxb-impl.jar
set classpath=%classpath%;..\..\library\armani\report\jaxb-libs.jar
set classpath=%classpath%;..\..\library\armani\report\jaxb-xjc.jar
set classpath=%classpath%;..\..\library\armani\report\jax-qname.jar
REM set classpath=%classpath%;..\..\library\armani\report\log4j-1.2.8.jar
REM set classpath=%classpath%;..\..\library\armani\report\log4j-1.2.9.jar
set classpath=%classpath%;..\..\library\armani\report\xsdlib.zip

set classpath=%classpath%;..\..\library\armani\xml\namespace.jar
set classpath=%classpath%;..\..\library\armani\xml\xalan-2.4.1.jar
set classpath=%classpath%;..\..\library\armani\xml\xmlparserv2.jar
set classpath=%classpath%;..\..\library\armani\xml\sax2r2.jar
set classpath=%classpath%;..\..\library\armani\xml\relaxngDatatype.jar
set classpath=%classpath%;..\..\library\armani\xml\xalan.jar
set classpath=%classpath%;..\..\library\armani\xml\xercesImpl.jar
set classpath=%classpath%;..\..\library\armani\xml\xercesImpl-2.2.1.jar
set classpath=%classpath%;..\..\library\armani\xml\xml-apis.jar
set classpath=%classpath%;..\..\library\armani\xml\xml-apis2.6.0.jar
set classpath=%classpath%;..\..\library\armani\xml\xmlParserAPIs.jar
set classpath=%classpath%;..\..\library\armani\xml\xmlUpdate.jar
set classpath=%classpath%;..\..\library\armani\xml\xerces1.3.0.jar
set classpath=%classpath%;..\..\library\armani\xml\xerces.jar

set classpath=%classpath%;..\..\library\armani\informix\ifxjdbc.j
set classpath=%classpath%;..\..\library\armani\oracle\classes12.jar
set classpath=%classpath%;..\..\library\armani\as400\ibmas400.jar
set classpath=%classpath%;..\..\library\armani\as400\jt400.jar
set classpath=%classpath%;..\..\library\armani\as400\jt400jdbc.jar
set classpath=%classpath%;..\..\library\armani\as400\jt400Proxy.jar


REM Europe finish

REM Setting the classpath for ISD Encryption toolkit 
REM set classpath=%classpath%;..\..\library\ISD\jec-6.1.0.jar
REM set classpath=%classpath%;..\..\library\ISD\isdcrypt-6.3.0.008.jar
REM set classpath=%classpath%;..\..\library\ISD\commons-logging-1.0.4.jar
REM set classpath=%classpath%;..\..\library\log4j-1.2.9.jar
REM set classpath=%classpath%;..\..\library\log4j-1.2.16.jar
REM set classpath=%classpath%;..\..\library\ISD\IMSRTRIBSpecSDK-290.jar
REM set classpath=%classpath%;..\..\library\ojdbc14.jar
REM set path=%path%;..\..\library\ISD\isdjavatoolkit.properties

set classpath=%classpath%;..\..\library\base64.jar


echo Java Environment Initialized...
@echo off

path=..\..\jdk1.5.0\jre\bin;.;%PATH%

set classpath=..\classes
set classpath=%classpath%;..\..\library\patch.jar
set classpath=%classpath%;..\..\library\armaniext.jar
set classpath=%classpath%;..\..\library\armanirpos.jar
set classpath=%classpath%;..\..\library\armanipackage.jar
REM set classpath=%classpath%;..\..\library\javax.comm.properties

set classpath=%classpath%;..\..\library\retek_shared_pos.jar
set classpath=%classpath%;..\..\library\retek_shared_time.jar
set classpath=%classpath%;..\..\library\retek_shared_common.jar
set classpath=%classpath%;..\..\library\retek_pos.jar
set classpath=%classpath%;..\..\library\retek_time.jar
set classpath=%classpath%;..\..\library\retek_common.jar
set classpath=%classpath%;..\..\library\retek_platform.jar

set classpath=%classpath%;..\..\library\retek_app.jar
set classpath=%classpath%;..\..\library\retek_sys.jar
set classpath=%classpath%;..\..\library\retek_tax.jar
set classpath=%classpath%;..\..\library\taxware.jar
set classpath=%classpath%;..\..\library\crimson.jar
set classpath=%classpath%;..\..\library\xerces.jar

set classpath=%classpath%;..\..\library\jms.jar
set classpath=%classpath%;..\..\library\jndi.jar
set classpath=%classpath%;..\..\library\exolabcore.jar
set classpath=%classpath%;..\..\library\openjms-client.jar
set classpath=%classpath%;..\..\library\openjms-rmi.jar

set classpath=%classpath%;..\..\library\jce1_2_1.jar
set classpath=%classpath%;..\..\library\sunjce_provider.jar
set classpath=%classpath%;..\..\library\local_policy.jar
set classpath=%classpath%;..\..\library\US_export_policy.jar

set classpath=%classpath%;..\..\library\cloudscape.jar
set classpath=%classpath%;..\..\library\jh.jar
set classpath=%classpath%;..\..\library\cloudview.jar
set classpath=%classpath%;..\..\library\RmiJdbc.jar
set classpath=%classpath%;..\..\library\cloudclient.jar

set classpath=%classpath%;..\..\library\jsse.jar
set classpath=%classpath%;..\..\library\jnet.jar
set classpath=%classpath%;..\..\library\jcert.jar
set classpath=%classpath%;..\..\library\classes12.jar
set classpath=%classpath%;..\..\library\activation.jar
set classpath=%classpath%;..\..\library\mailapi.jar
set classpath=%classpath%;..\..\library\imap.jar
set classpath=%classpath%;..\..\library\pop3.jar
set classpath=%classpath%;..\..\library\smtp.jar

set classpath=%classpath%;..\..\library\jce1_2_2.jar
set classpath=%classpath%;..\..\library\local_policy.jar
set classpath=%classpath%;..\..\library\sunjce_provider.jar
set classpath=%classpath%;..\..\library\US_export_policy.jar

set classpath=%classpath%;..\..\library\axis.jar
set classpath=%classpath%;..\..\library\commons-discovery.jar
set classpath=%classpath%;..\..\library\commons-lang-2.0.jar
set classpath=%classpath%;..\..\library\commons-logging.jar
set classpath=%classpath%;..\..\library\crimson.jar
set classpath=%classpath%;..\..\library\proweb.jar
set classpath=%classpath%;..\..\library\jaxrpc.jar
set classpath=%classpath%;..\..\library\saaj.jar
set classpath=%classpath%;..\..\library\wsdl4j.jar
set classpath=%classpath%;..\..\library\servlet-api.jar

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
set classpath=%classpath%;..\..\library\armani\report\log4j-1.2.8.jar
set classpath=%classpath%;..\..\library\armani\report\log4j-1.2.9.jar

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

REM Setting the classpath for ISD Encryption toolkit 
set classpath=%classpath%;..\..\library\ISD\jec-6.1.0.jar
set classpath=%classpath%;..\..\library\ISD\isdcrypt-6.3.0.008.jar
set classpath=%classpath%;..\..\library\ISD\commons-logging-1.0.4.jar
set classpath=%classpath%;..\..\library\ISD\log4j-1.2.9.jar
set classpath=%classpath%;..\..\library\ISD\IMSRTRIBSpecSDK-290.jar
set classpath=%classpath%;..\..\library\ojdbc14.jar


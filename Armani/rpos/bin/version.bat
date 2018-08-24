@echo off
TITLE Retek ISO-RPOS Version...

call javaenv.bat
set classpath=%classpath%;..\..\library\cif.jar

java com.chelseasystems.cs.util.Version
java com.cif.Version
java com.chelseasystems.cr.appmgr.Version
java com.chelseasystems.mc.Version
java com.chelseasystems.ab.Version
java com.chelseasystems.rb.Version
java com.chelseasystems.cs.merchandise.ma.Version
java com.chelseasystems.oi.Version

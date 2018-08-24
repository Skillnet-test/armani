@echo off
TITLE Retek ISO-RPOS Merchandise Admin...

call javaenv.bat

java -showversion -DREDIRECT=false com.chelseasystems.cs.merchandise.ma.MerchandiseAdmin

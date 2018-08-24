@echo off
TITLE Retek ISO-RPOS Mission Control...

call javaenv.bat

java -showversion -Djava.security.policy=../lib/policy com.chelseasystems.mc.TuningAdmin

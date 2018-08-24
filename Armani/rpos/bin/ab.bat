@echo off
TITLE Retek ISO-RPOS Application Builder

call javaenv.bat

java -showversion -Djava.security.policy=../../library/policy com.chelseasystems.ab.AppBuilder

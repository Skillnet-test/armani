#!/bin/sh
############################################################
#       stopCS.sh
. ./javaenvServer.sh

#java RJPing jdbc:cloudscape:rmi:;shutdown=true;user=;password= connect
java RJPing jdbc:cloudscape:rmi: shutdown

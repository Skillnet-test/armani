#!/bin/sh
############################################################
#       startemall.sh
ulimit -n 131072

if [ -d monitor_rns ] ; then
    rm monitor_rns/*
fi

if [ -d rns_dir ] ; then
    rm rns_dir/*
fi

if [ -d ../log_old ] ; then
    mv ../log/* ../log/old/.
fi

if [ ! -d ../log_old ] ; then
    mkdir ../log_old
fi

./startCS.sh &

sleep 10
./startJMS.sh &

sleep 10
./rns.sh &

sleep 10
./node_rns.sh &

sleep 10
./msg_monitor.sh &

sleep 10
./node.sh &


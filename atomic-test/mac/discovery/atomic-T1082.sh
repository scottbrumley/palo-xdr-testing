#!/bin/bash

echo  "T1082 - System Information Discovery"

echo "Atomic Test #2 - System Information Discovery"
system_profiler
ls -al /Applications

echo "Atomic Test #3 - List OS Information"

OUTPUT_FILE=/tmp/T1082.txt

uname -a >> ${OUTPUT_FILE}
if [ -f /etc/lsb-release ]; then cat /etc/lsb-release >> ${OUTPUT_FILE}; fi;
if [ -f /etc/redhat-release ]; then cat /etc/redhat-release >> ${OUTPUT_FILE}; fi;
if [ -f /etc/issue ]; then cat /etc/issue >> ${OUTPUT_FILE}; fi;
uptime >> ${OUTPUT_FILE}
cat ${OUTPUT_FILE} 2>/dev/null

echo "Atomic Test #7 - Hostname Discovery"
hostname

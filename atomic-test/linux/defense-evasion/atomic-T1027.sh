#!/bin/bash

echo T1027 - Ovfuscated files or Information

echo Atomic Test #1 - Decode base64 Data into Script
sh -c "echo ZWNobyBIZWxsbyBmcm9tIHRoZSBBdG9taWMgUmVkIFRlYW0= > /tmp/encoded.dat"
cat /tmp/encoded.dat | base64 -d > /tmp/art.sh
chmod +x /tmp/art.sh
/tmp/art.sh

echo Atomic Test #1 - Decode base64 Data into Script

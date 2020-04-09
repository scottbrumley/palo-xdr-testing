#!/bin/bash

echo "T1496 - Resource Hijacking"

echo "Atomic Test #1 - macOS/Linux - Simulate CPU Load with Yes"
yes > /dev/null &
sleep 60
sudo killall yes


#!/bin/bash

echo Checkin Cortex
sudo /opt/traps/bin/cytool checkin

echo "Running Defense Evasion Attacks"
/vagrant/atomic-test/linux/defense-evasion/atomic-T1009.sh

echo "Running Discovery Attacks"
/vagrant/atomic-test/linux/discovery/atomic-T1016.sh
/vagrant/atomic-test/linux/discovery/atomic-T1033.sh
/vagrant/atomic-test/linux/discovery/atomic-T1082.sh



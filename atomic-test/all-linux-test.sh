#!/bin/bash

echo "Running Defense Evasion Attacks"
/vagrant/atomic-test/linux/defense-evasion/atomic-T1009.sh

echo "Running Impact Attacks"
/vagrant/atomic-test/linux/impact/atomic-T1496.sh

echo "Running Persistence Attacks"
/vagrant/atomic-test/linux/persistence/atomic-T1156.sh
/vagrant/atomic-test/linux/persistence/atomic-T1158.sh

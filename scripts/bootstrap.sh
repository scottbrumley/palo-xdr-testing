#!/bin/bash

echo Make Sure Test are Executable
chmod -R +x /vagrant/atomic-test/linux/*

echo Install The Cortex XDR Agent
sudo chmod +x /vagrant/private/linuxos.sh
sudo /vagrant/private/linuxos.sh --quiet

echo Checkin Cortex
sudo /opt/traps/bin/cytool checkin



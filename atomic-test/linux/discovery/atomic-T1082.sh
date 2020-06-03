#!/bin/bash

echo  "T1082 - System Information Discovery"

echo "Atomic Test #3 - List OS Information"

OUTPUT_FILE=/tmp/T1082.txt

uname -a >> ${OUTPUT_FILE}
if [ -f /etc/lsb-release ]; then cat /etc/lsb-release >> ${OUTPUT_FILE}; fi;
if [ -f /etc/redhat-release ]; then cat /etc/redhat-release >> ${OUTPUT_FILE}; fi;
if [ -f /etc/issue ]; then cat /etc/issue >> ${OUTPUT_FILE}; fi;
uptime >> ${OUTPUT_FILE}
cat ${OUTPUT_FILE} 2>/dev/null

echo "Atomic Test #4 - Linux VM Check via Hardware"
if [ -f /sys/class/dmi/id/bios_version ]; then cat /sys/class/dmi/id/bios_version | grep -i amazon; fi;
if [ -f /sys/class/dmi/id/product_name ]; then cat /sys/class/dmi/id/product_name | grep -i "Droplet\|HVM\|VirtualBox\|VMware"; fi;
if [ -f /sys/class/dmi/id/product_name ]; then cat /sys/class/dmi/id/chassis_vendor | grep -i "Xen\|Bochs\|QEMU"; fi;
if [ -x "$(command -v dmidecode)" ]; then sudo dmidecode | grep -i "microsoft\|vmware\|virtualbox\|quemu\|domu"; fi;
if [ -f /proc/scsi/scsi ]; then cat /proc/scsi/scsi | grep -i "vmware\|vbox"; fi;
if [ -f /proc/ide/hd0/model ]; then cat /proc/ide/hd0/model | grep -i "vmware\|vbox\|qemu\|virtual"; fi;
if [ -x "$(command -v lspci)" ]; then sudo lspci | grep -i "vmware\|virtualbox"; fi;
if [ -x "$(command -v lscpu)" ]; then sudo lscpu | grep -i "Xen\|KVM\|Microsoft"; fi;

echo "Atomic Test #5 - Linux VM Check via Kernel Modules"
sudo lsmod | grep -i "vboxsf\|vboxguest"
sudo lsmod | grep -i "vmw_baloon\|vmxnet"
sudo lsmod | grep -i "xen-vbd\|xen-vnif"
sudo lsmod | grep -i "virtio_pci\|virtio_net"
sudo lsmod | grep -i "hv_vmbus\|hv_blkvsc\|hv_netvsc\|hv_utils\|hv_storvsc"

echo "Atomic Test #7 - Hostname Discovery"
hostname

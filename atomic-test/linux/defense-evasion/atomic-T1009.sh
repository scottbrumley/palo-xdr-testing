#!/bin/bash

echo T1009 Binary Padding

echo Atomic Test #1 - Pad Binary to Change Hash - Linux/macOS dd
dd if=/dev/zero bs=1 count=1 >> /tmp/evil-binary

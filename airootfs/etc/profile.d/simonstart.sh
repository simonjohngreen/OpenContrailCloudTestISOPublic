#!/bin/bash
#This script should only be executed once
if [ ! -f /tmp/boot-completed ]
then
        echo root:simon123 | chpasswd
        touch /tmp/boot-completed
fi

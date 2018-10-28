#!/bin/bash

# cloud-init expects to fine user syslog, even though the logs go to jounrnalctl -x
useradd syslog
# cloud init fails to start unless this user exists
useradd -m archlinux
# only start cloud-init if the ec2 address responds
# the usual response for unconfigured hypervisors in 28 , timeout
curl -s --connect-timeout 5 http://169.254.169.254
if [ $? -eq 0 ]; then
        systemctl enable cloud-init-local.service
        systemctl enable cloud-init.service
        systemctl enable cloud-config.target
        systemctl enable cloud-config.service
        systemctl enable cloud-final.service
        systemctl start cloud-init-local.service
        systemctl start cloud-init.service
        systemctl start cloud-config.target
        systemctl start cloud-config.service
        systemctl start cloud-final.service
else
        echo "EC2 Meta Data is not enabled to we won't start cloud-init"
fi

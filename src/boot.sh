#!/usr/bin/env bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin

set -e

ln -sf /mnt/onl/config/dhtech/interfaces /etc/network/interfaces.d/dhtech

HOSTNAME=$(< /mnt/onl/config/dhtech/hostname)
DOMAIN=$(< /mnt/onl/config/dhtech/domain)
echo "${HOSTNAME}" > /etc/hostname
echo "127.0.0.1 ${HOSTNAME}.${DOMAIN} ${HOSTNAME}" >> /etc/hosts
echo "::1 localhost ip6-localhost ip6-loopback" >> /etc/hosts

cat << _EOF_ > /sbin/dh-principals
#!/bin/bash
if [ "\$1" == "dhtech" ]; then
  echo \$2
else
  echo \$1
fi
_EOF_
chmod +x /sbin/dh-principals

cat << _EOF_ > /etc/ssh/ssh_ca.pub
ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAC/xT7a8A4Gm1Tf0mpKstqncWsOZpGPKa0lqf7EuYSpWUnx5QLaiP2TcI80AELTw2gP9jzOkpN7/QO91V3edRXGLAGk3NiNZLqvJspYfAnEo9f3/E4GBZf4kcDC93+04SzbFg+qMY3iCmJNaIttUMdQwaR22c+HbOYhaGEFWN3OCa6Erw== vault@tech.dreamhack.se
_EOF_

cat << _EOF_ >> /etc/ssh/sshd_config
TrustedUserCAKeys /etc/ssh/ssh_ca.pub
AuthorizedPrincipalsCommand /sbin/dh-principals %u %i
AuthorizedPrincipalsCommandUser nobody
PasswordAuthentication no
_EOF_

useradd -m dhtech -s /bin/bash
echo 'dhtech ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/dreamhack

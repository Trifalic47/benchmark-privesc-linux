#!/usr/bin/env bash
set -e
apt-get update && apt-get install -y cron && apt-get clean

cat >/home/lowpriv/cron.sh <<"EOF"
#!/bin/bash -p
echo 'hello from cron' >> /tmp/cron.log
EOF
chmod 777 /home/lowpriv/cron.sh

echo "# end of file" >> /etc/crontab # prevent false positives in our root detection when cat /etc/crontab

echo "* * * * * root /home/lowpriv/cron.sh" >/etc/cron.d/lowpriv_script
crontab /etc/cron.d/lowpriv_script
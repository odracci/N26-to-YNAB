#!/bin/bash

echo ACCOUNTS: $ACCOUNTS

# Create the crontab
touch /etc/cron.d/app
echo > /etc/cron.d/app

#touch "$HOME/n26.log"
#
## Fill the crontab
#for ACCOUNT in $ACCOUNTS; do
#  echo "$CRONTAB"'    cd /app && .venv/bin/python main.py -a '"$ACCOUNT"' >> $HOME/n26.log 2>&1' >> /etc/cron.d/app
#done
#
#cat /etc/cron.d/app
#
## Give execution rights on the cron job
#chmod 0644 /etc/cron.d/app
#
## Apply cron job
#crontab /etc/cron.d/app
#
## Create the log file to be able to run tail
#touch /var/log/cron.log

while [ true ]; do
  for ACCOUNT in $ACCOUNTS; do
    echo "----------------$ACCOUNT--------------------------"
    echo "[$(date --iso-8601=seconds)] [$ACCOUNT]"
    cd /app && .venv/bin/python main.py -a "$ACCOUNT"
    EXITCODE=$?
    echo "exit code: $EXITCODE"
    echo "----------------$ACCOUNT--------------------------"
    if [ $EXITCODE -ne 0 ]; then
      echo "Script failed!"
      exit $EXITCODE
    fi
  done
  sleep 600
done

# Run the cron and show the log
#cron && tail -f "$HOME/n26.log"

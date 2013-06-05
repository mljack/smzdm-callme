#!/bin/bash
# Monitor new callfile in /tmp, 
# if there is any, move it to Asterisk outgoing folder, so a call will be initialized
# Add a line to /etc/rc.local
# So this script will run after bootup
# nohup /root/mv_call_file_to_asterisk_outgoing_folder.sh 0<&- &>/dev/null &

while [ "true" ]
do
  mv /tmp/*.call /var/spool/asterisk/outgoing/ >/dev/null 2>&1
  sleep 0.5
done
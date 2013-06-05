#!/bin/bash
# Monitor new callfile in /tmp, 
# if there is any, move it to Asterisk outgoing folder, so a call will be initialized
while [ "true" ]
do
  mv /tmp/*.call /var/spool/asterisk/outgoing/ >/dev/null 2>&1
  sleep 0.5
done
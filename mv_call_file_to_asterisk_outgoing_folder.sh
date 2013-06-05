#!/bin/bash
while [ "true" ]
do
  mv /tmp/*.call /var/spool/asterisk/outgoing/ >/dev/null 2>&1
  sleep 0.5
done
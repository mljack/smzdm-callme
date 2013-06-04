#!/bin/bash

#Your SIP Trunk info
SIPCHANNEL="SIP/86xxxxxx/mymobilephone"
TITLE=$(echo $1 | sed 's/ *$//g')
sudo tee "/tmp/smzdm$RANDOM.call" > /dev/null <<EOF
Channel: $SIPCHANNEL
MaxRetries: 1
RetryTime: 60
WaitTime: 30
Application: AGI
Data: googletts.agi, $TITLE ,zh-CN
Priority: 1
EOF
#!/bin/bash

#Change it to YOUR SIP TRUNK
#此处是你Asterisk外呼Trunk的信息
#SIP或者DAHDI
SIPCHANNEL="SIP/8610xxxxxxx/YOURMOBILEPHONE"
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
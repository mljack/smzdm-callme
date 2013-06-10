#!/bin/bash
RSS_URL=http://feed.smzdm.com/
#Define your keyword
#定义你感兴趣的关键词，多个关键词用|隔开
KEYWORD='神价格|整理|手慢无|历史低价|bug|八哥'
DBFILE=/tmp/smzdm.db
TMPFILE=/tmp/smzdm.tmp

#夜间免打扰判断
#取当前时间
current_time=`date +%H%M`;
#睡觉时间
SLEEP_TIME='2200'
#睡醒时间
WAKEUP_TIME='0800'

if [ "$current_time" -ge $SLEEP_TIME ] || [ "$current_time" -le $WAKEUP_TIME ]; then
   echo "No alert during sleep!"
   exit 1
fi
#对所有没有通知用户的记录
sqlite3 $DBFILE "select id from smzdm where flag='NOTCALLED'" | while read line;
do
#GET TITLE
#取标题
TITLE=$(sqlite3 $DBFILE "select title from smzdm where id=$line")
#REMOVE SPACES
#删除标题里的空格，因为TTS的时候空格无意义而且会造成bash参数传递错误
TITLE=$(echo $TITLE | tr -d ' ')
#Generate callfile for Asterisk, TITLE is sent for Google Translate TTS
#调用脚本生成Asterisk的callfile，TITLE作为参数传递给AGI生成TTS语音
#Send log to syslog 发送日志到syslog
logger "Calling for $TITLE"
/root/smzdm-callme/callfile-generator.sh $TITLE
echo $TITLE
#Toggle the CALLED/NOTCALLED flag
#设置记录为已通知用户
sqlite3 $DBFILE "UPDATE smzdm SET flag='CALLED' where id=$line"

done
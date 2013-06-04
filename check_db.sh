#!/bin/bash
RSS_URL=http://feed.smzdm.com/
KEYWORD='神价格|整理|手慢无|历史低价|bug|八哥'
DBFILE=/tmp/smzdm.db
TMPFILE=/tmp/smzdm.tmp

sqlite3 $DBFILE "select id from smzdm where flag='NOTCALLED'" | while read line;
do
#GET TITLE
TITLE=$(sqlite3 $DBFILE "select title from smzdm where id=$line")
#REMOVE SPACES
TITLE=$(echo $TITLE | tr -d ' ')
#Generate callfile for Asterisk, TITLE is sent for Google Translate TTS
/root/smzdm-callme/callfile-generator.sh $TITLE
echo $TITLE
#Toggle the CALLED/NOTCALLED flag
sqlite3 $DBFILE "UPDATE smzdm SET flag='CALLED' where id=$line"

done
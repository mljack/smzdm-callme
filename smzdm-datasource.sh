#!/bin/bash
#RSS数据源地址，什么值得买网站RSS
RSS_URL=http://feed.smzdm.com/
#Define your keyword
#定义你感兴趣的关键词，多个关键词用|隔开
KEYWORD='神价格|手慢无|历史低价|bug|八哥|尿裤'
DBFILE=/tmp/smzdm.db
TMPFILE=/tmp/smzdm.tmp

if [ -f $DBFILE ];
then
   echo "File $DBFILE exists."
else
   echo "File $DBFILE does not exist. Creating the DB file..."
   sqlite3 $DBFILE "create table smzdm (id INTEGER PRIMARY KEY, title TEXT,flag TEXT);"
fi

wget ${RSS_URL} -O - 2>/dev/null | 
	xmlstarlet sel -t -m "/rss/channel/item" -v "guid" -n -v "title" -n -v "link" -n -n | 
	sed '/^$/d' | sed '$!N;s/\n/ /' | egrep -hi $KEYWORD > $TMPFILE
	
	
cat $TMPFILE | while read line;
do 
#取标题部分，删除URL部分
TITLE=$(echo $line | sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g')
#取什么值得买ID作为主键加入数据库
ITEMID=${line##*/}

HIT=$(sqlite3 $DBFILE  "select * from smzdm where id=$ITEMID"|wc -l)
#如果至少有一条匹配关键词则插入到数据库里
if [ $HIT = 0 ]; then
 echo "NOT HIT";
 sqlite3 $DBFILE "insert into smzdm (id,title,flag) values ('$ITEMID','$TITLE','NOTCALLED');";
 fi
done
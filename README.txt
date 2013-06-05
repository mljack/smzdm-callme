magang@gmail.com 2013.6.4

smzdm-datasource.sh程序通过wget下载smzdm.com网站的RSS，输出给xmlstarlet处理，经过关键词egrep匹配保存到$TMPFILE文件
关键词在smzdm-datasource.sh里KEYWORD定义，多个关键词通过|分隔
Bash循环将$TMPFILE的促销信息逐一添加到SQLite数据库smzdm.db，标记为NOTCALLED，即没有发出过通知。

check_db.sh脚本检查smzdm.db数据库，遇到NOTCALLED未通知的记录就调用callfile-generator.sh，并把记录的标题title作为参数传递。

callfile-generator.sh根据获得的标题title生成callfile，呼叫制定电话号码，并对接asterisk-googletts生成促销信息的TTS发音。

安装时
需要安装asterisk-googletts
需要安装xmlstarlet http://xmlstar.sourceforge.net/download.php
修改脚本为可执行chmod a+x *.sh
修改/etc/crontab添加
	#smzdm-callme
	*/1  * * * * root /root/smzdm-callme/smzdm-datasource.sh
	*/1  * * * * root /root/smzdm-callme/check_db.sh
修改/etc/rc.local添加
 # Monitor new callfile in /tmp, 
 # if there is any, move it to Asterisk outgoing folder, so a call will be initialized
 # So this script will run after bootup
  nohup /root/mv_call_file_to_asterisk_outgoing_folder.sh 0<&- &>/dev/null &
  
即实现每分钟检查网站

SQLite调试命令
sqlite3 smzdm.db  "select * from smzdm";

参考信息
http://zaf.github.io/asterisk-googletts/
http://www.voip-info.org/wiki/view/Asterisk+auto-dial+out
http://www.voip-info.org/wiki/view/Asterisk+AGI
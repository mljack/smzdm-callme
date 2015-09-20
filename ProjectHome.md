The script will make a outbound call to alert promotional products, great deal and even price bug posted on smzdm.com

脚本根据关键词来监控什么值得买smzdm.com网站上发布的各种低价，神价格，手慢无商品信息，通过生成Asterisk的callfile来呼叫使用者，呼叫接听后，脚本调用Google Translate的TTS为使用者读出特价商品信息的标题。

需求
  * Asterisk
  * Bash
  * SQLite
  * [asterisk-googletts](http://zaf.github.io/asterisk-googletts/)
  * [xmlstarlet](http://xmlstar.sourceforge.net/download.php)

脚本功能说明
  * smzdm-datasource.sh 抓取smzdm.com发布的RSS，匹配中关键词的条目加入SQLite数据库
  * check\_db.sh 定时检查数据库，发现有未通知的项目后调用callfile-generator.sh呼叫用户
  * callfile-generator.sh  生成Asterisk的callfile用于PBX系统拨叫用户

/etc/crontab添加
```
#smzdm-callme
*/1  * * * * root /root/smzdm-callme/smzdm-datasource.sh
*/1  * * * * root /root/smzdm-callme/check_db.sh
```

/etc/rc.local添加
```
# Monitor new callfile in /tmp, 
# if there is any, move it to Asterisk outgoing folder, so a call will be initialized
# So this script will run after bootup
nohup /root/mv_call_file_to_asterisk_outgoing_folder.sh 0<&- &>/dev/null &
```
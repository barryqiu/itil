#!/bin/bash
# 昨天
date=$(date -d "yesterday" +%Y%m%d)
# 一周前
weekbefore=$(date -d '7 day ago' +%Y%m%d)
# 需要分割的日志文件名绝对路径，可以配置多个
targets="/opt/cloud_phone_bi/log/gunicorn.log /root/gohome/src/forward_server/log/info.log /usr/local/hysrv/nginx/logs/access.log /usr/local/hysrv/nginx/logs/error.log"
for target in ${targets}
do
        file=`basename ${target}`
        basedir=`dirname ${target}`
        cd ${basedir}
        echo ${basedir}/${file}
        cat ${file} >> ${file}.${date}
        cat /dev/null > ${file}
        rm -f ${file}.${weekbefore}
done

# crontab 配置
# 0 0 * * * /bin/sh /usr/local/hysrv/shell/cut_log.sh
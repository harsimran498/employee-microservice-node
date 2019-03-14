netstat -ltnp | grep -w ':8002' | awk -F "LISTEN" '{print $2}'|  awk -F "/" '{print $1}' |  xargs kill -9

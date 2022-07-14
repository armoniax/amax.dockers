sudo tcpdump -i eth0 -s 0 -A -vv 'tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x504f5354' -w /tmp/tcp.cap -s 512 2>&1 \
 & sleep 10 && sudo kill `ps aux | grep tcpdump | grep -v grep | awk '{print $2}'`

strings /tmp/tcp.cap | grep -E "GET /|POST /|Host:" | grep "POST" |wc -l

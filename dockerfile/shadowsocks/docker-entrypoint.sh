#! /bin/bash
ssserver -c /etc/shadowsocks.json -d start && tail -f /dev/null

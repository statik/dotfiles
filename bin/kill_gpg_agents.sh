#!/bin/sh
echo "kill gpg-agent"
code=0
while [ 1 -ne $code ]; do
    killall gpg-agent
    code=$?
    sleep 1
done
echo "kill ssh"
killall ssh
echo "kill ssh muxers"
for pid in `ps -ef | grep ssh | grep -v grep | awk '{print $2}'`; do
    kill $pid
done

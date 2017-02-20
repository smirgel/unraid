#!/bin/bash

#curl -v https://httpbin.org/get

for var in FTP_HOST FTP_USER FTP_PASSWORD; do
  if [ -z "${!var}" ] ; then
    echo "$var must be set"
    exit 1
  fi
done

prev_ext_ip=""
while true; do
  ext_ip=$(curl -fsS https://httpbin.org/get | jq -r .origin)
  if [[ $ext_ip != $prev_ext_ip ]]; then
    echo "IP changed: $ext_ip"
    echo "Create html file"
    env EXTERNAL_IP=$ext_ip envsubst < testing.html.in > testing.html
    echo "Upload html file"
    ncftpput -v -u $FTP_USER -p $FTP_PASSWORD $FTP_HOST public_html/ testing.html
    echo "done"
  fi
  sleep 60
done
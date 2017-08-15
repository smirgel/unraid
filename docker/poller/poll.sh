#!/bin/bash

set -o pipefail

cd $(dirname $0)

#curl -v https://httpbin.org/get

for var in FTP_HOST FTP_USER FTP_PASSWORD; do
  if [ -z "${!var}" ] ; then
    echo "$var must be set"
    exit 1
  fi
done

prev_ext_ip=""
while true; do
  ext_ip=$(curl -fsS https://httpbin.org/get | jq -re .origin)
  RC=$?
  #echo $RC
  if [[ $RC -eq 0 ]]; then
    if [[ $ext_ip != $prev_ext_ip ]]; then
      echo "IP changed: $ext_ip"
      echo "Create html file"
      env EXTERNAL_IP=$ext_ip envsubst < testing.html.in > testing.html
      env EXTERNAL_IP=$ext_ip envsubst < ip.html.in > ip.html
      echo "Upload html file"
      ncftpput -v -u $FTP_USER -p $FTP_PASSWORD $FTP_HOST public_html/ testing.html ip.html
      echo "done"
      prev_ext_ip=$ext_ip
    fi
  else
    echo "$(date): curl failed"
  fi
  sleep 60
done

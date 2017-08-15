#!/bin/bash

cd "$(dirname "$0")" || exit 1

for var in FTP_HOST FTP_USER FTP_PASSWORD; do
  if [ -z "${!var}" ] ; then
    echo "$var must be set"
    exit 1
  fi
done

(

set -o pipefail

prev_ext_ip=""
while true; do
  ext_ip=$(curl -fsS https://httpbin.org/get | jq -re .origin)
  RC=$?
  if [[ $RC -eq 0 ]]; then
    if [[ ${ext_ip} != "${prev_ext_ip}" ]]; then
      echo "IP changed: ${ext_ip}"

      echo ''
      echo 'Getting ips.txt'
      ncftpget -V -u "${FTP_USER}" -p "${FTP_PASSWORD}" "${FTP_HOST}" . public_html/ips.txt
      echo "$(date): ${ext_ip}" >> ips.txt
      tail -5 ips.txt

      echo ''
      echo 'Create html file(s)'
      env EXTERNAL_IP="${ext_ip}" envsubst < testing.html.in > testing.html
      env EXTERNAL_IP="${ext_ip}" envsubst < ip.html.in > ip.html

      echo ''
      echo 'Upload files'
      ncftpput -V -u "${FTP_USER}" -p "${FTP_PASSWORD}" "${FTP_HOST}" public_html/ testing.html ip.html ips.txt

      echo ''
      echo 'Done'
      prev_ext_ip=${ext_ip}
    fi
  else
    echo "$(date): curl failed"
  fi
  sleep 300
done

) 2>&1 | ts '[%Y-%m-%d %H:%M:%S]'

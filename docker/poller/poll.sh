#!/bin/bash

#curl -v https://httpbin.org/get

prev_ext_ip=""
while true; do
  ext_ip=$(curl -fsS https://httpbin.org/get | jq -r .origin)
  if [[ $ext_ip != $prev_ext_ip ]]; then
    echo "$ext_ip"
  fi
  sleep 60
done

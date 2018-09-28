#!/bin/bash
for i in $(seq 1 10); do
  h2load https://server.chaspy.me -n 10000 -c 100 -p h2c | grep finished | awk '{print $4}'
  sleep 10
done

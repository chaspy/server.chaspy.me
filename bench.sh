#!/bin/bash
mkdir -p http/1.1
for prot in h2c http/1.1; do
  for num in 1000 10000 100000 1000000; do
    h2load https://server.chaspy.me -n $num -c 10 -p "$prot" > $prot-$num.log
    sleep 10
  done
done

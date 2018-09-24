#!/bin/bash
mkdir -p http/1.1
for prot in h2c http/1.1; do
  h2load https://server.chaspy.me -n 1000 -c 10 -p "$prot" > $prot.log
done

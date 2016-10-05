#!/bin/bash
# sample usage: host-discovery.sh 192.168.1.0/24

nmap $1 -n -sP | grep report | awk '{print $5}'

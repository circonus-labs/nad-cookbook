#!/usr/bin/bash

PATH="/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin";

ID=`zoneadm list -p | awk -F: '{ print $1 }'`
UUID=`zonename`

kstat -p memory_cap > /tmp/MEM_INFO

MEM_CAP=`cat /tmp/MEM_INFO | grep "physcap" | awk '{print $2}'`
MEM_USED=`cat /tmp/MEM_INFO | grep "rss" | awk '{print $2}'`
MEM_FREE=`echo "${MEM_CAP}-${MEM_USED}" | bc`

SWAP_CAP=`cat /tmp/MEM_INFO | grep "swap" | tail -1 | awk '{print $2}'`
SWAP_USED=`cat /tmp/MEM_INFO | grep "swap" | head -1 | awk '{print $2}'`

PREFIX="unix:0:memory:"

echo -e "${PREFIX}mem_cap\tn\t${MEM_CAP}"
echo -e "${PREFIX}mem_free\tn\t${MEM_FREE}"
echo -e "${PREFIX}mem_used\tn\t${MEM_USED}"
echo -e "${PREFIX}swap_cap\tn\t${SWAP_CAP}"
echo -e "${PREFIX}swap_used\tn\t${SWAP_USED}"

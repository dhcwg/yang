#!/bin/sh

TESTMOD=ietf-dhcpv6-client.yang
TESTDIR=~/Documents/yang/tests
MODDIR=~/Documents/yang
RFCMODDIR=../../ietf/yang/standard/ietf/RFC/

for f in ./client-duid*  
do 
  printf "\n"
  echo ${f}
  yanglint -p $RFCMODDIR -p .. -t config -f xml $RFCMODDIR/iana-if-type.yang $MODDIR/$TESTMOD $TESTDIR/${f}
done;

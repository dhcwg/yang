#!/bin/sh

TESTMOD=ietf-dhcpv6-relay.yang
TESTDIR=~/Documents/yang/tests
MODDIR=~/Documents/yang
RFCMODDIR=../ietf/yang/standard/ietf/RFC/

yanglint -p $RFCMODDIR -p .. -t config -f xml $MODDIR/$TESTMOD relay.xml


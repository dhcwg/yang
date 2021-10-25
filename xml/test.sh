#!/bin/bash

IETFYANG=../../ietf/yang/standard/ietf/RFC

#Create an empty XML
#pyang -f sample-xml-skeleton --sample-xml-skeleton-default -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-client.yang

yanglint --strict --verbose -t config -p $IETFYANG ../ietf-dhcpv6-server.yang ../example-dhcpv6-opt-sip-serv.yang server.xml
yanglint --strict --verbose -t config -p $IETFYANG ../ietf-dhcpv6-relay.yang relay.xml
yanglint --strict --verbose -t config -p $IETFYANG ../ietf-dhcpv6-client.yang client.xml
yanglint --strict --verbose -t config -p $IETFYANG ../ietf-dhcpv6-server.yang server-base-ex.xml
yanglint --strict --verbose -t config -p $IETFYANG ../ietf-dhcpv6-relay.yang relay.xml


# Test client
yanglint --strict --verbose -t config -p $IETFYANG ../../ietf/yang/standard/ietf/RFC/iana-if-type.yang ../../ietf/yang/standard/ietf/RFC/ietf-interfaces.yang ../ietf-dhcpv6-client.yang client-base-ex.xml

# Testing Relay XML
yanglint --strict --verbose -t config -p $IETFYANG ../../ietf/yang/standard/ietf/RFC/iana-if-type.yang ../../ietf/yang/standard/ietf/RFC/ietf-interfaces.yang ../ietf-dhcpv6-relay.yang relay.xml

# Testing Server XML
yanglint --strict --verbose -t config -p $IETFYANG ../../ietf/yang/standard/ietf/RFC/iana-if-type.yang ../../ietf/yang/standard/ietf/RFC/ietf-interfaces.yang ../example-dhcpv6-opt-sip-serv.yang ../ietf-dhcpv6-server.yang server.xml

# These ones work. Filenames need .xml adding, then removing:
yanglint --strict --verbose -t config -p $IETFYANG ../ietf-dhcpv6-server.yang ../example-dhcpv6-opt-sip-serv.yang server-base-ex.xml
yanglint --strict --verbose -t config -p $IETFYANG $IETFYANG/iana-if-type.yang $IETFYANG/ietf-interfaces.yang ../ietf-dhcpv6-relay.yang relay-base-ex.xml
yanglint --strict --verbose -t config -p $IETFYANG $IETFYANG/iana-if-type.yang $IETFYANG/ietf-interfaces.yang ../ietf-dhcpv6-client.yang client-base-ex.xml




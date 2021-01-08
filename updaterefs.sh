#!/bin/bash
#Script to update the revision section of all of the listed YANG modules with contents of a file. Run with no switches to see the outcome. Run with '-i' to write the changes to the files.

modulelist="ietf-dhcpv6-common.yang ietf-dhcpv6-server.yang ietf-dhcpv6-relay.yang ietf-dhcpv6-client.yang ietf-dhcpv6-options-rfc8415-server.yang ietf-dhcpv6-options-rfc8415-relay.yang ietf-dhcpv6-options-rfc8415-client.yang ietf-example-dhcpv6-options-rfc3319-server.yang ietf-example-dhcpv6-class-selector.yang ietf-example-dhcpv6-server-config.yang"

if [[ $# -gt 0 ]]
then
  if [[ $1 = "-i" ]]
  then
    for f in ${modulelist}; do sed -i '/full legal notices/r revision-2021-01-06.txt' ${f}; done;
  fi
else
  for f in ${modulelist}; do sed '/full legal notices/r revision-2021-01-06.txt' ${f}; done;
fi



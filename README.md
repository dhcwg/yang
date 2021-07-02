# draft-ietf-dhcpv6-yang
Repo for IETF DHCPV6 YANG draft authors

For development of the DHCPv6 client/server and relay YANG models and authoring of the corresponding I-D.

Create example XML config for testing:
pyang -f sample-xml-skeleton --sample-xml-skeleton-default -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-client.yang

yanglint --strict --verbose -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-server.yang server.xml
$?
yanglint --strict --verbose -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-relay.yang relay.xml
yanglint --strict --verbose -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-client.yang client.xml

yanglint --strict --verbose -t config -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-server.yang server-base-ex.xml

Test modules:

pyang --ietf --lint -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-client.yang
pyang --ietf --lint -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-server.yang
pyang --ietf --lint -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-common.yang
pyang --ietf --lint -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-relay.yang


pyang --ietf --lint -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC example-dhcpv6-server-conf.yang
pyang --ietf --lint -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC example-dhcpv6-opt-sip-serv.yang
pyang --ietf --lint -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC example-dhcpv6-class-select.yang


yanglint --verbose -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-server.yang
yanglint --verbose -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-common.yang
yanglint --verbose -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-relay.yang
yanglint --verbose -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-client.yang
yanglint --verbose -p ../ietf/yang/standard/ietf/RFC example-dhcpv6-server-conf.yang
yanglint --verbose -p ../ietf/yang/standard/ietf/RFC example-dhcpv6-opt-sip-serv.yang
yanglint --verbose -p ../ietf/yang/standard/ietf/RFC example-dhcpv6-class-select.yang




# draft-ietf-dhcpv6-yang
Repo for IETF DHCPV6 YANG draft authors

For development of the DHCPv6 client/server and relay YANG models and authoring of the corresponding I-D.

Create example XML config for testing:
pyang -f sample-xml-skeleton --sample-xml-skeleton-default -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-client.yang

Test modules:

pyang --ietf -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-client.yang
pyang --ietf -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-server.yang
pyang --ietf -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-common.yang
pyang --ietf -f tree --tree-line-length 65 -p ../ietf/yang/standard/ietf/RFC ietf-dhcpv6-relay.yang

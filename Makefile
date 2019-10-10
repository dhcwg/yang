YANGER?=../yanger/bin/yanger
XML2RFC?=../venv/bin/xml2rfc


all: text html

define file_to_tree =
$(1).tree: $(1)
	$(YANGER) -t expand -f tree -p server $$< server/ietf-dhcpv6-options-rfc8415.yang server/ietf-dhcpv6-options-rfc3319.yang -o $$@
endef


MODULES=
MODULES+=ietf-dhcpv6-server.yang
MODULES+=ietf-dhcpv6-client.yang
MODULES+=ietf-dhcpv6-relay.yang
$(foreach mod_file,$(MODULES),$(eval $(call file_to_tree,server/$(mod_file))))


define file_to_xml =
$(1).xml: $(1)
	echo '<?xml version="1.0" encoding="UTF-8"?>' > $$@
	echo '<artwork align="center">' >> $$@
	echo '<![CDATA[' >> $$@
	cat $$< >> $$@
	echo ']]>' >> $$@
	echo '</artwork>' >> $$@
FULL_INCLUDES+=$(1).xml
endef

INCLUDES=
INCLUDES+=ietf-dhcpv6-client.yang
INCLUDES+=ietf-dhcpv6-server.yang
INCLUDES+=ietf-dhcpv6-relay.yang
INCLUDES+=ietf-dhcpv6-options-rfc8415.yang
INCLUDES+=ietf-dhcpv6-common.yang
INCLUDES+=ietf-dhcpv6-server.yang.tree
INCLUDES+=ietf-dhcpv6-relay.yang.tree
INCLUDES+=ietf-dhcpv6-client.yang.tree

FULL_INCLUDES=
$(foreach inc_file,$(INCLUDES),$(eval $(call file_to_xml,server/$(inc_file))))


text: draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-19-9-19.v2v3.txt
draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-19-9-19.v2v3.txt: draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-19-9-19.v2v3.xml $(FULL_INCLUDES)
	$(XML2RFC) -n -N --text --v3 $<

html: draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-19-9-19.v2v3.html
draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-19-9-19.v2v3.html: draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-19-9-19.v2v3.xml $(FULL_INCLUDES)
	$(XML2RFC) -n -N --html --v3 $<

clean:
	rm -f $(FULL_INCLUDES) draft-ietf-dhc-dhcpv6-yang-10-wip/*html draft-ietf-dhc-dhcpv6-yang-10-wip/*txt server/*tree

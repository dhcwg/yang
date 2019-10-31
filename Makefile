YANGER?=../yanger/bin/yanger
PYANG=../venv/bin/pyang
XML2RFC?=../venv/bin/xml2rfc

#SPEC_NAME?=draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-19-9-19.v2v3
#SPEC_NAME?=draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-8-10-19
SPEC_NAME?=draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-24-10-19

MODELS_DIR:=draft-ietf-dhc-dhcpv6-yang-10-wip


all: text html

define file_to_tree =
$(1).tree: $(1)
#	$(YANGER) -t expand -f tree -p $(MODELS_DIR) $$< $(MODELS_DIR)/ietf-dhcpv6-options-rfc8415.yang $(MODELS_DIR)/ietf-dhcpv6-options-rfc3319.yang |fold -w 69 > $$@
	$(PYANG) -f tree --tree-line-length 69 -p $(MODELS_DIR) $$< $(MODELS_DIR)/ietf-dhcpv6-options-rfc8415.yang $(MODELS_DIR)/ietf-dhcpv6-options-rfc3319.yang > $$@
endef


MODULES=
MODULES+=ietf-dhcpv6-server.yang
MODULES+=ietf-dhcpv6-client.yang
MODULES+=ietf-dhcpv6-relay.yang
$(foreach mod_file,$(MODULES),$(eval $(call file_to_tree,$(MODELS_DIR)/$(mod_file))))


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
INCLUDES+=example-dhcpv6-class-selector.yang
INCLUDES+=example-dhcpv6-server-config.yang
INCLUDES+=ietf-dhcpv6-server.yang.tree
INCLUDES+=ietf-dhcpv6-relay.yang.tree
INCLUDES+=ietf-dhcpv6-client.yang.tree

FULL_INCLUDES=
$(foreach inc_file,$(INCLUDES),$(eval $(call file_to_xml,$(MODELS_DIR)/$(inc_file))))


text: $(SPEC_NAME).txt
$(SPEC_NAME).txt: $(SPEC_NAME).xml $(FULL_INCLUDES)
	$(XML2RFC) -n -N --text --v3 $<

html: $(SPEC_NAME).html
$(SPEC_NAME).html: $(SPEC_NAME).xml $(FULL_INCLUDES)
	$(XML2RFC) -n -N --html --v3 $<

clean:
	rm -f $(FULL_INCLUDES) draft-ietf-dhc-dhcpv6-yang-10-wip/*html draft-ietf-dhc-dhcpv6-yang-10-wip/*txt $(MODELS_DIR)/*tree

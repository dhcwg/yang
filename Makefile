YANGER?=../yanger/bin/yanger
PYANG=../venv/bin/pyang
XML2RFC?=../venv/bin/xml2rfc
RFCFOLD?=../venv/bin/rfcfold
SED=/bin/sed
INCLUDE_PATH:=../ietf/yang/standard/ietf/RFC

#SPEC_NAME?=draft-ietf-dhc-dhcpv6-yang-10-wip/draft-ietf-dhc-dhcpv6-yang-10-if-24-10-19
SPEC_NAME?=draft-ietf-dhc-dhcpv6-yang-13

MODELS_DIR:=.


all: text html

define file_to_tree =
$(1).tree: $(1)
	$(PYANG) -f tree --tree-line-length 65 -p $(INCLUDE_PATH) $$< $(MODELS_DIR)/ietf-dhcpv6-options-rfc8415-client.yang |fold -w 67 > $$@
	$(PYANG) -f tree --tree-line-length 65 -p $(INCLUDE_PATH) $$< $(MODELS_DIR)/ietf-dhcpv6-options-rfc8415-relay.yang |fold -w 67 > $$@
	$(PYANG) -f tree --tree-line-length 65 -p $(INCLUDE_PATH) $$< $(MODELS_DIR)/ietf-dhcpv6-options-rfc8415-server.yang |fold -w 67 > $$@
endef

MODULES=
MODULES+=ietf-dhcpv6-server.yang
MODULES+=ietf-dhcpv6-client.yang
MODULES+=ietf-dhcpv6-relay.yang
$(foreach mod_file,$(MODULES),$(eval $(call file_to_tree,$(MODELS_DIR)/$(mod_file))))


define clean_tree =
$(1).clean: $(1)
	$(SED) '/module: ietf-dhcpv6-options-rfc8415/Q' $$< > $$@
endef

CLEANMODULES=
CLEANMODULES+=ietf-dhcpv6-server.yang.tree
CLEANMODULES+=ietf-dhcpv6-client.yang.tree
CLEANMODULES+=ietf-dhcpv6-relay.yang.tree
$(foreach clean_mod_file,$(CLEANMODULES),$(eval $(call clean_tree,$(MODELS_DIR)/$(clean_mod_file))))


define tree_to_xml =
$(1).xml: $(1)
	echo '<?xml version="1.0" encoding="UTF-8"?>' > $$@
	echo '<artwork align="center">' >> $$@
	echo '<![CDATA[' >> $$@
	cat $$< |fold -w 69 >> $$@
	echo ']]>' >> $$@
	echo '</artwork>' >> $$@
TREEINCLUDES+=$(1).xml
endef

INCLUDETREE=
INCLUDETREE+=ietf-dhcpv6-server.yang.tree.clean
INCLUDETREE+=ietf-dhcpv6-relay.yang.tree.clean
INCLUDETREE+=ietf-dhcpv6-client.yang.tree.clean

TREEINCLUDES=
$(foreach inc_file,$(INCLUDETREE),$(eval $(call tree_to_xml,$(MODELS_DIR)/$(inc_file))))


define yang_to_xml =
$(1).xml: $(1)
	echo '<?xml version="1.0" encoding="UTF-8"?>' > $$@
	echo '<artwork align="center">' >> $$@
	echo '<![CDATA[<CODE BEGINS> file "$(inc_yang_file)" \n' >> $$@
	cat $$< |fold -w 69 >> $$@
	echo '<CODE ENDS>]]>' >> $$@
	echo '</artwork>' >> $$@
YANGINCLUDES+=$(1).xml
endef

INCLUDES=
INCLUDES+=ietf-dhcpv6-client.yang
INCLUDES+=ietf-dhcpv6-server.yang
INCLUDES+=ietf-dhcpv6-relay.yang
INCLUDES+=ietf-dhcpv6-options-rfc8415-client.yang
INCLUDES+=ietf-dhcpv6-options-rfc8415-relay.yang
INCLUDES+=ietf-dhcpv6-options-rfc8415-server.yang
INCLUDES+=ietf-dhcpv6-common.yang
INCLUDES+=ietf-example-dhcpv6-class-selector.yang
INCLUDES+=ietf-example-dhcpv6-server-config.yang
INCLUDES+=ietf-example-dhcpv6-options-rfc3319-server.yang

YANGINCLUDES=
$(foreach inc_yang_file,$(INCLUDES),$(eval $(call yang_to_xml,$(MODELS_DIR)/$(inc_yang_file))))


text: $(SPEC_NAME).txt
$(SPEC_NAME).txt: $(SPEC_NAME).xml $(TREEINCLUDES) $(YANGINCLUDES)
	$(XML2RFC) -n -N --text --v3 $<

html: $(SPEC_NAME).html
$(SPEC_NAME).html: $(SPEC_NAME).xml $(TREEINCLUDES) $(YANGINCLUDES)
	$(XML2RFC) -n -N --html --v3 $<

clean:
	rm -f $(TREEINCLUDES) $(YANGINCLUDES) $(MODELS_DIR)/*html $(MODELS_DIR)/*txt $(MODELS_DIR)/*tree $(MODELS_DIR)/*tree.xml $(MODELS_DIR)/*.tree.clean

#xml complete file can be created with 'xml2rfc --exp draft-ietf-dhc-dhcpv6-yang-XX.xml

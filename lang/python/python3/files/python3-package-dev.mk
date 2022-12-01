#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Package/python3-dev
$(call Package/python3/Default)
  TITLE:=Python $(PYTHON3_VERSION) development files
  DEPENDS:=+python3 +python3-lib2to3
endef

define Py3Package/python3-dev/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/python$(PYTHON3_VERSION)-config $(1)/opt/bin
	$(LN) python$(PYTHON3_VERSION)-config $(1)/opt/bin/python3-config
	$(LN) python$(PYTHON3_VERSION)-config $(1)/opt/bin/python-config
	$(LN) python$(PYTHON3_VERSION)/config-$(PYTHON3_VERSION)/libpython$(PYTHON3_VERSION).a $(1)/opt/lib/
  # This depends on being called before filespec is processed
	$(SED) 's|$(TARGET_AR)|ar|g;s|$(TARGET_CROSS)readelf|readelf|g;s|$(TARGET_CC)|gcc|g;s|$(TARGET_CXX)|g++|g' \
		$(PKG_INSTALL_DIR)/opt/lib/python$(PYTHON3_VERSION)/config-$(PYTHON3_VERSION)/Makefile
  # XXX
	$(SED) 's,$(STAGING_DIR),,g;s,$(TOOLCHAIN_DIR),/opt,g;s,$(STAGING_DIR_HOST),/opt,g; \
		s,-f\(file\|macro\)-prefix-map=$(PKG_BUILD_DIR)=Python-$(PKG_VERSION),,g; \
		s,-L$(PKG_BUILD_DIR),,g;s,$(PKG_BUILD_DIR),\.,g' \
			$(PKG_INSTALL_DIR)/opt/bin/python$(PYTHON3_VERSION)-config \
			$(PKG_INSTALL_DIR)/opt/lib/python$(PYTHON3_VERSION)/config-$(PYTHON3_VERSION)/Makefile
endef

$(eval $(call Py3BasePackage,python3-dev, \
    /opt/lib/python$(PYTHON3_VERSION)/config-$(PYTHON3_VERSION) \
    /opt/include/python$(PYTHON3_VERSION) \
    /opt/lib/pkgconfig \
	, \
	DO_NOT_ADD_TO_PACKAGE_DEPENDS \
))

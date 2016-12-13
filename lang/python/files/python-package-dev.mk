#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Package/python-dev
$(call Package/python/Default)
  TITLE:=Python $(PYTHON_VERSION) development files
  DEPENDS:=+python
endef

define PyPackage/python-dev/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/python*config $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libpython$(PYTHON_VERSION).so* $(1)/opt/lib
	$(SED) "s|-L$(STAGING_DIR)/opt/lib|-L/opt/lib|g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-L$(STAGING_DIR)/lib|-L/opt/lib/gcc/$(REAL_GNU_TARGET_NAME)/5.4.0|g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-L$(TOOLCHAIN_DIR)/usr/lib||g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-L$(TOOLCHAIN_DIR)/lib||g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-L$(PKG_BUILD_DIR)||g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-rpath-link=$(STAGING_DIR)/opt/lib|-rpath-link=/opt/lib|g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-I$(STAGING_DIR)/opt/include|-I/opt/include|g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-I$(STAGING_DIR)/include||g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-I$(TOOLCHAIN_DIR)/usr/include||g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
	$(SED) "s|-I$(TOOLCHAIN_DIR)/include||g" $(1)/opt/lib/python$(PYTHON_VERSION)/config/Makefile
endef

$(eval $(call PyBasePackage,python-dev, \
	/opt/lib/python$(PYTHON_VERSION)/config \
	/opt/include/python$(PYTHON_VERSION) \
	/opt/lib/pkgconfig \
	, \
	DO_NOT_ADD_TO_PACKAGE_DEPENDS \
))


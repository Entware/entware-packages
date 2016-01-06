#
# Copyright (C) 2006-2015 OpenWrt.org
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
endef

$(eval $(call PyBasePackage,python-dev, \
	/opt/lib/python$(PYTHON_VERSION)/config \
	/opt/include/python$(PYTHON_VERSION) \
	/opt/lib/pkgconfig \
	, \
	DO_NOT_ADD_TO_PACKAGE_DEPENDS \
))


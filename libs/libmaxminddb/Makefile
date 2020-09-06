#
# Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libmaxminddb
PKG_VERSION:=1.4.3
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/maxmind/libmaxminddb/releases/download/$(PKG_VERSION)/
PKG_HASH:=a5fdf6c7b4880fdc7620f8ace5bd5cbe9f65650c9493034b5b9fc7d83551a439

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/libmaxminddb
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=A library for working with MaxMind DB files
  URL:=https://maxmind.github.io/libmaxminddb/
endef

define Package/libmaxminddb/description
 The libmaxminddb library provides functions for working MaxMind DB files.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmaxminddb.{a,so*} $(1)/opt/lib/
endef

define Package/libmaxminddb/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/mmdblookup $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmaxminddb.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libmaxminddb))

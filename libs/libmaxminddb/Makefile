#
# Copyright (C) 2019-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libmaxminddb
PKG_VERSION:=1.5.2
PKG_RELEASE=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/maxmind/libmaxminddb/releases/download/$(PKG_VERSION)/
PKG_HASH:=5237076d250a5f7c297e331c35a433eeaaf0dc205e070e4db353c9ba10f340a2

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

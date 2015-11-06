#
# Copyright (C) 2014-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libev
PKG_VERSION:=4.20
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://dist.schmorp.de/libev/Attic/
PKG_MD5SUM:=1cac539cfc560f381a490c9fba940de9
PKG_LICENSE:=BSD-2-Clause
PKG_MAINTAINER:=Karl Palsson <karlp@tweak.net.au>

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/libev
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=High-performance event loop
  URL:=http://software.schmorp.de/pkg/libev.html
endef

define Package/libev/description
 A full-featured and high-performance event loop that is loosely modelled after
 libevent, but without its limitations and bugs.
endef

TARGET_CFLAGS += $(FPIC)

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/libev
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/libev/
	$(INSTALL_DIR) $(1)/opt/lib/libev
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libev.{a,so*} $(1)/opt/lib/libev/
endef

define Package/libev/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libev.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libev))

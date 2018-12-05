#
# Copyright (C) 2009-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=liboping
PKG_VERSION:=1.10.0
PKG_RELEASE:=1
PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>
PKG_LICENSE:=LGPL-2.1+

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://noping.cc/files
PKG_HASH:=eb38aa93f93e8ab282d97e2582fbaea88b3f889a08cbc9dbf20059c3779d5cd8

PKG_FIXUP:=autoreconf

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/liboping/Default
  URL:=https://noping.cc
endef

define Package/liboping
$(call Package/liboping/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=C library to generate ICMP echo requests.
endef

define Package/oping
$(call Package/liboping/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Send ICMP echo request to network hosts
  DEPENDS+= +liboping
endef

define Package/noping
$(call Package/liboping/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Ncurses application to send ICMP echo request to network hosts
  DEPENDS+= +liboping +libncurses
endef

TARGET_CFLAGS += $(FPIC)

CONFIGURE_ARGS += \
	--without-perl-bindings \
	--enable-shared \
	--enable-static

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/oping.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/liboping.{a,so*} $(1)/opt/lib/
endef

define Package/liboping/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/liboping.so.* $(1)/opt/lib/
endef

define Package/oping/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/oping $(1)/opt/bin/
endef

define Package/noping/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/noping $(1)/opt/bin/
endef

$(eval $(call BuildPackage,liboping))
$(eval $(call BuildPackage,oping))
$(eval $(call BuildPackage,noping))

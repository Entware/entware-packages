#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Upgraded from 1.0.33

include $(TOPDIR)/rules.mk

PKG_NAME:=tinc
PKG_VERSION:=1.1pre17
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.tinc-vpn.org/packages
PKG_HASH:=61b9c9f9f396768551f39216edcc41918c65909ffd9af071feb3b5f9f9ac1c27

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tinc
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+liblzo +libopenssl +librt
  TITLE:=VPN tunneling daemon
  URL:=http://www.tinc-vpn.org/
  MAINTAINER:=Saverio Proto <zioproto@gmail.com>
  SUBMENU:=VPN
endef

define Package/tinc/description
  tinc is a Virtual Private Network (VPN) daemon that uses tunnelling and
  encryption to create a secure private network between hosts on the Internet.
endef

TARGET_CFLAGS += -std=gnu99

CONFIGURE_ARGS += \
	--disable-curses \
	--disable-readline \
	--with-zlib="$(STAGING_DIR)/opt" \
	--with-lzo-include="$(STAGING_DIR)/opt/include/lzo"

define Package/tinc/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/* $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,tinc))

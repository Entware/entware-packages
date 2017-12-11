#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Upgraded from 1.0.33

include $(TOPDIR)/rules.mk

PKG_NAME:=tinc
PKG_VERSION:=1.1pre14
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.tinc-vpn.org/packages
PKG_MD5SUM:=401ad9b0610dc4da233d6edb1f463cb8

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

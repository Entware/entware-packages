#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: downgraded from 3.5.1. The newer versions fail to build on intel

include $(TOPDIR)/rules.mk

PKG_NAME:=ser2net
PKG_VERSION:=2.10.0
PKG_RELEASE:=2a

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/ser2net
PKG_HASH:=98f6193225338e25f35302fef5e1f16688693ed43e7b3c3e9e09187eb54547ac

PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Nicolas Thill <nico@openwrt.org>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ser2net
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Serial to Network Proxy
  URL:=https://sourceforge.net/projects/ser2net/
endef

define Package/ser2net/description
  This project provides a proxy that allows telnet/tcp connections to be made to
  serial ports on a machine.
endef

define Package/ser2net/conffiles
/opt/etc/ser2net.conf
endef


# GCC can't find includes from toolchain folder when STAGING_DIR is set.

define Build/Compile
	$(SED) 's,^COMPILE = ,COMPILE = STAGING_DIR="" ,g' $(PKG_BUILD_DIR)/Makefile
	$(call Build/Compile/Default)
endef


define Package/ser2net/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/ser2net $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/ser2net.conf $(1)/opt/etc/
endef

$(eval $(call BuildPackage,ser2net))

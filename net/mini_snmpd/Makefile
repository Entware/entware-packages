#
# Copyright (C) 2009-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mini_snmpd
PKG_VERSION:=1.6
PKG_RELEASE:=3
PKG_MAINTAINER:=Marcin Jurkowski <marcin1j@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=mini-snmpd-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/troglobit/mini-snmpd/tar.gz/v$(PKG_VERSION)?
PKG_BUILD_DIR:=$(BUILD_DIR)/mini-snmpd-$(PKG_VERSION)
PKG_HASH:=de00c475a3c70c56f3ee97cd683cb71009d3521d60b1f589c5a91b4671ede9f3

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
# As warned by upstream maintainer and binutils
# however compiler warnings can be ignored until next binutils release
# https://github.com/wongsyrone/openwrt-1/issues/67
# PKG_SSP:=0
# PKG_RELRO:=0

include $(INCLUDE_DIR)/package.mk

define Package/mini_snmpd
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A tiny SNMP server for embedded systems
  URL:=http://troglobit.github.io/mini-snmpd.html
# uncomment if you just want the binary, not the init script
# openwrt requires init script runtime dependencies be defined for make menuconfig
# (e.g busybox sysntpd)
#  DEPENDS:=+jsonfilter +ubus +procd +ubox
  DEPENDS:=+confuse
endef

CONFIGURE_ARGS+= \
	$(if $(CONFIG_IPV6),,--disable-ipv6) \
	--with-config

# Configure weirdness - Disabled by default, explicitately disabling turns feature on!
#     --disable-debug \
#	--disable-demo - Upstream Github Issue #4 Fixed 20160707

define Package/mini_snmpd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/mini-snmpd $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/mini-snmpd.conf $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S50mini_snmpd $(1)/opt/etc/init.d/
endef

define Package/mini_snmpd/conffiles
/opt/etc/mini-snmpd.conf
endef

$(eval $(call BuildPackage,mini_snmpd))

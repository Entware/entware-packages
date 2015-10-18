#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=vnstat
PKG_VERSION:=1.12
PKG_RELEASE:=1c

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://humdi.net/vnstat
PKG_MD5SUM:=a154b2196771e06a8accd1c24374009c
PKG_MAINTAINER:=Jo-Philipp Wich <jow@openwrt.org>

PKG_INSTALL:=1

PKG_BUILD_DEPENDS:=libgd
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vnstat/Default
  SECTION:=net
  CATEGORY:=Network
  URL:=http://humdi.net/vnstat/
endef

define Package/vnstat
$(call Package/vnstat/Default)
  TITLE:=Console-based network traffic monitor
endef

define Package/vnstat/description
	vnStat is a network traffic monitor for Linux that keeps a log of daily
	network traffic for the selected interface(s). vnStat isn't a packet
	sniffer. The traffic information is analyzed from the /proc -filesystem,
	so vnStat can be used without root permissions.
endef

define Package/vnstati
$(call Package/vnstat/Default)
  DEPENDS+=vnstat +libgd
  TITLE:=PNG image output support for vnStat
endef

define Package/vnstati/description
	The purpose of vnstati is to provide image output support for statistics
	collected using vnstat(1). However, the image file format is limited to
	png. All basic outputs of vnStat are supported excluding live traffic
	features. The image can be outputted either to a file or to standard
	output.
endef

define Package/vnstat/conffiles
/opt/etc/vnstat.conf
endef

define Build/Compile/vnstat
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef

define Build/Compile/vnstati
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/opt/include" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		all
endef

define Build/Compile
$(call Build/Compile/vnstat)
$(call Build/Compile/vnstati)
endef

define Package/vnstat/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/vnstat $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/vnstatd $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/var/lib/vnstat
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) ./files/vnstat.conf $(1)/opt/etc/
	$(INSTALL_BIN) ./files/S32vnstat $(1)/opt/etc/init.d
endef

define Package/vnstati/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/vnstati $(1)/opt/bin/
endef

$(eval $(call BuildPackage,vnstat))
$(eval $(call BuildPackage,vnstati))

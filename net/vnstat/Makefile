#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=vnstat
PKG_VERSION:=1.18
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://humdi.net/vnstat
PKG_HASH:=d7193592b9e7445fa5cbe8af7d3b39982f165ee8fc58041ff41f509b37c687d5
PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>

PKG_FIXUP:=autoreconf
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

CONFIGURE_VARS += \
	ac_cv_lib_gd_gdImagePng=yes

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
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/vnstat $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/vnstatd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/var/lib/vnstat $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/vnstat.conf $(1)/opt/etc/
	$(INSTALL_BIN) ./files/S32vnstat $(1)/opt/etc/init.d
endef

define Package/vnstati/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/vnstati $(1)/opt/bin/
endef

$(eval $(call BuildPackage,vnstat))
$(eval $(call BuildPackage,vnstati))

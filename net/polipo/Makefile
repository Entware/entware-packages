#
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=polipo
PKG_VERSION:=1.1.1
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.pps.jussieu.fr/~jch/software/files/$(PKG_NAME)/
PKG_HASH:=a259750793ab79c491d05fcee5a917faf7d9030fb5d15e05b3704e9c9e4ee015

PKG_CPE_ID:=cpe:/a:pps.jussieu:polipo

include $(INCLUDE_DIR)/package.mk

define Package/polipo
  SUBMENU:=Web Servers/Proxies
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A caching web proxy
  URL:=http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/
  MAINTAINER:=Gabriel Kerneis <gabriel@kerneis.info>
endef

define Package/polipo/description
 Polipo is a small and fast caching web proxy (a web cache, an HTTP proxy,
 a proxy server). While Polipo was designed to be used by one person or a
 small group of people, there is nothing that prevents it from being used
 by a larger group.
endef

TARGET_CFLAGS += -DHAVE_IPv6

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		LOCAL_ROOT="/opt/share/polipo/www" \
		DISK_CACHE_ROOT="/opt/var/cache/polipo" \
		polipo
endef

define Package/polipo/conffiles
/opt/etc/polipo/config
endef

define Package/polipo/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/polipo $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/polipo
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/config.sample $(1)/opt/etc/polipo/config
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S28polipo $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/share/polipo/www $(1)/opt/var/cache/polipo
endef

$(eval $(call BuildPackage,polipo))

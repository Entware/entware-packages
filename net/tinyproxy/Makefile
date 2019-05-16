#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tinyproxy
PKG_VERSION:=1.8.3
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.banu.com/pub/tinyproxy/1.8/
PKG_HASH:=be559b54eb4772a703ad35239d1cb59d32f7cf8a739966742622d57df88b896e
PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tinyproxy
  SUBMENU:=Web Servers/Proxies
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Tinyproxy is a lightweight HTTP and HTTPS proxy
  URL:=http://tinyproxy.sourceforge.net/
endef

define Package/tinyproxy/conffiles
/opt/etc/tinyproxy.conf
endef

CONFIGURE_ARGS+= \
	--enable-filter \
	--enable-transparent \
	--disable-regexcheck \

# Entware specific:
MAKE_FLAGS += \
	LIBS="-lresolv -lnsl $(TARGET_LDFLAGS)" \

define Package/tinyproxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/tinyproxy $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/share/tinyproxy
	$(CP) $(PKG_INSTALL_DIR)/opt/share/tinyproxy/*.html $(1)/opt/share/tinyproxy/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/tinyproxy.conf $(1)/opt/etc/
	$(INSTALL_BIN) ./files/S21tinyproxy $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,tinyproxy))

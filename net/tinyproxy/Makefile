#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tinyproxy
PKG_VERSION:=1.10.0
PKG_RELEASE:=2a

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/tinyproxy/tinyproxy/releases/download/$(PKG_VERSION)
PKG_HASH:=59be87689c415ba0d9c9bc6babbdd3df3b372d60b21e526b118d722dbc995682

PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:banu:tinyproxy

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tinyproxy
  SUBMENU:=Web Servers/Proxies
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Tinyproxy is a lightweight HTTP and HTTPS proxy
  URL:=https://tinyproxy.github.io/
endef

define Package/tinyproxy/conffiles
/opt/etc/tinyproxy.conf
endef

CONFIGURE_VARS += ac_cv_path_A2X=no

# Entware specific:
MAKE_FLAGS += \
	LIBS="$(TARGET_LDFLAGS) -lresolv $(if $(CONFIG_GLIBC_USE_VERSION_2_33),,-lnsl)"

define Package/tinyproxy/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/tinyproxy $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/tinyproxy
	$(CP) $(PKG_INSTALL_DIR)/opt/share/tinyproxy/*.html $(1)/opt/share/tinyproxy/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/tinyproxy/tinyproxy.conf $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S21tinyproxy $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,tinyproxy))

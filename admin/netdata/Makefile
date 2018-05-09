#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=netdata
PKG_VERSION:=1.10.0
PKG_RELEASE:=1
PKG_MAINTAINER:=
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/firehol/netdata/releases/download/v$(PKG_VERSION)
PKG_HASH:=0514fc002c5c5fb730156b3fe928965b22327833c6c17e22b7097eda657e77a2

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/netdata
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+zlib +libuuid +libmnl
  TITLE:=Real-time performance monitoring tool
  URL:=https://my-netdata.io/
endef

define Package/netdata/description
  netdata is a highly optimized Linux daemon providing real-time performance
  monitoring for Linux systems, applications and SNMP devices over the web.
endef

TARGET_CFLAGS := $(filter-out -O%,$(TARGET_CFLAGS))
TARGET_CFLAGS += -ffunction-sections -fdata-sections -O3
TARGET_LDFLAGS += -Wl,--gc-sections

CONFIGURE_ARGS += --with-zlib --with-math --disable-x86-sse --disable-lto

define Package/netdata/conffiles
/opt/etc/netdata/netdata.conf
endef

define Package/netdata/install
	mkdir -p $(1)/opt/etc/netdata
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/netdata $(1)/opt/etc
	$(CP) ./files/netdata.conf $(1)/opt/etc/netdata
	mkdir -p $(1)/opt/share/netdata
	$(CP) $(PKG_INSTALL_DIR)/opt/share/netdata $(1)/opt/share
	rm -rf $(1)/opt/share/netdata/web/images
	rm -rf $(1)/opt/share/netdata/web/old
	rm $(1)/opt/share/netdata/web/demo*html
	rm $(1)/opt/share/netdata/web/fonts/*.svg
	rm $(1)/opt/share/netdata/web/fonts/*.ttf
	rm $(1)/opt/share/netdata/web/fonts/*.woff
	mkdir -p $(1)/opt/lib/netdata
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/netdata $(1)/opt/lib
	rm $(1)/opt/lib/netdata/python.d/python-modules-installer.sh
	chmod 4755 $(1)/opt/lib/netdata/plugins.d/apps.plugin
	mkdir -p $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S60netdata $(1)/opt/etc/init.d
	mkdir -p $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/netdata $(1)/opt/sbin
endef

$(eval $(call BuildPackage,netdata))

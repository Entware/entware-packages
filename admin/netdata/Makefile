#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=netdata
PKG_VERSION:=1.33.1
PKG_RELEASE:=1a

PKG_MAINTAINER:=Josef Schlehofer <pepe.schlehofer@gmail.com>, Daniel Engberg <daniel.engberg.lists@pyret.net>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:my-netdata:netdata

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/netdata/netdata/releases/download/v$(PKG_VERSION)
PKG_HASH:=20ba8695d87187787b27128ac3aab9b09aa29ca6b508c48542e0f7d50ec9322b
PKG_BUILD_DIR=$(BUILD_DIR)/$(PKG_NAME)-v$(PKG_VERSION)

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/netdata
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+zlib +libuuid +libuv +libmnl +libjson-c
  TITLE:=Real-time performance monitoring tool
  URL:=https://www.netdata.cloud/
endef

define Package/netdata/description
  netdata is a highly optimized Linux daemon providing real-time performance
  monitoring for Linux systems, applications and SNMP devices over the web.

  If you want to use Python plugins install python3, python3-yaml and
  python3-urllib3
endef

TARGET_CFLAGS := $(filter-out -O%,$(TARGET_CFLAGS))
TARGET_CFLAGS += -ffunction-sections -fdata-sections -O3
TARGET_LDFLAGS += -Wl,--gc-sections

CONFIGURE_ARGS += \
	--with-zlib \
	--with-math \
	--disable-x86-sse \
	--enable-lto \
	--disable-ebpf \
	--without-libcap \
	--disable-https \
	--disable-dbengine \
	--disable-compression \
	--disable-plugin-nfacct \
	--disable-plugin-freeipmi \
	--disable-plugin-cups \
	--disable-plugin-xenstat \
	--disable-backend-prometheus-remote-write \
	--disable-unit-tests \
	--disable-ml \
	--disable-cloud

define Build/Configure
	$(SED) 's/m4_esyscmd(\[git describe .*\])/$(PKG_VERSION)/' $(PKG_BUILD_DIR)/configure.ac
	$(Build/Configure/Default)
endef

define Package/netdata/conffiles
/opt/etc/netdata/
endef

define Package/netdata/install
	$(INSTALL_DIR) $(1)/opt/etc/netdata/custom-plugins.d
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/netdata $(1)/opt/etc
	$(CP) ./files/netdata.conf $(1)/opt/etc/netdata
	touch $(1)/opt/etc/netdata/.opt-out-from-anonymous-statistics
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/netdata $(1)/opt/lib
	$(CP) $(1)/opt/lib/netdata/conf.d/fping.conf $(1)/opt/etc
	$(CP) $(1)/opt/lib/netdata/conf.d/health_alarm_notify.conf $(1)/opt/etc
	$(CP) $(1)/opt/lib/netdata/plugins.d/tc-qos-helper.sh $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/netdata $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/share/netdata
	$(CP) $(PKG_INSTALL_DIR)/opt/share/netdata $(1)/opt/share
	rm $(1)/opt/share/netdata/web/demo*html
	rm $(1)/opt/share/netdata/web/fonts/*.svg
	rm $(1)/opt/share/netdata/web/fonts/*.ttf
	rm $(1)/opt/share/netdata/web/fonts/*.woff
	rm $(1)/opt/share/netdata/web/images/*.png
	rm $(1)/opt/share/netdata/web/images/*.gif
	rm $(1)/opt/share/netdata/web/images/*.ico
	rm -rf $(1)/opt/share/netdata/web/old
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S60netdata $(1)/opt/etc/init.d
	# Entware specific: fix exec path in scripts
	$(SED) 's,^#!.*bash,#!/opt/bin/bash,' $(1)/opt/etc/tc-qos-helper.sh
	$(FIND) $(1)/opt/lib/netdata -type f | $(XARGS) $(SED) \
		's,^#!.*bash,#!/opt/bin/bash,;s,^#!.*env sh,#!/bin/sh,; \
		s,^#!.*python,#!/opt/bin/python,'
endef

$(eval $(call BuildPackage,netdata))

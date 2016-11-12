#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=netdata
PKG_VERSION:=1.4.0
PKG_RELEASE:=2
PKG_MAINTAINER:=Daniel Engberg <daniel.engberg.lists@pyret.net>
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://firehol.org/download/netdata/releases/v$(PKG_VERSION)
PKG_SOURCE_VERSION:=3028b87ee19e8550df6b9decc49733d595e0bd6e

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/netdata
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+zlib +libuuid
  TITLE:=Real-time performance monitoring tool
  URL:=http://netdata.firehol.org/
endef

define Package/netdata/description
  netdata is a highly optimized Linux daemon providing real-time performance
  monitoring for Linux systems, applications and SNMP devices over the web.
endef

define Package/netdata/conffiles
/opt/etc/netdata/netdata.conf
endef

define Package/netdata/install
	$(INSTALL_DIR) $(1)/opt/etc/netdata
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/netdata $(1)/opt/etc
	$(CP) ./files/netdata.conf $(1)/opt/etc/netdata
	$(INSTALL_DIR) $(1)/opt/share/netdata
	$(CP) $(PKG_INSTALL_DIR)/opt/share/netdata $(1)/opt/share
	rm $(1)/opt/share/netdata/web/images/animated.gif
	rm -rf $(1)/opt/share/netdata/web/old
	rm $(1)/opt/share/netdata/web/demo*html
	rm $(1)/opt/share/netdata/web/fonts/*.svg
	rm $(1)/opt/share/netdata/web/fonts/*.ttf
	rm $(1)/opt/share/netdata/web/fonts/*.woff
	rm $(1)/opt/share/netdata/web/fonts/*.otf
	$(INSTALL_DIR) $(1)/opt/lib/netdata
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/netdata $(1)/opt/lib
	rm $(1)/opt/lib/netdata/python.d/python-modules-installer.sh
	rm -rf $(1)/opt/lib/netdata/python.d/python_modules/pyyaml2
	rm -rf $(1)/opt/lib/netdata/python.d/python_modules/pyyaml3
	chmod 4755 $(1)/opt/lib/netdata/plugins.d/apps.plugin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S60netdata $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/netdata $(1)/opt/sbin
endef

$(eval $(call BuildPackage,netdata))

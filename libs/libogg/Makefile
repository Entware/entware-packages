#
# Copyright (C) 2008-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libogg
PKG_VERSION:=1.3.2
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://downloads.xiph.org/releases/ogg/
PKG_HASH:=3f687ccdd5ac8b52d76328fbbfebc70c459a40ea891dbf3dccb74a210826e79b
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libogg
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libogg
  URL:=http://xiph.org/ogg/
endef

define Package/libogg/description
Ogg project codecs use the Ogg bitstream format to arrange the raw,
compressed bitstream into a more robust, useful form.  For example,
the Ogg bitstream makes seeking, time stamping and error recovery
possible, as well as mixing several sepearate, concurrent media
streams into a single physical bitstream.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/ogg/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/ogg/* $(1)/opt/include/ogg/
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.{so*,a,la} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/* $(1)/opt/lib/pkgconfig/
	$(INSTALL_DIR) $(1)/opt/share/aclocal/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/aclocal/* $(1)/opt/share/aclocal/
endef

define Package/libogg/install
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libogg))

#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libupnpp
PKG_VERSION:=0.24.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.lesbonscomptes.com/upmpdcli/downloads
PKG_HASH:=f09d5162f237bcb971ef4bbd45de9e93a073d96555cd691374eb1a3f338b2d0b

PKG_MAINTAINER:=
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libupnpp
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://www.lesbonscomptes.com/upmpdcli
  DEPENDS+=+libnpupnp
  TITLE:=The libupnpp C++ library wraps libupnp for easier use by upmpdcli and upplay
endef

define Package/libupnpp/description
libupnpp defines useful objects over libupnp and can be used to create both devices
and control points. It is shared by upmpdcli and upplay.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libupnpp $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libupnpp.{la,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libupnpp.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libupnpp/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libupnpp.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libupnpp))

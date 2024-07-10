#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libid3tag
PKG_VERSION:=0.16.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://codeberg.org/tenacityteam/libid3tag.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_MIRROR_HASH:=b373a3015ace3e9d5db83d0987b1dad8cd02945fd223294365396ec54901b8a5

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_LICENSE:=GPL-2
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:media-libs:libid3tag

CMAKE_BINARY_SUBDIR:=openwrt-build

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libid3tag
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+zlib
  TITLE:=An ID3 tag manipulation library
  URL:=https://codeberg.org/tenacityteam/libid3tag
endef

define Package/libid3tag/description
	libid3tag is a library for reading and (eventually) writing ID3 tags, both
	ID3v1 and the various versions of ID3v2.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/id3tag.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libid3tag.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/id3tag.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libid3tag/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libid3tag.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libid3tag))

#
# Copyright (C) 2019 Valentín Kivachuk <vk18496@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=leptonica
PKG_VERSION:=1.80.0
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.leptonica.org/source/
PKG_HASH:=ec9c46c2aefbb960fb6a6b7f800fe39de48343437b6ce08e30a8d9688ed14ba4

PKG_MAINTAINER:=Valentín Kivachuk <vk18496@gmail.com>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=leptonica-license.txt

CMAKE_BINARY_SUBDIR:=openwrt-build

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libleptonica
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=A library for efficient image processing and image analysis operations
  URL:=http://www.leptonica.org/
  DEPENDS:=+giflib +libjpeg +libpng +libtiff +libwebp +zlib
endef

CMAKE_OPTIONS += \
	-DBUILD_SHARED_LIBS=ON \
	-DWEBPMUX_INCLUDE_DIR=$(STAGING_DIR)/opt/include

TARGET_CFLAGS:=$(filter-out -O%,$(TARGET_CFLAGS)) -O3

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/leptonica
	$(CP) $(PKG_INSTALL_DIR)/opt/include/leptonica/*.h $(1)/opt/include/leptonica/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libleptonica.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/cmake
	$(CP) $(PKG_INSTALL_DIR)/opt/cmake/*.cmake $(1)/opt/lib/cmake/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/lept.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libleptonica/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libleptonica.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libleptonica))

#
# Copyright (C) 2018 Yousong Zhou <yszhou4tech@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pixman
PKG_VERSION:=0.43.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.cairographics.org/releases
PKG_HASH:=a0624db90180c7ddb79fc7a9151093dc37c646d8c38d3f232f767cf64b85a226

PKG_MAINTAINER:=Yousong Zhou <yszhou4tech@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:pixman:pixman

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/meson.mk

define Package/pixman
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=a low-level software library for pixel manipulation
  URL:=https://www.pixman.org/
endef

define Package/pixman/description
  Pixman is a low-level software library for pixel manipulation, providing
  features such as image compositing and trapezoid rasterization. Important
  users of pixman are the cairo graphics library and the X server.
endef

define Package/pixman/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libpixman*.so* $(1)/opt/lib
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib
endef

$(eval $(call BuildPackage,pixman))

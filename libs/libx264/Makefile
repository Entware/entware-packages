#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=x264
PKG_VERSION:=snapshot-20160815-2245-stable
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://download.videolan.org/x264/snapshots/
PKG_MAINTAINER:=Adrian Panella <ianchi74@outlook.com>
PKG_MD5SUM:=93fa596ea1b5513fec73e9de27589dd4

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS+=-std=gnu99 -fPIC -O3 -ffast-math -I.
MAKE_FLAGS+= LD="$(TARGET_CC) -o"

ifneq ($(CONFIG_x86_64),y)
ifeq ($(CONFIG_YASM),y)
  CONFIGURE_VARS+= AS=yasm
  MAKE_FLAGS+= AS=yasm
else
  CONFIGURE_VARS+= AS= 
  MAKE_FLAGS+= AS= 
  CONFIGURE_ARGS += --disable-asm
endif
endif

ifeq ($(CONFIG_SOFT_FLOAT),y)
CONFIGURE_ARGS += --disable-asm
endif

CONFIGURE_ARGS += \
		--enable-shared \
		--enable-pic \
		--disable-cli 

define Package/libx264
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=H264/AVC free codec library.
  DEPENDS:=@BUILD_PATENTED @!TARGET_armv5_3x
  URL:=http://www.videolan.org/developers/x264.html
endef

define Package/libx264/description
  x264 is a free software library for encoding 
  video streams into the H.264/MPEG-4 AVC compression format.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/x264/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/* $(1)/opt/lib/pkgconfig/
endef

define Package/libx264/install
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libx264))

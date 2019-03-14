#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: 002-no-utility.patch removed, flac and utilities added
#

include $(TOPDIR)/rules.mk

PKG_NAME:=flac
PKG_VERSION:=1.3.2
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://downloads.xiph.org/releases/flac/
PKG_HASH:=91cfc3ed61dc40f47f050a109b08610667d73477af6ef36dcad31c31a4a8d53f
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_INSTALL:=1

PKG_LICENSE:=GFDL-1.2 GPL-2 LGPL-2.1 BSD-3-Clause
PKG_LICENSE_FILES:=README COPYING.FDL COPYING.GPL COPYING.LGPL COPYING.Xiph
PKG_CPE_ID:=cpe:/a:flac_project:flac

PKG_FIXUP:=autoreconf
PKG_REMOVE_FILES:=autogen.sh aclocal.m4

include $(INCLUDE_DIR)/package.mk

define Package/libflac
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Free Lossless Audio Codec library
  URL:=https://xiph.org/flac
endef

define Package/flac
  SECTION:=sound
  CATEGORY:=Sound
  TITLE:=flac & metaflac utilities
  URL:=https://xiph.org/flac
  DEPENDS += +libflac
endef

CONFIGURE_ARGS += \
	--disable-cpplibs \
	--disable-sse \
	--disable-3dnow \
	--disable-altivec \
	--disable-doxgen-docs \
	--disable-local-xmms-plugin \
	--disable-xmms-plugin \
	--disable-ogg \
	--disable-oggtest \
	$(if $(CONFIG_DEBUG),--enable-debug) \
	--enable-static

TARGET_CFLAGS += $(FPIC)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/FLAC \
		$(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libFLAC.{a,so*,la} \
		$(1)/opt/lib/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/* \
		$(1)/opt/lib/pkgconfig/

	$(INSTALL_DIR) $(1)/opt/share/aclocal/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/aclocal/* \
		$(1)/opt/share/aclocal/
endef

define Package/libflac/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libFLAC.so* $(1)/opt/lib/
endef

define Package/flac/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
endef

$(eval $(call BuildPackage,libflac))
$(eval $(call BuildPackage,flac))

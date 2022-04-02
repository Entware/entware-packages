#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: flac and utilities added: -DBUILD_PROGRAMS=ON

include $(TOPDIR)/rules.mk

PKG_NAME:=flac
PKG_VERSION:=1.3.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://downloads.xiph.org/releases/flac/
PKG_HASH:=8ff0607e75a322dd7cd6ec48f4f225471404ae2730d0ea945127b1355155e737

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=GFDL-1.2 GPL-2 LGPL-2.1 BSD-3-Clause
PKG_LICENSE_FILES:=README COPYING.FDL COPYING.GPL COPYING.LGPL COPYING.Xiph
PKG_CPE_ID:=cpe:/a:flac_project:flac

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

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

CMAKE_OPTIONS += \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_CXXLIBS=OFF \
	-DBUILD_PROGRAMS=ON \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_DOCS=OFF \
	-DINSTALL_MANPAGES=OFF \
	-DINSTALL_CMAKE_CONFIG_MODULE=OFF \
	-DINSTALL_PKGCONFIG_MODULES=ON \
	-DWITH_OGG=OFF \
	-DWITH_STACK_PROTECTOR=OFF

ifeq ($(CONFIG_TARGET_x86_2_6),y)
CMAKE_OPTIONS += \
	-DCMAKE_ASM_NASM_COMPILER:STRING=""
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/FLAC \
		$(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libFLAC.so* \
		$(1)/opt/lib/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/* \
		$(1)/opt/lib/pkgconfig/
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/flac.pc
	$(SED) 's,/opt/lib,$$$${exec_prefix}/lib,g' $(1)/opt/lib/pkgconfig/flac.pc
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

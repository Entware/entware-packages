#
# Copyright (C) 2017 Yegor Yefremov <yegorslists@googlemail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsoc
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/jackmitch/libsoc.git
PKG_MIRROR_HASH:=bdfaace3d59da30c4aa5ef78b5e235b5e9c41cd56867e04cb0acefc4dcd62d33
PKG_SOURCE_DATE:=2016-12-22
PKG_SOURCE_VERSION:=5b788d4d558a78c52e6cfe97325e4564b307a3a0

PKG_MAINTAINER:=Yegor Yefremov <yegorslists@googlemail.com>
PKG_LICENSE:=LGPL-2.1
PKG_LICENSE_FILES:=LICENCE

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libsoc
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpthread
  TITLE:=SoC Library
  URL:=https://github.com/jackmitch/libsoc
endef

define Package/libsoc/description
  libsoc: C library for interfacing with common SoC peripherals through
  generic kernel interfaces
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-cxx

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libsoc_board.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libsoc_conffile.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libsoc_debug.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libsoc_gpio.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libsoc_i2c.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libsoc_pwm.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libsoc_spi.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsoc.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libsoc.pc $(1)/opt/lib/pkgconfig
endef

define Package/libsoc/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsoc.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libsoc))

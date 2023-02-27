#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=fontconfig
PKG_VERSION:=2.13.94
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://fontconfig.org/release/
PKG_HASH:=a5f052cb73fd479ffb7b697980510903b563bbb55b8f7a2b001fcfb94026003c

PKG_MAINTAINER:=
PKG_LICENSE:=
PKG_LICENSE_FILES:=
PKG_CPE_ID:=cpe:/a:fontconfig_project:fontconfig

PKG_BUILD_DEPENDS:=gperf/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/meson.mk

define Package/fontconfig
  SECTION:=xorg-util
  CATEGORY:=Xorg
  SUBMENU:=Font-Utils
  TITLE:=fontconfig
  DEPENDS:=+libpthread +libexpat +libfreetype
  URL:=http://fontconfig.org/
endef

MESON_ARGS += \
	-Ddoc=disabled \
	-Ddoc-txt=disabled \
	-Dnls=disabled \
	-Dtests=disabled \
	-Dtools=enabled

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/fontconfig $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfontconfig.* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/fontconfig.pc $(1)/opt/lib/pkgconfig/
endef

define Package/fontconfig/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/lib $(1)/opt/share/fontconfig/conf.avail
	$(INSTALL_DIR) $(1)/opt/etc/fonts/conf.d
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/fonts/fonts.conf $(1)/opt/etc/fonts
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/fonts/conf.d/* $(1)/opt/etc/fonts/conf.d
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/share/fontconfig/conf.avail/* $(1)/opt/share/fontconfig/conf.avail
#	$(INSTALL_DIR) $(1)/etc/init.d
#	$(INSTALL_BIN) ./files/fontconfig.init $(1)/etc/init.d/fontconfig
endef

$(eval $(call BuildPackage,fontconfig))

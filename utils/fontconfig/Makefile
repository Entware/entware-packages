#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: bump from 2.11.1 to 2.12.1

include $(TOPDIR)/rules.mk

PKG_NAME:=fontconfig
PKG_VERSION:=2.12.1
PKG_RELEASE:=1a

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://fontconfig.org/release/
PKG_HASH:=b449a3e10c47e1d1c7a6ec6e2016cca73d3bd68fbbd4f0ae5cc6b573f7d6c7f3

PKG_FIXUP:=libtool
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/fontconfig
  SECTION:=xorg-util
  CATEGORY:=Xorg
  SUBMENU:=font-utils
  TITLE:=fontconfig
  DEPENDS:=+libpthread +libexpat +libfreetype
  URL:=http://fontconfig.org/
endef

#TODO: better put cache on persistent storage for faster boot time?
CONFIGURE_ARGS+= \
	--with-cache-dir=/opt/tmp/fontconfig/cache \
	--with-arch=$(ARCH) \
	--disable-iconv \
	--disable-libxml2 \
	--disable-docs

CONFIGURE_VARS+= \
	ac_cv_prog_HASDOCBOOK=no \

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
	$(INSTALL_DIR) $(1)/opt/etc/init.d
#	$(INSTALL_BIN) ./files/fontconfig.init $(1)/opt/etc/init.d/fontconfig
endef

$(eval $(call BuildPackage,fontconfig))

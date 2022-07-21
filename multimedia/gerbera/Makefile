#
# Copyright (C) 2011-2020 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: -Dffmpegthumbnailer=enabled -Djs=enabled

include $(TOPDIR)/rules.mk

PKG_NAME:=gerbera
PKG_VERSION:=1.11.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/gerbera/gerbera/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=0c13049792a28ec0e3086ba61c7f9675626a1dbadb043650a452192727418be7

PKG_MAINTAINER:=
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=LICENSE.md

PKG_BUILD_DEPENDS:=libmatroska pugixml spdlog
PKG_CONFIG_DEPENDS:=CONFIG_BUILD_PATENTED

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/meson.mk

define Package/gerbera
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+file +libnpupnp +libsqlite3 +libexif +libuuid +libfmt +libatomic +taglib +BUILD_PATENTED:libffmpeg $(ICONV_DEPENDS)
  DEPENDS+=+curl +duktape +libffmpegthumbnailer
  TITLE:=A free media server
  URL:=https://gerbera.io
  USERID:=gerbera:gerbera
endef

define Package/gerbera/description
  Gerbera - UPnP Media Server based on Mediatomb.
endef

define Package/gerbera/conffiles
/opt/etc/gerbera/config.xml
endef

MESON_ARGS += \
	-Db_lto=true \
	-Davcodec=$(if $(CONFIG_BUILD_PATENTED),en,dis)abled \
	-Dcurl=enabled \
	-Dexif=enabled \
	-Dexiv2=disabled \
	-Dffmpegthumbnailer=enabled \
	-Dinotify=enabled \
	-Djs=enabled \
	-Dlastfm=disabled \
	-Dmagic=enabled \
	-Dmatroska=enabled \
	-Dmysql=disabled \
	-Dnpupnp=enabled \
	-Dsystemd=disabled \
	-Dtaglib=enabled \
	-Dtests=disabled \
	-Dwavpack=disabled

TARGET_CFLAGS += \
	-ffunction-sections \
	-fdata-sections

TARGET_LDFLAGS += -Wl,--gc-sections

define Package/gerbera/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/gerbera $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/share
	$(CP) $(PKG_INSTALL_DIR)/opt/share/gerbera $(1)/opt/share
	$(INSTALL_DIR) $(1)/opt/etc/gerbera
#	$(INSTALL_CONF) ./files/gerbera.config $(1)/etc/config/gerbera
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S90gerbera $(1)/opt/etc/init.d
endef

define Package/gerbera/postinst
#!/bin/sh

GERBERA_CFG=/opt/etc/gerbera/config.xml
if [ ! -f $$GERBERA_CFG ]; then
    gerbera --create-config > $$GERBERA_CFG
    echo "Please, edit $$GERBERA_CFG first."
fi
endef

$(eval $(call BuildPackage,gerbera))

#
# Copyright (C) 2011-2020 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gerbera
PKG_VERSION:=1.6.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/gerbera/gerbera/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=cbe7ea78977db8c02fcca1759ed149f199a590afaf4a6d21ffcca8623d1a0cc5

PKG_MAINTAINER:=
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=LICENSE.md

PKG_BUILD_DEPENDS:=libmatroska pugixml spdlog taglib
PKG_BUILD_PARALLEL:=1
PKG_CONFIG_DEPENDS:=CONFIG_BUILD_PATENTED

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
include $(INCLUDE_DIR)/nls.mk

define Package/gerbera
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+file +libnpupnp +libsqlite3 +libexif +libuuid +libfmt +BUILD_PATENTED:libffmpeg $(ICONV_DEPENDS)
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

CMAKE_OPTIONS += \
	-DIconv_INCLUDE_DIR=$(ICONV_PREFIX)/include \
	-DIconv_LIBRARY=$(ICONV_PREFIX)/lib/libiconv.a \
	-DWITH_MAGIC=ON \
	-DWITH_MYSQL=OFF \
	-DWITH_CURL=ON \
	-DWITH_INOTIFY=ON \
	-DWITH_JS=ON \
	-DWITH_TAGLIB=ON \
	-DWITH_AVCODEC=$(if $(CONFIG_BUILD_PATENTED),ON,OFF) \
	-DWITH_FFMPEGTHUMBNAILER=ON \
	-DWITH_EXIF=ON \
	-DWITH_EXIV2=OFF \
	-DWITH_MATROSKA=ON \
	-DWITH_SYSTEMD=OFF \
	-DWITH_LASTFM=OFF \
	-DWITH_DEBUG=OFF \
	-DWITH_TESTS=OFF \
	-DWITH_NPUPNP=ON

TARGET_CFLAGS += \
	-ffunction-sections \
	-fdata-sections \
	-flto

TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed

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

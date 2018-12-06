#
# Copyright (C) 2010-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Bunch of our patches for thumbnail support and other featues

include $(TOPDIR)/rules.mk

PKG_NAME:=minidlna
PKG_VERSION:=1.2.1
PKG_RELEASE:=4

PKG_SOURCE_URL:=@SF/minidlna
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=67388ba23ab0c7033557a32084804f796aa2a796db7bb2b770fb76ac2a742eec

PKG_LICENSE:=GPL-2.0 BSD-3-Clause
PKG_LICENSE_FILES:=COPYING LICENCE.miniupnpd

PKG_MAINTAINER:=Knyazkov Dmitry <medavedik@gmail.com>

PKG_FIXUP:=autoreconf

PKG_BUILD_PARALLEL:=0
PKG_BUILD_DEPENDS:=util-linux

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/minidlna
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=UPnP A/V & DLNA Media Server
  URL:=http://minidlna.sourceforge.net/
  DEPENDS:= +libpthread +libexif +libjpeg +libsqlite3 \
  	+libid3tag +libflac +libvorbis +libuuid +libffmpegthumbnailer +libopusfile \
  	$(ICONV_DEPENDS) $(INTL_DEPENDS)
endef

define Package/minidlna/description
  MiniDLNA (aka ReadyDLNA) is server software with the aim of
  being fully compliant with DLNA/UPnP-AV clients.
endef

define Package/minidlna/conffiles
/opt/etc/minidlna.conf
endef

TARGET_CPPFLAGS += \
	-I$(STAGING_DIR)/opt/include \
	-I$(STAGING_DIR)/opt/include/FLAC \
	-I$(STAGING_DIR)/opt/include/libexif \
	-I$(STAGING_DIR)/opt/include/uuid \
	-I$(STAGING_DIR)/opt/include/vorbis \
	-I$(ICONV_PREFIX)/include \
	-I$(INTL_PREFIX)/include \
	-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 \

TARGET_LDFLAGS += \
	-L$(ICONV_PREFIX)/lib \
	-L$(INTL_PREFIX)/lib \
	-Wl,-rpath-link=$(STAGING_DIR)/opt/lib \

MAKE_FLAGS +=\
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	ICONV_LIBS="-liconv $(if $(INTL_FULL),-lintl)" \

CONFIGURE_ARGS +=\
	--with-libiconv-prefix="$(ICONV_PREFIX)" \
	--with-libintl-prefix="$(INTL_PREFIX)" \
	--with-os-name="OpenWrt Linux" \
	--with-os-version="$(LINUX_VERSION)" \
	--with-os-url="http://openwrt.org/" \
	--with-db-path="/opt/var/minidlna" \
	--with-log-path="/opt/var/minidlna" \
	--enable-thumbnail \

define Package/minidlna/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/minidlnad $(1)/opt/bin/minidlna
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S90minidlna $(1)/opt/etc/init.d
	$(INSTALL_CONF) ./files/minidlna.conf $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/var/minidlna
endef

$(eval $(call BuildPackage,minidlna))

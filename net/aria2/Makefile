#
# Copyright (C) 2012-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=aria2
PKG_VERSION:=1.23.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/tatsuhiro-t/aria2/releases/download/release-$(PKG_VERSION)
PKG_MD5SUM:=bc41d919e7d89835ee01c1175300eddc
PKG_INSTALL:=1

PKG_MAINTAINER:=Imre Kaloz <kaloz@openwrt.org>
PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=COPYING

PKG_CONFIG_DEPENDS := \
  ARIA2_NOSSL \
  ARIA2_OPENSSL \
  ARIA2_GNUTLS \
  ARIA2_BITTORRENT \
  ARIA2_METALINK \
  ARIA2_SFTP

include $(INCLUDE_DIR)/package.mk

define Package/aria2/config
  source "$(SOURCE)/Config.in"
endef

define Package/aria2
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=File Transfer
  TITLE:=lightweight download utility
  URL:=http://aria2.sourceforge.net/
  DEPENDS:=+zlib +ARIA2_METALINK:libxml2 +libstdcpp +ARIA2_OPENSSL:libopenssl +ARIA2_GNUTLS:libgnutls +ARIA2_SFTP:libssh2
endef

define Package/aria2/description
 aria2 is a lightweight multi-protocol & multi-source command-line download
 utility
endef

CONFIGURE_ARGS += \
	--disable-nls \
	$(if $(CONFIG_ARIA2_NOSSL),--disable,--enable)-ssl \
	$(if $(CONFIG_ARIA2_OPENSSL),--with,--without)-openssl \
	$(if $(CONFIG_ARIA2_GNUTLS),--with,--without)-gnutls \
	$(if $(CONFIG_ARIA2_BITTORRENT),--enable,--disable)-bittorrent \
	$(if $(CONFIG_ARIA2_METALINK),--enable,--disable)-metalink \
	$(if $(CONFIG_ARIA2_METALINK),--with,--without)-libxml2 \
	$(if $(CONFIG_ARIA2_SFTP),--with,--without)-libssh2 \
	--without-libnettle \
	--without-libgmp \
	--without-libgcrypt \
	--without-libexpat \
	--without-libcares \
	--without-sqlite3 \
	--without-libuv \
	--with-libz

TARGET_CXXFLAGS += -fpermissive

define Package/aria2/conffiles
/opt/etc/aria2.conf
endef

define Package/aria2/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/aria2c $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/var/aria2/torrents $(1)/opt/etc/init.d
	$(INSTALL_CONF) ./files/aria2.conf $(1)/opt/etc
	$(INSTALL_BIN) ./files/S81aria2 $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,aria2))

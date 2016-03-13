#
# Copyright (C) 2009-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=transmission
PKG_VERSION:=2.92
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://download.transmissionbt.com/files \
	http://mirrors.m0k.org/transmission/files
PKG_MD5SUM:=3fce404a436e3cd7fde80fb6ed61c264

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/transmission/template
  SUBMENU:=BitTorrent
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A free, lightweight BitTorrent client
  URL:=http://www.transmissionbt.com
  MAINTAINER:=Cezary Jackiewicz <cezary@eko.one.pl>
endef

define Package/transmission-daemon
  $(call Package/transmission/template)
  DEPENDS:=+libcurl +libopenssl +libpthread +libevent2 +librt
  MENU:=1
  USERID:=transmission=224:transmission=224
endef

define Package/transmission-cli
  $(call Package/transmission/template)
  DEPENDS:=transmission-daemon
endef

define Package/transmission-remote
  $(call Package/transmission/template)
  DEPENDS:=+libcurl +libopenssl +libpthread +libevent2 +librt
endef

define Package/transmission-web
  $(call Package/transmission/template)
  DEPENDS:=transmission-daemon
endef


define Package/transmission-daemon/description
 Transmission is a simple BitTorrent client.
 It features a very simple, intuitive interface
 on top on an efficient, cross-platform back-end.
 This package contains the daemon itself.
endef

define Package/transmission-cli/description
 CLI utilities for transmission.
endef

define Package/transmission-remote/description
 CLI remote interface for transmission.
endef

define Package/transmission-web/description
 Webinterface resources for transmission.
endef

define Package/transmission-daemon/conffiles
/opt/etc/transmission/settings.json
endef

CONFIGURE_VARS += \
	LIBEVENT_LIBS="$(STAGING_DIR)/opt/lib/libevent-2.0.so.5"

CONFIGURE_ARGS += \
	--enable-daemon \
	--enable-cli \
	--without-gtk \
	--enable-largefile \
	--enable-lightweight

MAKE_FLAGS += \
	CFLAGS="-std=gnu99 $(TARGET_CFLAGS)"

define Package/transmission-daemon/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/transmission-daemon $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/transmission $(1)/opt/etc/transmission/blocklists $(1)/opt/etc/transmission/resume $(1)/opt/etc/transmission/torrents $(1)/opt/etc/transmission/watchdir
	$(INSTALL_CONF) files/settings.json $(1)/opt/etc/transmission
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S88transmission $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/downloads/torrent/incomplete
endef

define Package/transmission-cli/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/transmission-cli \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-create \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-edit \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-show \
			$(1)/opt/bin/
endef

define Package/transmission-remote/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/transmission-remote $(1)/opt/bin/
endef

define Package/transmission-web/install
	$(INSTALL_DIR) $(1)/opt/share/transmission
	$(CP) $(PKG_INSTALL_DIR)/opt/share/transmission/web $(1)/opt/share/transmission/
endef

$(eval $(call BuildPackage,transmission-daemon))
$(eval $(call BuildPackage,transmission-cli))
$(eval $(call BuildPackage,transmission-remote))
$(eval $(call BuildPackage,transmission-web))

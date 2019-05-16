#
# Copyright (C) 2009-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=prosody
PKG_VERSION:=0.11.2
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://prosody.im/downloads/source
PKG_HASH:=8911f6dc29b9e0c4edf9e61dc23fa22d77bc42c4caf28b809ab843b2f08e4831
PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>
PKG_LICENSE:=MIT/X11
PKG_BUILD_DEPENDS:=lua/host
PKG_CPE_ID:=cpe:/a:prosody:prosody
HOST_BUILD_DEPENDS:=$(PKG_BUILD_DEPENDS)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/prosody
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Instant Messaging
  DEPENDS:=+luafilesystem +libidn +luaexpat +luasec +libopenssl +libidn +liblua +luabitop
  TITLE:=XMPP server
  URL:=https://prosody.im/
  USERID:=prosody=54:prosody=54
endef

define Package/prosody/description
  Prosody is an exciting new server for Jabber/XMPP
  written in Lua. It aims to be easy to use, and light
  on resources
endef

define Package/prosody/conffiles
/opt/etc/prosody/prosody.cfg.lua
endef

TARGET_CFLAGS += $(FPIC) -std=gnu99
TARGET_LDFLAGS += -shared

MAKE_FLAGS += LD="$(TARGET_CC)"

define Build/Configure
	# this is *NOT* GNU autoconf stuff
	(cd $(PKG_BUILD_DIR); ./configure \
		--prefix=/opt \
		--with-lua="$(STAGING_DIR_HOSTPKG)" \
		--with-lua-include="$(STAGING_DIR)/opt/include" \
		--with-lua-lib="$(STAGING_DIR)/opt/lib" \
		--cflags="$(TARGET_CFLAGS)" \
		--ldflags="$(TARGET_LDFLAGS) -llua -lm -ldl -shared" \
		--c-compiler="$(TARGET_CC)" \
		--datadir="/opt/etc/prosody/data" \
	)
endef

define Package/prosody/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S34prosody $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/etc/prosody
	#$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/prosody/prosody.cfg.lua $(1)/etc/prosody/
	$(INSTALL_CONF) ./files/prosody.cfg.lua $(1)/opt/etc/prosody/
	$(INSTALL_DIR) $(1)/opt/etc/prosody/certs
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/prosody/certs/localhost.{crt,key} $(1)/opt/etc/prosody/certs/
	$(INSTALL_DIR) $(1)/opt/etc/prosody/data
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/prosody{,ctl} $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib/prosody
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/prosody/prosody.version $(1)/opt/lib/prosody/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/core
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/core/*.lua $(1)/opt/lib/prosody/core/
	#$(INSTALL_DIR) $(1)/usr/lib/prosody/fallbacks
	#$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/prosody/fallbacks/*.lua $(1)/usr/lib/prosody/fallbacks/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/*.lua $(1)/opt/lib/prosody/modules/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/adhoc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/adhoc/*.lua $(1)/opt/lib/prosody/modules/adhoc/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/mod_s2s
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/mod_s2s/*.lua $(1)/opt/lib/prosody/modules/mod_s2s/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/muc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/muc/*.lua $(1)/opt/lib/prosody/modules/muc/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/mod_pubsub
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/mod_pubsub/*.lua $(1)/opt/lib/prosody/modules/mod_pubsub/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/mod_mam
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/mod_mam/*.lua $(1)/opt/lib/prosody/modules/mod_mam/
	#$(INSTALL_DIR) $(1)/usr/lib/prosody/modules/storage
	#$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/prosody/modules/storage/*.lua $(1)/usr/lib/prosody/modules/storage/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/net
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/net/*.lua $(1)/opt/lib/prosody/net/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/net/http
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/net/http/*.lua $(1)/opt/lib/prosody/net/http/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/net/resolvers
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/net/resolvers/*.lua $(1)/opt/lib/prosody/net/resolvers/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/net/websocket
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/net/websocket/*.lua $(1)/opt/lib/prosody/net/websocket/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/util
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/util/*.lua $(1)/opt/lib/prosody/util/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/prosody/util/*.so $(1)/opt/lib/prosody/util/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/util/sasl
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/util/sasl/*.lua $(1)/opt/lib/prosody/util/sasl/
	#$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/prosody/util/sasl/*.so $(1)/usr/lib/prosody/util/sasl/
	$(INSTALL_DIR) $(1)/opt/var/{log,run}/prosody
	# fix opt paths
	$(SED) '1c\#!/opt/bin/lua' $(1)/opt/bin/prosody{,ctl}
	$(SED) 's|/etc/ssl/certs|/opt/etc/ssl/certs|' $(1)/opt/lib/prosody/core/certmanager.lua
	$(SED) 's|/etc/mime.types|/opt/etc/mime.types|' $(1)/opt/lib/prosody/modules/mod_http_files.lua
endef


$(eval $(call BuildPackage,prosody))

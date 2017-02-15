#
# Copyright (C) 2009-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=prosody
PKG_VERSION:=0.9.12
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://prosody.im/downloads/source
PKG_MD5SUM:=d743adea6cfbaacc3a24cc0c3928bb1b
PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>
PKG_LICENSE:=MIT/X11

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/prosody
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Instant Messaging
  DEPENDS:=+luafilesystem +libidn +luaexpat +luasec +libopenssl +libidn +liblua 
  TITLE:=XMPP server
  URL:=http://prosody.im/
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

TARGET_CFLAGS += $(FPIC) 

TARGET_LDFLAGS += -L$(STAGING_DIR)/opt/lib 


define Build/Configure
	# this is *NOT* GNU autoconf stuff
	(cd $(PKG_BUILD_DIR); ./configure \
		--prefix=/opt \
		--with-lua="$(STAGING_DIR_HOSTPKG)/bin" \
		--with-lua-include="$(STAGING_DIR)/opt/include" \
		--with-lua-lib="$(STAGING_DIR)/opt/lib" \
		--cflags="$(TARGET_CFLAGS)" \
		--ldflags="$(TARGET_LDFLAGS) -llua -lm -ldl -shared" \
		--c-compiler="$(TARGET_CC)" \
		--linker="$(TARGET_CC)" \
		--datadir="/opt/etc/prosody/data" \
	)
endef
#	LDFLAGS="$(TARGET_LDFLAGS) -llua -lm -ldl" \

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -std=gnu99" \
	PREFIX="/opt" \
	LD="$(TARGET_CC)"

define Package/prosody/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S34prosody $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/etc/prosody
	#$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/prosody/prosody.cfg.lua $(1)/opt/etc/prosody/
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
	$(INSTALL_DIR) $(1)/opt/lib/prosody/fallbacks
	#$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/fallbacks/*.lua $(1)/opt/lib/prosody/fallbacks/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/*.lua $(1)/opt/lib/prosody/modules/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/adhoc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/adhoc/*.lua $(1)/opt/lib/prosody/modules/adhoc/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/mod_s2s
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/mod_s2s/*.lua $(1)/opt/lib/prosody/modules/mod_s2s/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/muc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/muc/*.lua $(1)/opt/lib/prosody/modules/muc/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/modules/storage
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/modules/storage/*.lua $(1)/opt/lib/prosody/modules/storage/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/net
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/net/*.lua $(1)/opt/lib/prosody/net/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/net/http
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/net/http/*.lua $(1)/opt/lib/prosody/net/http/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/util
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/util/*.lua $(1)/opt/lib/prosody/util/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/prosody/util/*.so $(1)/opt/lib/prosody/util/
	$(INSTALL_DIR) $(1)/opt/lib/prosody/util/sasl
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/prosody/util/sasl/*.lua $(1)/opt/lib/prosody/util/sasl/
	#$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/prosody/util/sasl/*.so $(1)/opt/lib/prosody/util/sasl/
	$(INSTALL_DIR) $(1)/opt/var/{log,run}/prosody
endef

$(eval $(call BuildPackage,prosody))

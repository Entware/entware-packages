#
# Copyright (C) 2015 OpenWrt.org
# Copyright (C) 2017 Yousong Zhou <yszhou4tech@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks-libev
PKG_VERSION:=3.0.6
PKG_RELEASE:=1a

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$(PKG_VERSION)
PKG_HASH:=7d9b43b0235a57c115bfe160efd54abef96bffcbfff61c5496e7c2800f0734ca

PKG_MAINTAINER:=Jian Chang <aa65535@live.com>
PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks-libev
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/shadowsocks/shadowsocks-libev
	DEPENDS:=+libev +libmbedtls +libpthread +libsodium +libudns \
		+libpcre +zlib
endef

define Package/shadowsocks-libev/description
Shadowsocks-libev is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

define Package/shadowsocks-libev/conffiles
/opt/etc/shadowsocks.json
endef

define Package/shadowsocks-libev/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{redir,tunnel} $(1)/opt/bin
	$(INSTALL_BIN) ./files/ss-rules $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S22shadowsocks $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/debian/config.json $(1)/opt/etc/shadowsocks.json
	$(INSTALL_DIR) $(1)/opt/share/shadowsocks-libev
endef

CONFIGURE_ARGS += --disable-documentation

$(eval $(call BuildPackage,shadowsocks-libev))

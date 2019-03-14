# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: bumped form 0.2.4 to 0.2.5

include $(TOPDIR)/rules.mk

PKG_NAME:=stubby
PKG_VERSION:=0.2.5
PKG_RELEASE:=1

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jonathan Underwood <jonathan.underwood@gmail.com>

PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/getdnsapi/$(PKG_NAME)
PKG_SOURCE_VERSION:=9c6e55a16af8f3258736b804b17eac3d35daebf3
PKG_MIRROR_HASH:=b50fec400a6277f667e9c26b7a7fd2903412c158a6ed73224fa5485ae87aca28

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/stubby/Default
	TITLE:=stubby
	URL:=https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Daemon+-+Stubby
endef

define Package/stubby
	$(call Package/stubby/Default)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE+= - (daemon that uses getdns)
#	USERID:=stubby=410:stubby=410
	DEPENDS:= +libyaml +getdns +ca-certificates
endef

define Package/stubby/description
	This package contains the Stubby daemon (which utilizes the getdns library).

	See https://github.com/openwrt/packages/blob/master/net/stubby/files/README.md for more details.
endef

define Package/stubby/conffiles
/opt/etc/stubby/stubby.yml
endef

define Package/stubby/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/stubby $(1)/opt/sbin/stubby
	$(INSTALL_DIR) $(1)/opt/etc/init.d
#	$(INSTALL_BIN)  ./files/stubby.init $(1)/opt/etc/init.d/stubby
	$(INSTALL_DIR) $(1)/opt/etc/stubby
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/stubby/stubby.yml $(1)/opt/etc/stubby/stubby.yml.default
	$(INSTALL_DATA) ./files/stubby.yml $(1)/opt/etc/stubby/stubby.yml
endef

$(eval $(call BuildPackage,stubby))

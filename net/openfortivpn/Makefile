#
# Copyright (C) 2019 - Lucian Cristian <lucian.cristian@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openfortivpn
PKG_VERSION:=1.19.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/adrienverge/openfortivpn/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=9e244c3b63176269ce433349e67f8fd6e532f7c8d515f4c97558911a449152c3

PKG_MAINTAINER:=Lucian Cristian <lucian.cristian@gmail.com>
PKG_LICENSE:=GPL-3.0-or-later OpenSSL
PKG_LICENSE_FILES:=LICENSE LICENSE.OpenSSL

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/openfortivpn
  SUBMENU:=VPN
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Fortinet SSL VPN client
  URL:=https://github.com/adrienverge/openfortivpn
  DEPENDS:=+ppp +libopenssl
endef

define Package/openfortivpn/description
  An open implementation of Fortinet's proprietary PPP+SSL VPN solution
  It spawns a pppd process and operates the communication between the gateway and this process.
  It is compatible with Fortinet VPNs.
endef

define Package/openfortivpn/conffiles
/opt/etc/openfortivpn/config
endef

CONFIGURE_ARGS += \
	--enable-proc \
	--with-rt_dst="yes" \
	--disable-resolvconf \
	--with-resolvconf=DISABLED \
	--with-pppd="/opt/sbin/pppd"

TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed

define Package/openfortivpn/install
	$(INSTALL_DIR) \
	  $(1)/opt/sbin \
	  $(1)/opt/etc/openfortivpn \
	  $(1)/opt/lib/upgrade/keep.d

	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/openfortivpn $(1)/opt/sbin/
#	$(INSTALL_BIN) ./files/openfortivpn-wrapper $(1)/usr/sbin/
#	$(INSTALL_BIN) ./files/openfortivpn.sh $(1)/lib/netifd/proto/
#	$(INSTALL_BIN) ./files/openfortivpn-ppp-up $(1)/lib/netifd/openfortivpn-ppp-up
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/openfortivpn/* $(1)/opt/etc/openfortivpn
	$(INSTALL_DATA) ./files/openfortivpn.upgrade $(1)/opt/lib/upgrade/keep.d/openfortivpn
endef

$(eval $(call BuildPackage,openfortivpn))

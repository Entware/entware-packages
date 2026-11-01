#
# Copyright (C) 2007-2026 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# Entware specific: remove deps USE_GLIBC:libcrypt-compat;
# -Dfirewall-script=iptables

include $(TOPDIR)/rules.mk

PKG_NAME:=ocserv
PKG_VERSION:=1.6.0
PKG_RELEASE:=1
PKG_BUILD_FLAGS:=no-mips16

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://www.infradead.org/ocserv/download/
PKG_HASH:=2d3303a0d9e06eabfa08694b9dca3c558fef36418857bebf1b8de57ece5f9f32

PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_CONFIG_DEPENDS:= \
	CONFIG_OCSERV_PAM \
	CONFIG_OCSERV_SECCOMP \
	CONFIG_OCSERV_PROTOBUF \
	CONFIG_OCSERV_RADIUS \
	CONFIG_OCSERV_LIBOATH

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/meson.mk

define Package/ocserv/config
	source "$(SOURCE)/Config.in"
endef

define Package/ocserv
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=OpenConnect VPN server
  URL:=https://ocserv.openconnect-vpn.net/
  MAINTAINER:=Nikos Mavrogiannopoulos <n.mavrogiannopoulos@gmail.com>
  DEPENDS:= +OCSERV_RADIUS:libradcli +OCSERV_SECCOMP:libseccomp +libgnutls +certtool +libncurses +libreadline +OCSERV_PAM:libpam +OCSERV_PROTOBUF:libprotobuf-c +OCSERV_LIBOATH:liboath +libev
  USERID:=ocserv=72:ocserv=72
endef

define Package/ocserv/description
 OpenConnect server (ocserv) is an SSL VPN server. Its purpose is to be
 a secure, small, fast and configurable VPN server. It implements the
 OpenConnect SSL VPN protocol, and has also (currently experimental)
 compatibility with clients using the AnyConnect SSL VPN protocol. The
 OpenConnect VPN protocol uses the standard IETF security protocols such
 as TLS 1.2, and Datagram TLS to provide the secure VPN service.
endef

MESON_ARGS += \
	-Dpager='' \
	-Dlibnl=disabled \
	-Dgssapi=disabled \
	-Dmaxmind=disabled \
	-Dlz4=disabled \
	-Dfirewall-script=iptables \
	-Dlocal-talloc=true \
	-Dsock-diag=disabled \
	-Dlibwrap=disabled \
	-Dtests=false

# Conditional features derived from Config.in
MESON_ARGS += -Dpam=$(if $(CONFIG_OCSERV_PAM),enabled,disabled)
MESON_ARGS += -Dradius=$(if $(CONFIG_OCSERV_RADIUS),enabled,disabled)
MESON_ARGS += -Dseccomp=$(if $(CONFIG_OCSERV_SECCOMP),enabled,disabled)
MESON_ARGS += -Dlocal-protobuf=$(if $(CONFIG_OCSERV_PROTOBUF),false,true)
MESON_ARGS += -Dliboath=$(if $(CONFIG_OCSERV_LIBOATH),enabled,disabled)

define Package/ocserv/conffiles
/opt/etc/ocserv
endef

define Package/ocserv/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/ocserv $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/ocserv-worker $(1)/opt/sbin/

	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ocpasswd $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/occtl $(1)/opt/bin/

	$(INSTALL_DIR) $(1)/opt/libexec
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/libexec/ocserv-fw $(1)/opt/libexec/

	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S79ocserv $(1)/opt/etc/init.d

	$(INSTALL_DIR) $(1)/opt/etc/ocserv
	$(INSTALL_CONF) ./files/ocserv.conf.template $(1)/opt/etc/ocserv/ocserv.conf.template

#	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/ocserv.conf $(1)/opt/etc/ocserv

	$(INSTALL_DIR) $(1)/opt/lib/upgrade/keep.d
	$(INSTALL_DATA) ./files/ocserv.upgrade $(1)/opt/lib/upgrade/keep.d/ocserv
endef

$(eval $(call BuildPackage,ocserv))

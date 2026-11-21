#
# Copyright (C) 2019 Lucian Cristian <lucian.cristian@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=frr
PKG_VERSION:=10.7.1
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/FRRouting/frr/tar.gz/$(PKG_NAME)-$(PKG_VERSION)?
PKG_HASH:=6aaf9d89deb94eeda6acceaa6fe48d8cd365d0908231e58f628538ff49696fc4


PKG_MAINTAINER:=Lucian Cristian <lucian.cristian@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_NAME)-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-$(PKG_NAME)-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0-only LGPL-2.1-only
PKG_CPE_ID:=cpe:/a:frrouting:frrouting

PKG_DAEMON_AVAILABLE:= \
	babeld \
	bfdd \
	bgpd \
	eigrpd \
	fabricd \
	isisd \
	ldpd \
	nhrpd \
	ospfd \
	ospf6d \
	pathd \
	pbrd \
	pimd \
	pim6d \
	ripd \
	ripngd \
	staticd \
	vrrpd

PKG_CONFIG_DEPENDS:= \
	CONFIG_IPV6 \
	CONFIG_FRR_OPENSSL \
	CONFIG_FRR_INTERNAL \
	CONFIG_FRR_SNMP \
	CONFIG_FRR_NO_SNMP \
	CONFIG_PACKAGE_frr \
	CONFIG_PACKAGE_frr-watchfrr \
	CONFIG_PACKAGE_frr-zebra \
	$(patsubst %,CONFIG_PACKAGE_frr-%,$(PKG_DAEMON_AVAILABLE)) \

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_BUILD_FLAGS:=lto

PKG_BUILD_DEPENDS:=frr/host protobuf-c/host
HOST_BUILD_DEPENDS:=python3/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/frr/config
  source "$(SOURCE)/Config.in"
endef

define Package/frr/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  URL:=https://www.frrouting.org/
  # Spelled out: apk's soname resolution would pick libyang 5.x.
  DEPENDS:=frr +libyang-legacy
endef

define Package/frr
  $(call Package/frr/Default)
  DEPENDS:=+librt +libatomic +libcap +libncurses +libjson-c +libreadline \
    +libyang-legacy +libprotobuf-c +FRR_OPENSSL:libopenssl +FRR_SNMP:libnetsnmp +more
  TITLE:=The FRRouting (FRR) Software Routing Suite
  MENU:=1
endef

define Package/frr/description
  FRRouting is free software that implements and manages various IPv4 and IPv6
  routing protocols.

  Currently FRRouting supports BGP4, BGP4+, OSPFv2, OSPFv3, RIPv1, RIPv2, RIPng,
  IS-IS, PIM-SM/MSDP, LDP, VRRP and Babel as well as very early support for EIGRP and
  NHRP.
endef

define Package/frr-watchfrr
  $(call Package/frr/Default)
  TITLE:=frr watchdog
  DEFAULT:=y if PACKAGE_frr
endef

define Package/frr-zebra
  $(call Package/frr/Default)
  TITLE:=Zebra daemon
  DEFAULT:=y if PACKAGE_frr
  CONFLICTS:=quagga-zebra
endef

define Package/frr-pythontools
  $(call Package/frr/Default)
  TITLE:=Python reload tool
  DEPENDS+=+python3-base +python3-light +python3-logging
endef

##Migrate from quagga
##should test file exists and link in frr folder
#define Package/frr/postinst
##!/bin/sh
#if [ -f /opt/etc/quagga/ospfd.conf ]; then
#    ls to /opt/etc/frr
#    sed enable ospfd daemon
#fi
#exit 0
#endef

define BuildDaemon
    define Package/frr-$(1)
	$$(call Package/frr/Default)
	TITLE:= $(1) routing engine
ifeq ($(1),bgpd)
	KCONFIG:=CONFIG_TCP_MD5SIG=y
endif
ifeq ($(1),babeld)
	CONFLICTS:=babeld
endif
ifeq ($(1),bfdd)
	CONFLICTS:=bfdd
endif
	DEPENDS+=$(2) +frr-watchfrr +frr-zebra
    endef
#	if [ "$(1)" == "bfdd" ]; then \
#	export HAVE_BFDD == 1 ; fi

    define Package/frr-$(1)/install
	$(INSTALL_DIR) $$(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/$(1) $$(1)/opt/sbin/; \
	if [ "$(1)" == "nhrpd" ]; then \
	$(INSTALL_DIR) $$(1)/opt/lib; \
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfrrcares.so* $$(1)/opt/lib/; fi
    endef

    $$(eval $$(call BuildPackage,frr-$(1)))
endef

define Package/frr/conffiles
/opt/etc/frr/daemons
/opt/etc/frr/frr.conf
/opt/etc/frr/vtysh.conf
endef

# frr needs the v3 ABI; its configure looks libyang up three ways
# (PKG_CHECK_MODULES, pkg-config --modversion, AC_CHECK_LIB), so all of
# LDFLAGS, LIBYANG_* and PKG_CONFIG_PATH point at the legacy prefix.
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed -latomic \
	-L$(STAGING_DIR)/opt/lib/libyang-legacy/lib

CONFIGURE_VARS += \
	LIBYANG_CFLAGS="-I$(STAGING_DIR)/opt/lib/libyang-legacy/include" \
	LIBYANG_LIBS="-L$(STAGING_DIR)/opt/lib/libyang-legacy/lib -lyang" \
	PKG_CONFIG_PATH="$(STAGING_DIR)/opt/lib/libyang-legacy/lib/pkgconfig:$$$$PKG_CONFIG_PATH"

define Host/Configure
	$(Host/Configure/Default)
	$(SED) 's/$$$$(MAKE) $$$$(AM_MAKEFLAGS) install-am/# $$$$(MAKE) $$$$(AM_MAKEFLAGS) install-am/' $(HOST_BUILD_DIR)/Makefile.in
endef

HOST_CPPFLAGS += -I$(STAGING_DIR_HOST)/include/libelf
HOST_CONFIGURE_ARGS+= \
	--enable-clippy-only

HOST_MAKE_FLAGS = \
        LIBS+='-lz'

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/bin
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/lib/clippy $(STAGING_DIR_HOSTPKG)/bin/
endef

CONFIGURE_ARGS+= \
	--with-clippy=$(STAGING_DIR_HOSTPKG)/bin/clippy \
	--enable-vtysh \
	--enable-zebra \
	--enable-shared \
	--disable-static \
	--enable-user=network \
	--enable-group=network \
	--disable-ospfclient \
	--disable-doc \
	--disable-backtrace \
	--localstatedir=/opt/var/run/frr \
	--sysconfdir=/opt/etc/frr/ \
	$(if $(CONFIG_FRR_OPENSSL),--with-crypto=openssl,) \
	$(if $(CONFIG_FRR_SNMP),--enable-snmp,) \
	$(foreach m,$(PKG_DAEMON_AVAILABLE), \
	$(call autoconf_bool,CONFIG_PACKAGE_frr-$(m),$(m)) )


define Package/frr/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/var/run/frr
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/etc/frr
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/vtysh $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/mgmtd $(1)/opt/sbin/
	$(INSTALL_CONF) ./files/vtysh.conf $(1)/opt/etc/frr/
	$(INSTALL_DIR) $(1)/opt/lib $(1)/opt/etc/frr
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfrr.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmgmt_be_nb.so* $(1)/opt/lib/
	$(if $(CONFIG_FRR_SNMP),$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfrrsnmp.so* $(1)/opt/lib/,)
	$(INSTALL_CONF) ./files/{frr.conf,daemons} $(1)/opt/etc/frr/
endef

define Package/frr-watchfrr/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/watchfrr $(1)/opt/sbin/
endef

define Package/frr-zebra/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/zebra $(1)/opt/sbin/
	# $(CP) keeps the symlink chain; INSTALL_BIN would flatten it.
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmlag_pb.so* $(1)/opt/lib/
endef

define Package/frr-pythontools/install
	$(INSTALL_DIR) $(1)/opt/lib/frr $(1)/opt/sbin $(1)/opt/etc/frr
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/*.py $(1)/opt/lib/frr/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/frr-reload $(1)/opt/sbin/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/tools/etc/frr/support_bundle_commands.conf $(1)/opt/etc/frr/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,frr))
$(eval $(call BuildPackage,frr-pythontools))
$(eval $(call BuildPackage,frr-watchfrr))
$(eval $(call BuildPackage,frr-zebra))
$(eval $(call BuildDaemon,babeld,))
$(eval $(call BuildDaemon,bfdd,))
$(eval $(call BuildDaemon,bgpd,))
$(eval $(call BuildDaemon,eigrpd,))
$(eval $(call BuildDaemon,fabricd,))
$(eval $(call BuildDaemon,isisd,))
$(eval $(call BuildDaemon,ldpd,))
$(eval $(call BuildDaemon,nhrpd,+libcares))
$(eval $(call BuildDaemon,ospfd,))
$(eval $(call BuildDaemon,ospf6d,@IPV6))
$(eval $(call BuildDaemon,pathd,))
$(eval $(call BuildDaemon,pbrd,))
$(eval $(call BuildDaemon,pimd,))
$(eval $(call BuildDaemon,pim6d,))
$(eval $(call BuildDaemon,ripd,))
$(eval $(call BuildDaemon,ripngd,@IPV6))
$(eval $(call BuildDaemon,staticd,))
$(eval $(call BuildDaemon,vrrpd,))

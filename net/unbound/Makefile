#
# Copyright (C) 2010-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=unbound
PKG_VERSION:=1.17.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://nlnetlabs.nl/downloads/unbound
PKG_HASH:=ee4085cecce12584e600f3d814a28fa822dfaacec1f94c84bfd67f8a5571a5f4

PKG_MAINTAINER:=Eric Luehrsen <ericluehrsen@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:nlnetlabs:unbound

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:=CONFIG_PACKAGE_libunbound_dnscrypt \
	CONFIG_PACKAGE_libunbound_ipset \
	CONFIG_PACKAGE_libunbound_libevent \
	CONFIG_PACKAGE_libunbound_libpthread \
	CONFIG_PACKAGE_libunbound_nghttp2 \
	CONFIG_PACKAGE_libunbound_pythonmodule \
	CONFIG_PACKAGE_libunbound_subnet \
	CONFIG_PACKAGE_libunbound_dnstap

include $(INCLUDE_DIR)/package.mk

define Package/unbound/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  USERID:=unbound:unbound
  TITLE:=Recursive DNS Server
  URL:=https://nlnetlabs.nl/projects/unbound/about
  DEPENDS:=+ca-bundle +libopenssl +@OPENSSL_WITH_EC
endef

define Package/unbound-daemon
  $(call Package/unbound/Default)
  TITLE+= (daemon)
  DEPENDS+= +libunbound
endef

define Package/unbound-daemon/description
  This package contains the Unbound daemon including 'libevent', 'libmnl', and
  'libpthread' to better handle large networks with heavy query loads. Options
  are available under libraries/network/libunbound to custom trim Unbound for
  smaller targets.
endef

define Package/libunbound
  $(call Package/unbound/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Networking
  TITLE+= (library)
  DEPENDS+=+PACKAGE_libunbound_dnscrypt:libsodium \
    +PACKAGE_libunbound_ipset:libmnl \
    +PACKAGE_libunbound_libevent:libevent2 \
    +PACKAGE_libunbound_libpthread:libpthread \
    +PACKAGE_libunbound_nghttp2:libnghttp2 \
    +PACKAGE_libunbound_pythonmodule:python3-base \
    +PACKAGE_libunbound_dnstap:libprotobuf-c
endef

define Package/libunbound/description
  This package contains the Unbound library including 'libevent', 'libmnl', and
  'libpthread' to better handle large networks with heavy query loads. Options
  are available to custom trim Unbound for smaller targets.
endef

define Package/unbound-anchor
  $(call Package/unbound/Default)
  TITLE+= (root DSKEY)
  DEPENDS+= +unbound-daemon +libexpat
endef

define Package/unbound-anchor/description
  This package contains the Unbound anchor utility.
endef

define Package/unbound-checkconf
  $(call Package/unbound/Default)
  TITLE+= (config checker)
  DEPENDS+= +unbound-daemon
endef

define Package/unbound-checkconf/description
  This package contains the Unbound DNS configuration checker utility.
endef

define Package/unbound-control
  $(call Package/unbound/Default)
  TITLE+= (remote control)
  DEPENDS+= +unbound-daemon
endef

define Package/unbound-control/description
  This package contains the Unbound control utility.
endef

define Package/unbound-control-setup
  $(call Package/unbound/Default)
  TITLE+= (control setup)
  DEPENDS+= +unbound-control +openssl-util
endef

define Package/unbound-control-setup/description
  This package contains the Unbound control setup utility.
endef

define Package/unbound-host
  $(call Package/unbound/Default)
  TITLE+= (DNS lookup)
  DEPENDS+= +libunbound
endef

define Package/unbound-host/description
  This package contains the Unbound DNS lookup utility.
endef

define Package/libunbound/config
	if PACKAGE_libunbound
	config PACKAGE_libunbound_dnscrypt
		bool "Build with DNSCRYPT support."
		default n
	config PACKAGE_libunbound_ipset
		bool "Build with IPSET (libmnl) support."
		depends on !LINUX_2_6_36
		default y
	config PACKAGE_libunbound_libevent
		bool "Build with expanded network resource (libevent) support."
		depends on !LINUX_2_6_36
		default y
	config PACKAGE_libunbound_libpthread
		bool "Build with POSIX threading (libpthread) support."
		depends on !LINUX_2_6_36
		default y
	config PACKAGE_libunbound_nghttp2
		bool "Build with DNS over HTTPS support (nghttp2 framework)."
		default n
	config PACKAGE_libunbound_pythonmodule
		bool "Build with PYTHON module for prototyping and data analysis."
		default n
	config PACKAGE_libunbound_subnet
		bool "Build with SUBNET cache module support."
		default n
	config PACKAGE_libunbound_dnstap
		bool "Build with dnstap support."
		default n
	endif
endef

CONFIGURE_VARS += UNAME=Linux

CONFIGURE_ARGS += \
	--disable-dsa \
	--disable-gost \
	--enable-allsymbols \
	--enable-ecdsa \
	--enable-tfo-client \
	--enable-tfo-server \
	--with-libexpat="$(STAGING_DIR)/opt" \
	--with-ssl="$(STAGING_DIR)/opt" \
	--with-user=unbound \
	--with-run-dir=/opt/var/lib/unbound \
	--with-conf-file=/opt/var/lib/unbound/unbound.conf \
	--with-pidfile=/opt/var/run/unbound.pid \
    $(if $(CONFIG_PACKAGE_libunbound_dnscrypt), \
        --enable-dnscrypt --with-libsodium="$(STAGING_DIR)/opt",) \
    $(if $(CONFIG_PACKAGE_libunbound_ipset), \
        --enable-ipset --with-libmnl="$(STAGING_DIR)/opt",) \
    $(if $(CONFIG_PACKAGE_libunbound_libevent), \
        --enable-event-api --with-libevent="$(STAGING_DIR)/opt",--without-libevent) \
    $(if $(CONFIG_PACKAGE_libunbound_nghttp2), \
        --with-libnghttp2="$(STAGING_DIR)/opt",) \
    $(if $(CONFIG_PACKAGE_libunbound_libpthread), \
        --with-pthreads,--without-pthreads --without-solaris-threads) \
    $(if $(CONFIG_PACKAGE_libunbound_python),--with-pythonmodule,) \
    $(if $(CONFIG_PACKAGE_libunbound_subnet),--enable-subnet,) \
    $(if $(CONFIG_PACKAGE_libunbound_dnstap),--enable-dnstap,)

CONFIGURE_VARS += ac_cv_func_getentropy=no

define Package/unbound-daemon/conffiles
/opt/etc/unbound/unbound.conf
/opt/etc/unbound/unbound_ext.conf
/opt/etc/unbound/unbound_srv.conf
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/libunbound.{so*,a,la} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/unbound.h $(1)/opt/include/
ifneq ($(CONFIG_PACKAGE_libunbound_libevent),)
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/unbound-event.h $(1)/opt/include/
endif
endef

define Package/unbound-daemon/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/var/lib/unbound
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/sbin/unbound $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/unbound
	$(INSTALL_CONF) \
		$(PKG_INSTALL_DIR)/opt/var/lib/unbound/unbound.conf \
		$(1)/opt/etc/unbound/unbound.conf
	$(INSTALL_DATA) ./files/root.key $(1)/opt/etc/unbound/root.key
	$(INSTALL_CONF) ./files/unbound_ext.conf $(1)/opt/etc/unbound/unbound_ext.conf
	$(INSTALL_CONF) ./files/unbound_srv.conf $(1)/opt/etc/unbound/unbound_srv.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN)  ./files/S61unbound $(1)/opt/etc/init.d/
endef

define Package/libunbound/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libunbound.so.* $(1)/opt/lib/
endef

define Package/unbound-anchor/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/unbound-anchor $(1)/opt/sbin/
endef

define Package/unbound-checkconf/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/unbound-checkconf $(1)/opt/sbin/
endef

define Package/unbound-control/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/unbound-control $(1)/opt/sbin/
endef

define Package/unbound-control-setup/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/unbound-control-setup $(1)/opt/sbin/
endef

define Package/unbound-host/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/unbound-host $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,unbound-daemon))
$(eval $(call BuildPackage,libunbound))
$(eval $(call BuildPackage,unbound-anchor))
$(eval $(call BuildPackage,unbound-checkconf))
$(eval $(call BuildPackage,unbound-control))
$(eval $(call BuildPackage,unbound-control-setup))
$(eval $(call BuildPackage,unbound-host))


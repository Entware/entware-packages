#
# Copyright (C) 2010-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=unbound
PKG_VERSION:=1.9.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://nlnetlabs.nl/downloads/unbound
PKG_HASH:=1b55dd9170e4bfb327fb644de7bbf7f0541701149dff3adf1b63ffa785f16dfa

PKG_MAINTAINER:=Eric Luehrsen <ericluehrsen@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:nlnetlabs:unbound

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/unbound/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  USERID:=unbound:unbound
  TITLE:=Recursive DNS Server
  URL:=https://nlnetlabs.nl/projects/unbound/about
  DEPENDS:=+libopenssl +@OPENSSL_WITH_EC
endef

define Package/unbound-daemon
  $(call Package/unbound/Default)
  TITLE+= (daemon, light traffic)
  DEPENDS+= +libunbound
  VARIANT:=light
endef

define Package/unbound-daemon/description
  This package contains the Unbound daemon with basic includes
  necessary to meet the needs of UCI/LuCI configuration optoins.
endef

define Package/unbound-daemon-heavy
  $(call Package/unbound/Default)
  TITLE+= (daemon, heavy traffic)
  URL:=https://nlnetlabs.nl/documentation/unbound/howto-optimise
  DEPENDS+= +libunbound-heavy +libpthread +libevent2 +libevent2-pthreads
  VARIANT:=heavy
  PROVIDES:=unbound-daemon
endef

define Package/unbound-daemon-heavy/description
  This package contains the Unbound daemon including 'libevent' and
  'libpthread' to better handle large networks with heavy query loads.
endef

define Package/libunbound
  $(call Package/unbound/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Networking
  TITLE+= (library, light traffic)
  VARIANT:=light
  DEFAULT_VARIANT:=1
endef

define Package/libunbound/description
  This package contains the Unbound shared library with basic includes
  necessary to meet the needs of UCI/LuCI configuration optoins.
endef

define Package/libunbound-heavy
  $(call Package/unbound/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Networking
  TITLE+= (library, heavy traffic)
  URL:=https://nlnetlabs.nl/documentation/unbound/howto-optimise
  DEPENDS+= +libpthread +libevent2 +libevent2-pthreads
  VARIANT:=heavy
  PROVIDES:=libunbound
endef

define Package/libunbound-heavy/description
  This package contains the Unbound shared library including 'libevent' and
  'libpthread' to better handle large networks with heavy query loads.
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
	--with-pidfile=/opt/var/run/unbound.pid

ifeq ($(BUILD_VARIANT),heavy)
	CONFIGURE_ARGS += \
		--with-pthreads \
		--with-libevent="$(STAGING_DIR)/opt" \
		--enable-event-api
else
    CONFIGURE_ARGS += \
		--without-pthreads \
		--without-solaris-threads \
		--without-libevent
endif

CONFIGURE_VARS += ac_cv_func_getentropy=no

define Package/unbound-daemon/conffiles
/opt/etc/unbound/unbound.conf
/opt/etc/unbound/unbound_ext.conf
/opt/etc/unbound/unbound_srv.conf
endef

Package/unbound-daemon-heavy/conffiles = $(Package/unbound-daemon/conffiles)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/libunbound.{so*,a,la} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/unbound.h $(1)/opt/include/
ifeq ($(BUILD_VARIANT),heavy)
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/unbound-event.h $(1)/opt/include/
endif
endef

define Package/unbound-daemon/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/var/lib/unbound
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/sbin/unbound $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/unbound
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/var/lib/unbound/unbound.conf \
		$(1)/opt/etc/unbound/unbound.conf
	$(INSTALL_DATA) ./files/root.key $(1)/opt/etc/unbound/root.key
	$(INSTALL_DATA) ./files/unbound_ext.conf $(1)/opt/etc/unbound/unbound_ext.conf
	$(INSTALL_DATA) ./files/unbound_srv.conf $(1)/opt/etc/unbound/unbound_srv.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S61unbound $(1)/opt/etc/init.d/
endef

Package/unbound-daemon-heavy/install = $(Package/unbound-daemon/install)

define Package/libunbound/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libunbound.so.* $(1)/opt/lib/
endef

Package/libunbound-heavy/install = $(Package/libunbound/install)

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
$(eval $(call BuildPackage,unbound-daemon-heavy))
$(eval $(call BuildPackage,libunbound))
$(eval $(call BuildPackage,libunbound-heavy))
$(eval $(call BuildPackage,unbound-anchor))
$(eval $(call BuildPackage,unbound-checkconf))
$(eval $(call BuildPackage,unbound-control))
$(eval $(call BuildPackage,unbound-control-setup))
$(eval $(call BuildPackage,unbound-host))


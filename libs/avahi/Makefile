#
# Copyright (C) 2007-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# XXX Entware specifics: glib/gobject (glib2) added

include $(TOPDIR)/rules.mk

PKG_NAME:=avahi
PKG_VERSION:=0.8
PKG_RELEASE:=9

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/lathiat/avahi/releases/download/v$(PKG_VERSION) \
		https://avahi.org/download
PKG_HASH:=060309d7a333d38d951bc27598c677af1796934dbd98e1024e7ad8de798fedda

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:avahi:avahi

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/avahi/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=An mDNS/DNS-SD implementation
  URL:=http://www.avahi.org/
endef

define Package/avahi/Default/description
 Avahi is an mDNS/DNS-SD (aka RendezVous/Bonjour/ZeroConf)
 implementation (library). It facilitates
 service discovery on a local network -- this means that
 you can plug your laptop or computer into a network and
 instantly be able to view other people who you can chat with,
 find printers to print to or find files being shared.
 This kind of technology is already found in MacOS X
 (branded 'Rendezvous', 'Bonjour' and sometimes 'ZeroConf')
 and is very convenient.
endef

define Package/libavahi/Default
  $(call Package/avahi/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  PROVIDES:=libavahi
  DEPENDS:=+libpthread
endef

define Package/libavahi/description
$(call Package/avahi/Default/description)
 .
 The libavahi package contains the mDNS/DNS-SD shared libraries,
 used by other programs. Specifically, it provides
 libavahi-core and libavahi-common libraries.
endef

define Package/avahi-autoipd
  $(call Package/avahi/Default)
  SUBMENU:=IP Addresses and Names
  DEPENDS:=+libdaemon $(INTL_DEPENDS)
  TITLE:=IPv4LL network address configuration daemon
endef

define Package/avahi-autoipd/description
$(call Package/avahi/Default/description)
 .
 This package implements IPv4LL, "Dynamic Configuration of IPv4 Link-Local
 Addresses" (IETF RFC3927), a protocol for automatic IP address configuration
 from the link-local 169.254.0.0/16 range without the need for a central
 server. It is primarily intended to be used in ad-hoc networks which lack a
 DHCP server.
endef

define Package/avahi-dbus-daemon
  $(call Package/avahi/Default)
  PROVIDES:=avahi-daemon
  VARIANT:=dbus
  SUBMENU:=IP Addresses and Names
  DEPENDS:=+libavahi-dbus-support +libexpat +librt +libdaemon
  TITLE+= (daemon)
endef

define Package/avahi-nodbus-daemon
  $(call Package/avahi/Default)
  PROVIDES:=avahi-daemon
  VARIANT:=nodbus
  SUBMENU:=IP Addresses and Names
  DEPENDS:=+libavahi-nodbus-support +libexpat +librt +libdaemon
  TITLE+= (daemon)
  USERID:=avahi=105:avahi=105
endef

define Package/avahi-daemon/description
$(call Package/avahi/Default/description)
 .
 This package contains an mDNS/DNS-SD daemon.
endef

Package/avahi-dbus-daemon/description=$(Package/avahi-daemon/description)
Package/avahi-nodbus-daemon/description=$(Package/avahi-daemon/description)

define Package/avahi-daemon/conffiles
/opt/etc/avahi/avahi-daemon.conf
endef

Package/avahi-dbus-daemon/conffiles=$(Package/avahi-daemon/conffiles)
Package/avahi-nodbus-daemon/conffiles=$(Package/avahi-daemon/conffiles)

define Package/avahi-daemon-service-http
  $(call Package/avahi/Default)
  SUBMENU:=IP Addresses and Names
  DEPENDS:=+avahi-daemon
  TITLE:=Announce HTTP service
endef

define Package/avahi-daemon-service-http/description
$(call Package/avahi/Default/description)
 .
 This package contains the service definition for announcing HTTP service.
endef

define Package/avahi-daemon-service-http/conffiles
/opt/etc/avahi/services/http.service
endef

define Package/avahi-daemon-service-ssh
  $(call Package/avahi/Default)
  SUBMENU:=IP Addresses and Names
  DEPENDS:=+avahi-daemon
  TITLE:=Announce SSH service
endef

define Package/avahi-daemon-service-ssh/description
$(call Package/avahi/Default/description)
 .
 This package contains the service definition for announcing SSH service.
endef

define Package/avahi-daemon-service-ssh/conffiles
/opt/etc/avahi/services/ssh.service
endef

define Package/avahi-dnsconfd
  $(call Package/avahi/Default)
  SUBMENU:=IP Addresses and Names
  DEPENDS:=+libavahi +libdaemon +libpthread
  TITLE:=A Unicast DNS server using avahi-daemon
endef

define Package/avahi-dnsconfd/description
$(call Package/avahi/Default/description)
 .
 This package contains a Unicast DNS server from mDNS/DNS-SD configuration
 daemon, which may be used to configure conventional DNS servers using mDNS
 in a DHCP-like fashion. Especially useful on IPv6.
endef

define Package/libavahi-dbus-support
  $(call Package/libavahi/Default)
  VARIANT:=dbus
  DEPENDS:=+dbus $(INTL_DEPENDS)
  TITLE+= (D-Bus support)
endef

define Package/libavahi-nodbus-support
  $(call Package/libavahi/Default)
  VARIANT:=nodbus
  TITLE+= (No D-Bus)
  DEPENDS:=$(INTL_DEPENDS)
endef

define Package/libavahi-dbus-support/description
$(call Package/libavahi/description)
 .
 The libavahi-dbus-support package enables
 D-Bus support in avahi, needed to support
 the libavahi-client library and avahi-utils.
 .
 Selecting this package modifies the build configuration
 so that avahi packages are built with support for D-BUS enabled;
 it does not generate a separate binary of its own.
 It also automatically adds the D-Bus package to the build.
 libavahi-dbus-support is selected automatically if you select
 libavahi-client or avahi-utils.
endef

define Package/libavahi-nodbus-support/description
$(call Package/libavahi/description)
 .
 Selecting this package modifies the build configuration
 so that avahi packages are built without support for D-BUS enabled;
 it does not generate a separate binary of its own.
endef

define Package/libavahi-client
  $(call Package/avahi/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  VARIANT:=dbus
  DEPENDS:=+avahi-dbus-daemon
  TITLE+= (libavahi-client library)
endef

define Package/libavahi-client/description
$(call Package/avahi/Default/description)
 .
 This packages adds the libavahi-client library.
 It also automatically adds the required
 libavahi-dbus-support and the avahi-dbus-daemon packages.
 For more information please see the avahi documentation.
endef

define Package/libavahi-glib
  $(call Package/avahi/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  VARIANT:=dbus
  DEPENDS:=+glib2 +libavahi-client $(INTL_DEPENDS)
  TITLE+= (GLib Support)
endef

define Package/libavahi-glib/description
$(call Package/avahi/Default/description)
 .
 This packages adds the libavahi-glib library.
endef

#define Package/libavahi-gobject
#  $(call Package/avahi/Default)
#  SECTION:=libs
#  CATEGORY:=Libraries
#  VARIANT:=dbus
#  DEPENDS:=+libavahi-glib
#  TITLE+= (GLib GObject Support)
#endef

#define Package/libavahi-gobject/description
#$(call Package/avahi/Default/description)
# .
# This packages adds the libavahi-gobject library.
# It also automatically adds the required libavahi-glib package.
#endef

define Package/avahi-utils
  $(call Package/avahi/Default)
  SUBMENU:=IP Addresses and Names
  VARIANT:=dbus
  DEPENDS:=+libavahi-client +libgdbm
  TITLE+= (utilities)
endef

define Package/avahi-utils/description
$(call Package/avahi/Default/description)
 .
 This packages installs the following avahi utility programs:
 avahi-browse, avahi-publish, avahi-resolve, avahi-set-host-name.
 It also automatically adds the required libavahi-client package.
 For more information please see the avahi documentation.
endef

TARGET_CFLAGS += $(FPIC) -DGETTEXT_PACKAGE
TARGET_LDFLAGS += $(if $(INTL_FULL),-lintl)

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-introspection \
	--disable-qt3 \
	--disable-qt4 \
	--disable-qt5 \
	--disable-gtk \
	--disable-gtk3 \
	--disable-dbm \
	--enable-gdbm \
	--enable-libdaemon \
	--disable-libevent \
	--disable-python \
	--disable-python-dbus \
	--disable-mono \
	--disable-monodoc \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--disable-manpages \
	--disable-xmltoman \
	--disable-tests \
	--with-xml=expat \
	--with-distro=none \
	--with-avahi-user=nobody \
	--with-avahi-group=nogroup \
	--with-avahi-priv-access-group=nogroup \
	--with-autoipd-user=nobody \
	--with-autoipd-group=nogroup

ifeq ($(BUILD_VARIANT),dbus)
CONFIGURE_ARGS += \
	--enable-dbus \
	--with-dbus-system-address="unix:path=/opt/var/run/dbus/system_bus_socket"
else
CONFIGURE_ARGS += \
	--disable-dbus
endif

ifneq ($(CONFIG_PACKAGE_libavahi-glib),)
CONFIGURE_ARGS += \
	--enable-glib
else
CONFIGURE_ARGS += \
	--disable-glib
endif

#ifneq ($(CONFIG_PACKAGE_libavahi-gobject),)
#CONFIGURE_ARGS += \
#	--enable-gobject
#else
CONFIGURE_ARGS += \
	--disable-gobject
#endif

CONFIGURE_VARS+= \
	CFLAGS="$$$$CFLAGS -DNDEBUG -DDISABLE_SYSTEMD" \
	ac_cv_header_sys_capability_h=no

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libavahi-* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/* $(1)/opt/lib/pkgconfig/
endef

define Package/libavahi/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libavahi-{common,core}.so.* $(1)/opt/lib/
endef

define Package/libavahi-dbus-support/install
	$(call Package/libavahi/install,$(1))
	$(INSTALL_DIR) $(1)/opt/etc/dbus-1/system.d
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/dbus-1/system.d/* $(1)/opt/etc/dbus-1/system.d
endef

Package/libavahi-nodbus-support/install=$(Package/libavahi/install)

define Package/libavahi-client/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libavahi-client.so.* $(1)/opt/lib/
endef

define Package/libavahi-glib/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libavahi-glib.so.* $(1)/opt/lib/
endef

#define Package/libavahi-gobject/install
#	$(INSTALL_DIR) $(1)/opt/lib
#	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libavahi-gobject.so.* $(1)/opt/lib/
#endef

define Package/avahi-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
endef

define Package/avahi-autoipd/install
	$(INSTALL_DIR) $(1)/opt/etc/avahi
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/etc/avahi/avahi-autoipd.action $(1)/opt/etc/avahi/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/avahi-autoipd $(1)/opt/sbin/
#	$(INSTALL_DIR) $(1)/lib/netifd/proto
#	$(INSTALL_BIN) ./files/netifd-autoip.sh $(1)/lib/netifd/proto/autoip.sh
endef

define Package/avahi-daemon/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/avahi-daemon $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/avahi
	$(INSTALL_DATA) ./files/avahi-daemon.conf $(1)/opt/etc/avahi/
	# install empty service directory so that user knows where
	# to place custom service files
	$(INSTALL_DIR) $(1)/opt/etc/avahi/services
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S42avahi-daemon $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/var/run/dbus
endef

Package/avahi-dbus-daemon/install=$(Package/avahi-daemon/install)
Package/avahi-nodbus-daemon/install=$(Package/avahi-daemon/install)

define Package/avahi-daemon-service-http/install
	$(INSTALL_DIR) $(1)/opt/etc/avahi/services
	$(INSTALL_DATA) ./files/service-http $(1)/opt/etc/avahi/services/http.service
endef

define Package/avahi-daemon-service-ssh/install
	$(INSTALL_DIR) $(1)/opt/etc/avahi/services
	$(INSTALL_DATA) ./files/service-ssh $(1)/opt/etc/avahi/services/ssh.service
endef

define Package/avahi-dnsconfd/install
	$(INSTALL_DIR) $(1)/opt/etc/avahi
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/etc/avahi/avahi-dnsconfd.action $(1)/opt/etc/avahi/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/avahi-dnsconfd $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,libavahi-client))
$(eval $(call BuildPackage,libavahi-glib))
#$(eval $(call BuildPackage,libavahi-gobject))
$(eval $(call BuildPackage,avahi-utils))
$(eval $(call BuildPackage,libavahi-dbus-support))
$(eval $(call BuildPackage,libavahi-nodbus-support))
$(eval $(call BuildPackage,avahi-autoipd))
$(eval $(call BuildPackage,avahi-dbus-daemon))
$(eval $(call BuildPackage,avahi-nodbus-daemon))
$(eval $(call BuildPackage,avahi-daemon-service-http))
$(eval $(call BuildPackage,avahi-daemon-service-ssh))
$(eval $(call BuildPackage,avahi-dnsconfd))

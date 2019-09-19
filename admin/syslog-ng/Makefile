include $(TOPDIR)/rules.mk

PKG_NAME:=syslog-ng
PKG_VERSION:=3.23.1
PKG_RELEASE:=1

PKG_MAINTAINER:=Josef Schlehofer <josef.schlehofer@nic.cz>
PKG_LICENSE:=LGPL-2.1-or-later GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING LGPL.txt GPL.txt
PKG_CPE_ID:=cpe:/a:balabit:syslog-ng

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/balabit/syslog-ng/releases/download/$(PKG_NAME)-$(PKG_VERSION)/
PKG_HASH:=fb36cfc1982831f74143b77a924ee79714745b5e2b3ff59d086d09a77d0acd38

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:= \
	CONFIG_IPV6 \

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/syslog-ng
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=A powerful syslog daemon
  URL:=https://www.syslog-ng.com/products/open-source-log-management/
  DEPENDS:=+libpcre +glib2 +libopenssl +libpthread +librt +zlib +libdbi +libjson-c +libcurl +libuuid
endef

define Package/syslog-ng/description
  syslog-ng reads and logs messages to the system console, log
  files, other machines and/or users as specified by its
  configuration file.
endef

define Package/syslog-ng/conffiles
/opt/etc/syslog-ng.conf
/opt/etc/syslog-ng.d/
/opt/etc/scl.conf
endef

define Build/Configure
	$(SED) 's,-I/usr/include,,' $(PKG_BUILD_DIR)/configure
	$(Build/Configure/Default)
endef

CONFIGURE_ARGS +=  \
	--disable-snmp-dest \
	$(call autoconf_bool,CONFIG_IPV6,ipv6) \
	--disable-tcp-wrapper \
	--disable-spoof-source \
	--disable-sql \
	--disable-linux-caps \
	--with-jsonc=system \
	--enable-json=yes \
	--enable-http=yes \
	--disable-smtp \
	--disable-redis \
	--disable-dependency-tracking \
	--disable-python \
	--disable-geoip2 \
	--disable-java \
	--disable-java-modules \
	--with-librabbitmq-client=no \
	--with-mongoc=no

CONFIGURE_VARS += \
	LIBDBI_CFLAGS="-I$(STAGING_DIR)/opt/include"

TARGET_CPPFLAGS += \
	-I$(STAGING_DIR)/opt/include/eventlog

TARGET_LDFLAGS += -lrt

define Package/syslog-ng/install
	cd $(PKG_BUILD_DIR); make DESTDIR=$(1) install

	$(call libtool_remove_files,$(1)) # This removes .la files in folder (including subfolders) /usr/lib
	rm -rf $(1)/opt/lib/pkgconfig \
	$(1)/opt/lib/*.a \
	$(1)/opt/include \
	$(1)/opt/var

	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S01syslog-ng $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/syslog-ng.d
	$(INSTALL_DATA) ./files/syslog-ng.conf $(1)/opt/etc
	touch $(1)/opt/etc/syslog-ng.d/.keep

	$(INSTALL_BIN) ./files/logread $(1)/opt/sbin

	$(SED) 's,^#!.*python,#!/opt/bin/python,' \
		$(1)/opt/share/syslog-ng/tools/merge-grammar.py
	$(SED) 's,^#!.*awk,#!/opt/bin/awk,' \
		$(1)/opt/share/syslog-ng/include/scl/syslogconf/convert-syslogconf.awk
	$(SED) 's, /etc, /opt/etc,' \
		$(1)/opt/share/syslog-ng/include/scl/syslogconf/plugin.conf
endef

$(eval $(call BuildPackage,syslog-ng))

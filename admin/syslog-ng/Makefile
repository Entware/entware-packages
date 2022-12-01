include $(TOPDIR)/rules.mk

PKG_NAME:=syslog-ng
PKG_VERSION:=3.38.1
PKG_RELEASE:=1a

PKG_MAINTAINER:=Josef Schlehofer <josef.schlehofer@nic.cz>
PKG_LICENSE:=LGPL-2.1-or-later GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING LGPL.txt GPL.txt
PKG_CPE_ID:=cpe:/a:balabit:syslog-ng

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/syslog-ng/syslog-ng/releases/download/$(PKG_NAME)-$(PKG_VERSION)/
PKG_HASH:=5491f686d0b829b69b2e0fc0d66a62f51991aafaee005475bfa38fab399441f7

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_BUILD_DEPENDS:= \
	HOST_OS_MACOS:fakeuname/host \

PKG_CONFIG_DEPENDS:= \
	CONFIG_IPV6 \

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
ifeq ($(CONFIG_HOST_OS_MACOS),y)
    include ../../utils/fakeuname/fakeuname.mk
endif

define Package/syslog-ng
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=A powerful syslog daemon
  URL:=https://www.syslog-ng.com/products/open-source-log-management/
  DEPENDS:=+libpcre +glib2 +libopenssl +libpthread +librt +zlib +libdbi +libjson-c +libcurl +libuuid +SYSLOGNG_LOGROTATE:logrotate
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

define Package/syslog-ng/config
config SYSLOGNG_LOGROTATE
	bool "Logrotate support"
	depends on PACKAGE_syslog-ng
	default n
	help
	  It adds support for logrotate functionality.

config SYSLOGNG_LOGROTATE_MAXSIZE
	string "Maximum size of /var/log/messages log file"
	depends on SYSLOGNG_LOGROTATE
	default "1M"
	help
	  Log files are rotated when they grow bigger than defined size bytes.

config SYSLOGNG_LOGROTATE_ROTATE_COUNT
	int "Maximum rotation count for /var/log/messages log file"
	depends on SYSLOGNG_LOGROTATE
	default 1
	help
	  Log files are rotated count times before being removed or mailed to
	  the address specified in a mail directive. If count is 0, old
	  versions are removed rather than rotated.
endef

define Build/Configure
	$(SED) 's,-I/usr/include,,' $(PKG_BUILD_DIR)/configure
	$(Build/Configure/Default)
endef

LOGROTATE_MAXSIZE:=$(call qstrip,$(CONFIG_SYSLOGNG_LOGROTATE_MAXSIZE))
LOGROTATE_ROTATE:=$(call qstrip,$(CONFIG_SYSLOGNG_LOGROTATE_ROTATE_COUNT))

CONFIGURE_ARGS +=  \
	--disable-afsnmp \
	$(call autoconf_bool,CONFIG_IPV6,ipv6) \
	--disable-tcp-wrapper \
	--disable-spoof-source \
	--disable-sql \
	--disable-linux-caps \
	--with-jsonc=system \
	--enable-json=yes \
	--enable-http=yes \
	--disable-smtp \
	--disable-mqtt \
	--disable-redis \
	--disable-dependency-tracking \
	--disable-python \
	--disable-geoip2 \
	--disable-java \
	--disable-java-modules \
	--with-librabbitmq-client=no \
	--with-mongoc=no \
	--disable-manpages-install \
	--with-pidfile-dir=/opt/var/run/syslog-ng \
	--with-timezone-dir=/opt/share/zoneinfo

CONFIGURE_VARS += \
	$(if $(CONFIG_HOST_OS_MACOS),PATH=$(FAKEUNAME_PATH):$(PATH)) \
	LIBDBI_CFLAGS="-I$(STAGING_DIR)/opt/include"

define Package/syslog-ng/install
	cd $(PKG_BUILD_DIR); make DESTDIR=$(1) install

	$(call libtool_remove_files,$(1)) # This removes .la files in folder (including subfolders) /usr/lib
	rm -rf $(1)/opt/lib/pkgconfig \
	$(1)/opt/lib/*.a \
	$(1)/opt/include \
	$(1)/opt/man \
	$(1)/opt/var

	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S01syslog-ng $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/syslog-ng.d
	$(INSTALL_DATA) ./files/syslog-ng.conf $(1)/opt/etc
	touch $(1)/opt/etc/syslog-ng.d/.keep

	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) ./files/logread $(1)/opt/sbin

	$(INSTALL_DIR) $(1)/opt/share/syslog-ng/include/
	$(CP) -r ./files/scl $(1)/opt/share/syslog-ng/include/

	$(SED) 's,^#!.*python,#!/opt/bin/python,' \
		$(1)/opt/share/syslog-ng/tools/merge-grammar.py
	$(SED) 's,^#!.*awk,#!/opt/bin/awk,' \
		$(1)/opt/share/syslog-ng/include/scl/syslogconf/convert-syslogconf.awk
	$(SED) 's, /etc, /opt/etc,' \
		$(1)/opt/share/syslog-ng/include/scl/syslogconf/plugin.conf

ifneq ($(strip $(CONFIG_SYSLOGNG_LOGROTATE)),)
	$(INSTALL_DIR) $(1)/opt/etc/logrotate.d
	sed \
		-e 's#@MAXSIZE@#$(LOGROTATE_MAXSIZE)#g' \
		-e 's#@ROTATE@#$(LOGROTATE_ROTATE)#g' \
		./files/syslog-ng.logrotate > $(1)/opt/etc/logrotate.d/syslog-ng.conf
endif
endef

$(eval $(call BuildPackage,syslog-ng))

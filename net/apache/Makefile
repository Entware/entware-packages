#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=apache
PKG_VERSION:=2.4.37
PKG_RELEASE:=2
PKG_SOURCE_NAME:=httpd

PKG_SOURCE:=$(PKG_SOURCE_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@APACHE/httpd/
PKG_HASH:=3498dc5c6772fac2eb7307dc7963122ffe243b5e806e0be4fb51974ff759d726

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>
PKG_LICENSE:=Apache License
PKG_CPE_ID:=cpe:/a:apache:http_server

PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:= \
	CONFIG_APACHE_HTTP2

ADDITIONAL_MODULES:=
ifeq ($(CONFIG_APACHE_HTTP2),y)
  ADDITIONAL_MODULES += --enable-http2
endif
ifneq ($(CONFIG_APACHE_HTTP2),y)
  ADDITIONAL_MODULES += --enable-http2=no
endif

include $(INCLUDE_DIR)/package.mk

define Package/apache/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=The Apache Web Server
  URL:=https://httpd.apache.org/
endef

define Package/apache/Default/description
 The Apache Web Server is a powerful and flexible HTTP/1.1 compliant
 web server.  Originally designed as a replacement for the NCSA HTTP
 Server, it has grown to be the most popular web server on the Internet.
endef

define Package/apache/config
  source "$(SOURCE)/Config.in"
endef

define Package/apache
$(call Package/apache/Default)
  DEPENDS:=+libapr +libaprutil +libpcre +libopenssl +unixodbc +zlib +APACHE_HTTP2:libnghttp2 +libxml2
endef

define Package/apache/description
$(call Package/apache/Default/description)
 .
 This package contains the Apache web server and utility programs.
endef

define Package/apache/conffiles
/opt/etc/apache/httpd.conf
/opt/etc/apache/extra/httpd-autoindex.conf
/opt/etc/apache/extra/httpd-dav.conf
/opt/etc/apache/extra/httpd-default.conf
/opt/etc/apache/extra/httpd-info.conf
/opt/etc/apache/extra/httpd-languages.conf
/opt/etc/apache/extra/httpd-manual.conf
/opt/etc/apache/extra/httpd-mpm.conf
/opt/etc/apache/extra/httpd-multilang-errordoc.conf
/opt/etc/apache/extra/httpd-ssl.conf
/opt/etc/apache/extra/httpd-userdir.conf
/opt/etc/apache/extra/httpd-vhosts.conf
/opt/etc/apache/magic
/opt/etc/apache/mime.types
endef

define Package/apache-icons
$(call Package/apache/Default)
  TITLE:=Icons from Apache
  DEPENDS:=apache
endef

define Package/apache-icons/description
$(call Package/apache/Default/description)
 .
 This package contains the icons from Apache.
endef

TARGET_CFLAGS += $(FPIC) -Wno-error
TARGET_CPPFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
TARGET_LDFLAGS += -lpthread

TARGET_LDFLAGS += -L$(STAGING_DIR)/opt/lib/libiconv-full/lib -liconv

define Build/Configure
	$(call Build/Configure/Default, \
		--with-apr="$(STAGING_DIR)/opt/bin/apr-1-config" \
		--with-apr-util="$(STAGING_DIR)/opt/bin/apu-1-config" \
		--with-pcre="$(STAGING_DIR)/opt/bin/pcre-config" \
		$(ADDITIONAL_MODULES) \
		--enable-http \
		--with-crypto \
		--with-sqlit3="$(STAGING_DIR)/opt" \
		--with-openssl="$(STAGING_DIR)/opt" \
		--enable-ssl \
		--enable-proxy \
		--disable-md \
		--disable-disk-cache \
		--enable-maintainer-mode \
		--with-mpm=prefork \
		--with-mpm=worker \
		--enable-mime-magic \
		--without-suexec-bin \
		--sysconfdir=/opt/etc/apache \
		ap_cv_void_ptr_lt_long=no \
		logfiledir="/opt/var/log" \
		runtimedir="/opt/var/run" \
		EXTRA_LIBS="-ldl -lpthread -lcrypto -lrt -lssl" \
	)
endef

define Build/InstallDev
	rm -rf	$(PKG_INSTALL_DIR)/opt/man/ \
		$(PKG_INSTALL_DIR)/opt/share/manual/
	# if you need docs take a look into the build-dir :)
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP)   $(PKG_INSTALL_DIR)/opt/etc/* \
		$(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/include/apache
	$(CP)	$(PKG_INSTALL_DIR)/opt/include/* \
		$(1)/opt/include/apache
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP)   $(PKG_INSTALL_DIR)/opt/lib/httpd.exp \
		$(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP)   $(PKG_INSTALL_DIR)/opt/sbin/* \
		$(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/share
	$(CP)   $(PKG_INSTALL_DIR)/opt/share/* \
		$(1)/opt/share
endef

define Package/apache/install
	$(INSTALL_DIR) $(1)/opt/sbin
	# we don't need apxs on the router, it's just for building apache modules.
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{ab,dbmmanage,htdbm,htdigest,htpasswd,httxt2dbm,logresolve} $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/{apachectl,checkgid,envvars,envvars-std,htcacheclean,httpd,rotatelogs} $(1)/opt/sbin/
	$(SED) 's,$(STAGING_DIR_HOST)/bin/perl,/opt/bin/perl,g' $(1)/opt/sbin/dbmmanage
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/httpd.exp $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/share
	$(CP) $(PKG_INSTALL_DIR)/opt/share/{error,htdocs,cgi-bin,build} $(1)/opt/share/
	$(INSTALL_DIR) $(1)/opt/etc/apache
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/apache/{httpd.conf,magic,mime.types,extra} $(1)/opt/etc/apache/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(LN) -s /opt/sbin/apachectl $(1)/opt/etc/init.d/S80apache
endef

define Package/apache-icons/install
	$(INSTALL_DIR) $(1)/opt/share
	$(CP) $(PKG_INSTALL_DIR)/opt/share/icons $(1)/opt/share/
endef

$(eval $(call BuildPackage,apache))
$(eval $(call BuildPackage,apache-icons))

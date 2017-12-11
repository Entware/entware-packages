#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# conffile + all files from /opt/lib/sqid added

include $(TOPDIR)/rules.mk

PKG_NAME:=squid
PKG_VERSION:=3.5.27
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=Marko Ratkaj <marko.ratkaj@sartura.hr>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://www3.us.squid-cache.org/Versions/v3/3.5/ \
	http://www2.pl.squid-cache.org/Versions/v3/3.5/ \
	http://www.squid-cache.org/Versions/v3/3.5/
PKG_HASH:=5ddb4367f2dc635921f9ca7a59d8b87edb0412fa203d1543393ac3c7f9fef0ec

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/squid/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  URL:=http://www.squid-cache.org/
  MENU:=1
endef

define Package/squid
  $(call Package/squid/Default)
  DEPENDS:=+libopenssl +libpthread +librt +libltdl +libstdcpp
  TITLE:=full-featured Web proxy cache
endef

define Package/squid/description
  Squid is a caching proxy for the Web supporting HTTP, HTTPS, FTP, and more.
  It reduces bandwidth and improves response times by caching and reusing
  frequently-requested web pages.
endef

define Package/squid-mod-cachemgr
  $(call Package/squid/Default)
  DEPENDS:=squid
  TITLE:=Web based proxy manager and reporting tool
endef

define Package/squid/conffiles
/opt/etc/squid/squid.conf
endef

CONFIGURE_ARGS += \
	--config-cache \
	--datadir=/opt/share/squid \
	--libexecdir=/opt/lib/squid \
	--sysconfdir=/opt/etc/squid \
	--enable-shared \
	--disable-static \
	--enable-icmp \
	--enable-delay-pools \
	--enable-icap-client \
	--enable-kill-parent-hack \
	--disable-snmp \
	--enable-ssl \
	--enable-ssl-crtd \
	--enable-cache-digests \
	--enable-linux-netfilter \
	--disable-unlinkd \
	--enable-x-accelerator-vary \
	--disable-translation \
	--disable-auto-locale \
	--with-dl \
	--with-pthreads \
	--without-expat \
	--without-libxml2 \
	--without-gnutls \
	--without-nettle \
	--with-openssl=$(STAGING_DIR)/opt \
	--enable-epoll \
	--with-maxfd=4096 \
	--disable-external-acl-helpers \
	--disable-auth-negotiate \
	--disable-auth-ntlm \
	--disable-auth-digest \
	--disable-auth-basic \
	--disable-arch-native \
	--with-krb5-config=no \
	--without-mit-krb5 \
	--without-libcap \
	--without-netfilter-conntrack

CONFIGURE_VARS += \
	ac_cv_header_linux_netfilter_ipv4_h=yes \
	ac_cv_epoll_works=yes \
	squid_cv_gnu_atomics=no

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/lib all
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		install
endef

define Package/squid/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/squid $(1)/opt/sbin/

	$(INSTALL_DIR) $(1)/opt/lib/squid
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/squid/* $(1)/opt/lib/squid
	$(RM) $(1)/opt/lib/squid/*.cgi $(1)/opt/lib/squid/*.sh $(1)/opt/lib/squid/*.pl

	$(INSTALL_DIR) $(1)/opt/etc/squid
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/squid/mime.conf $(1)/opt/etc/squid/
	$(INSTALL_CONF) ./files/squid.conf $(1)/opt/etc/squid/

	$(INSTALL_DIR) $(1)/opt/etc/init.d/
	$(INSTALL_BIN) ./files/S22squid $(1)/opt/etc/init.d/

	$(INSTALL_DIR) $(1)/opt/share/squid/icons/
	$(CP) $(PKG_INSTALL_DIR)/opt/share/squid/icons/* $(1)/opt/share/squid/icons/

	$(INSTALL_DIR) $(1)/opt/share/squid/errors/templates/
	$(CP) $(PKG_INSTALL_DIR)/opt/share/squid/errors/templates/* $(1)/opt/share/squid/errors/templates/
endef

define Package/squid-mod-cachemgr/install
	$(INSTALL_DIR) $(1)/opt/share/www/cgi-bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/squid/cachemgr.cgi $(1)/opt/share/www/cgi-bin/
endef

$(eval $(call BuildPackage,squid))
$(eval $(call BuildPackage,squid-mod-cachemgr))

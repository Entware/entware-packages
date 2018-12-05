#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openldap
PKG_VERSION:=2.4.46
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=https://gpl.savoirfairelinux.net/pub/mirrors/openldap/openldap-release/ \
	http://mirror.eu.oneandone.net/software/openldap/openldap-release/ \
	http://mirror.switch.ch/ftp/software/mirror/OpenLDAP/openldap-release/ \
	https://www.openldap.org/software/download/OpenLDAP/openldap-release/
PKG_HASH:=9a90dcb86b99ae790ccab93b7585a31fbcbeec8c94bf0f7ab0ca0a87ea0c4b2d
PKG_LICENSE:=OLDAP-2.8
PKG_LICENSE_FILES:=LICENSE

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/openldap/Default
  TITLE:=LDAP implementation
  URL:=http://www.openldap.org/
  MAINTAINER:=W. Michael Petullo <mike@flyn.org>
endef

define Package/openldap/Default/description
	OpenLDAP Software is an open source implementation of the
	Lightweight Directory Access Protocol (LDAP).
endef

define Package/libopenldap
  $(call Package/openldap/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libopenssl +libsasl2 +libpthread
  TITLE+= (libraries)
endef

define Package/libopenldap/description
	$(call Package/openldap/Default/description)
	This package contains the shared LDAP client libraries, needed by other programs.
endef

define Package/libopenldap/conffiles
/opt/etc/openldap/ldap.conf
endef

define Package/openldap-utils
  $(call Package/openldap/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libopenldap
  TITLE+= (utilities)
endef

define Package/openldap-utils/description
	$(call Package/openldap/Default/description)
	This package contains client programs required to access LDAP servers.
endef

define Package/openldap-server
  $(call Package/openldap/Default)
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libopenldap +libuuid
  TITLE+= (server)
endef

define Package/openldap-server/description
	$(call Package/openldap/Default/description)
	This package contains server programs required to provide LDAP services.
endef

define Package/openldap-server/conffiles
/opt/etc/openldap/slapd.conf
endef

TARGET_CFLAGS += $(FPIC) -lpthread \
	-DURANDOM_DEVICE=\\\"/dev/urandom\\\"

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-debug \
	--enable-dynamic \
	--enable-syslog \
	--disable-local \
	--disable-slurpd \
	--with-cyrus-sasl \
	--without-fetch \
	--with-threads \
	--with-tls \
	--with-yielding_select="yes" \
	--without-threads \
	--enable-null \
	--disable-bdb \
	--disable-hdb \
	--disable-monitor \
	--disable-relay

CONFIGURE_VARS += \
	ol_cv_lib_icu="no" \
	ac_cv_func_memcmp_working=yes

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		HOSTCC="$(HOSTCC)" \
		depend all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/{lber,ldap}*.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib{lber,ldap}*.{a,so*} $(1)/opt/lib/
endef

define Package/libopenldap/install
	$(INSTALL_DIR) $(1)/opt/etc/openldap
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/openldap/ldap.conf $(1)/opt/etc/openldap/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib{lber,ldap}*.so.* $(1)/opt/lib/
endef

define Package/openldap-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ldap* $(1)/opt/bin/
endef

define Package/openldap-server/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S58slapd $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/openldap/schema
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/openldap/schema/* $(1)/opt/etc/openldap/schema/
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/openldap/slapd.conf $(1)/opt/etc/openldap/
	$(INSTALL_DIR) $(1)/opt/sbin
	# XXX: OpenLDAP installs slapd into libexecdir, not sbindir:
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/slapd $(1)/opt/sbin/
	# XXX: switch default backend to ldif, since bdb is disabled
	$(SED) 's|^\(database\)\([ \t]\+\)bdb|\1\2ldif|g' \
	    -e 's|^\(index\)|#\1|g' \
	    $(1)/opt/etc/openldap/slapd.conf
endef

$(eval $(call BuildPackage,libopenldap))
$(eval $(call BuildPackage,openldap-utils))
$(eval $(call BuildPackage,openldap-server))

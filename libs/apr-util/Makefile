#
# Copyright (C) 2007-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=apr-util
PKG_VERSION:=1.6.1
PKG_RELEASE:=7

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@APACHE/apr/
PKG_HASH:=d3e12f7b6ad12687572a3a39475545a072608f4ba03a6ce8a3778f607dd0035b
PKG_MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_CPE_ID:=cpe:/a:apache:apr-util

PKG_CONFIG_DEPENDS := \
	CONFIG_PACKAGE_libaprutil-crypto-openssl \
	CONFIG_PACKAGE_libaprutil-dbd-mysql \
	CONFIG_PACKAGE_libaprutil-dbd-odbc \
	CONFIG_PACKAGE_libaprutil-dbd-pgsql \
	CONFIG_PACKAGE_libaprutil-dbd-sqlite3 \
	CONFIG_PACKAGE_libaprutil-dbm-gdbm \
	CONFIG_PACKAGE_libaprutil-ldap

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/libaprutil/Default
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=http://apr.apache.org/
endef

define Package/libaprutil
$(call Package/libaprutil/Default)
  DEPENDS:=+libapr +libexpat +libuuid $(ICONV_DEPENDS)
  TITLE:=Apache Portable Runtime Utility Library
endef

TARGET_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE

CONFIGURE_ARGS += \
	--with-apr="$(STAGING_DIR)/opt/bin/apr-1-config" \
	--with-expat="$(STAGING_DIR)/opt" \
	--with-iconv="$(ICONV_PREFIX)" \
	--without-sqlite2

ifneq ($(CONFIG_PACKAGE_libaprutil-crypto-openssl),)
CONFIGURE_ARGS += --with-crypto --with-openssl="$(STAGING_DIR)/opt"
else
CONFIGURE_ARGS += --without-crypto
endif

ifneq ($(CONFIG_PACKAGE_libaprutil-dbd-mysql),)
CONFIGURE_ARGS += --with-mysql="$(STAGING_DIR)/opt"
else
CONFIGURE_ARGS += --without-mysql
endif

ifneq ($(CONFIG_PACKAGE_libaprutil-dbd-odbc),)
CONFIGURE_ARGS += --with-odbc="$(STAGING_DIR)/opt"
else
CONFIGURE_ARGS += --without-odbc
endif

ifneq ($(CONFIG_PACKAGE_libaprutil-dbd-pgsql),)
CONFIGURE_ARGS += --with-pgsql="$(STAGING_DIR)/opt"
else
CONFIGURE_ARGS += --without-pgsql
endif

ifneq ($(CONFIG_PACKAGE_libaprutil-dbd-sqlite3),)
CONFIGURE_ARGS += --with-sqlite3="$(STAGING_DIR)/opt"
else
CONFIGURE_ARGS += --without-sqlite3
endif

ifneq ($(CONFIG_PACKAGE_libaprutil-dbm-gdbm),)
CONFIGURE_ARGS += --with-gdbm="$(STAGING_DIR)/opt"
else
CONFIGURE_ARGS += --without-gdbm
endif

ifneq ($(CONFIG_PACKAGE_libaprutil-ldap),)
CONFIGURE_ARGS += \
	--with-ldap \
	--with-ldap-include="$(STAGING_DIR)/opt/include" \
	--with-ldap-lib="$(STAGING_DIR)/opt/lib"
else
CONFIGURE_ARGS += \
	--without-ldap
endif

CONFIGURE_VARS += \
	ac_cv_path_ODBC_CONFIG= \
	apu_cv_weak_symbols=yes \
	APR_BUILD_DIR="$(STAGING_DIR)/opt/share/build-1"

# Entware specific: "explicit_bzero" since glibc-2.25
ifeq ($(CONFIG_LINUX_2_6_36),)
CONFIGURE_VARS += \
	apu_cv_explicit_bzero=yes
endif

define Package/libaprutil/install/driver
	$(INSTALL_DIR) $(1)/opt/lib/apr-util-1
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/apr-util-1/apr_$(2)*.so \
					$(1)/opt/lib/apr-util-1
endef

define Package/libaprutil/Driver
define Package/libaprutil-$(subst _,-,$(1))
$(call Package/libaprutil/Default)
  TITLE:=libaprutil - $(2) driver
  DEPENDS:=libaprutil $(patsubst +%,+PACKAGE_libaprutil-$(subst _,-,$(1)):%,$(3))
endef
define Package/libaprutil-$(subst _,-,$(1))/install
$(foreach d,$(1),$(call Package/libaprutil/install/driver,$$(1),$(d));)
endef
$$(eval $$(call BuildPackage,libaprutil-$(subst _,-,$(1))))
endef

# PKG_CONFIG_DEPENDS trigger configure, but the compile afterward may be
# incomplete if the build directory is not cleaned before. This is not a
# general observation, yet it is valid for apr-util :/
define Build/Compile
	$(call Build/Compile/Default,clean all)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/include/apr-1 \
		$(1)/opt/lib/apr-util-1 $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/apu-1-config $(1)/opt/bin
	$(SED) '/^prefix=\|^exec_prefix=/s|/opt|$(STAGING_DIR)/opt|' $(1)/opt/bin/apu-1-config
	$(SED) '/^bindir=/s|/opt|$$$${prefix}|' $(1)/opt/bin/apu-1-config
	$(CP) $(PKG_INSTALL_DIR)/opt/include/apr-1/* $(1)/opt/include/apr-1
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/apr-util-1/apr_*.{a,so} \
			$(1)/opt/lib/apr-util-1 2>/dev/null || :
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libaprutil-1.{a,so*} \
						$(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/apr-util-1.pc \
					$(1)/opt/lib/pkgconfig
	$(INSTALL_DIR) $(2)/bin
	$(LN) ../../opt/bin/apu-1-config $(2)/bin/apu-1-config
endef

define Package/libaprutil/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libaprutil-1.so.* $(1)/opt/lib
endef

$(eval $(call BuildPackage,libaprutil))
$(eval $(call Package/libaprutil/Driver,crypto_openssl,OpenSSL,+libopenssl))
$(eval $(call Package/libaprutil/Driver,dbd_mysql,MySQL,+libmariadb))
$(eval $(call Package/libaprutil/Driver,dbd_odbc,ODBC,+unixodbc))
$(eval $(call Package/libaprutil/Driver,dbd_pgsql,PostgreSQL,+libpq))
$(eval $(call Package/libaprutil/Driver,dbd_sqlite3,SQLite3,+libsqlite3))
$(eval $(call Package/libaprutil/Driver,dbm_gdbm,GDBM dbm,+libgdbm))
$(eval $(call Package/libaprutil/Driver,ldap,LDAP,+libopenldap))

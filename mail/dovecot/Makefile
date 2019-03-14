#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: downgraded form 2.2.15 as it's broken for some archs.
# LDAP is always turned on. MySQL variant added.

include $(TOPDIR)/rules.mk

PKG_NAME:=dovecot
PKG_VERSION:=2.2.15
PKG_RELEASE:=1b

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.dovecot.org/releases/2.2
PKG_HASH:=d10e7769e2367d635c93fd6589efdd05f2e3acf13c7911a40167faedf23c399f
PKG_LICENSE:=LGPL-2.1 MIT BSD-3-Clause Unique
PKG_LICENSE_FILES:=COPYING COPYING.LGPL COPYING.MIT

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DEPENDS:=libiconv

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/dovecot/Default
  SECTION:=mail
  CATEGORY:=Mail
  DEPENDS:=+libopenldap +libopenssl +librt +zlib +libbz2 +libcap $(ICONV_DEPENDS)
  TITLE:=An IMAP and POP3 daemon
  MAINTAINER:=Peter Wagner <tripolar@gmx.at>
  URL:=http://www.dovecot.org/
  USERID:=dovecot=59:dovecot=59
endef

define Package/dovecot/Default/description
 Dovecot is a program which provides POP3 and IMAP services.
endef

#define Package/dovecot/config
#        menu "Select dovecot build options"
#                depends on PACKAGE_dovecot
#                config DOVECOT_LDAP
#                        bool "LDAP support"
#                        default n
#                        help
#                          Implements LDAP support in dovecot.
#        endmenu
#endef

CONFIG_DOVECOT_LDAP=y

define Package/dovecot
$(call Package/dovecot/Default)
  TITLE+= (without MySQL support)
  VARIANT:=nomysql
endef

define Package/dovecot-mysql
$(call Package/dovecot/Default)
  DEPENDS+= +libmysqlclient
  TITLE+= (with MySQL support)
  VARIANT:=mysql
endef

define Package/dovecot/description
$(call Package/dovecot/Default/description)
 This package is built without MySQL support.
endef

define Package/dovecot-mysql/description
$(call Package/dovecot/Default/description)
 This package is built with MySQL support.
endef

CONFIGURE_ARGS += \
	--without-gssapi \
	--without-pam \
	--with-moduledir=/opt/lib/dovecot/modules \
	--with-notify=dnotify \
	--without-lzma \
	--without-lz4

ifeq ($(BUILD_VARIANT),mysql)
	CONFIGURE_ARGS += \
	--with-sql=plugin --with-mysql
endif

ifneq ($(strip $(CONFIG_DOVECOT_LDAP)),)
  CONFIGURE_ARGS+= \
	--with-ldap=yes
else
  CONFIGURE_ARGS+= \
	--with-ldap=no
endif

CONFIGURE_VARS += \
	RPCGEN= \
	i_cv_signed_size_t=no \
	i_cv_signed_time_t=no \
	i_cv_gmtime_max_time_t=32 \
	i_cv_mmap_plays_with_write=yes \
	i_cv_fd_passing=yes \
	i_cv_c99_vsnprintf=yes \
	lib_cv_va_copy=yes \
	lib_cv_va_copy=yes \
	lib_cv___va_copy=yes \
	lib_cv_va_val_copy=yes

TARGET_LDFLAGS += -Wl,--allow-multiple-definition

define Package/dovecot/install
	$(INSTALL_DIR)  $(1)/opt/etc/init.d \
			$(1)/opt/etc/dovecot \
			$(1)/opt/share/doc/dovecot/example-config \
			$(1)/opt/lib/dovecot \
			$(1)/opt/bin \
			$(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/dovecot/* $(1)/opt/etc/dovecot/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/dovecot/* $(1)/opt/lib/dovecot/
	$(CP) $(PKG_INSTALL_DIR)/opt/share/doc/dovecot/example-config $(1)/opt/share/doc/dovecot/example-config
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/doveconf $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/* $(1)/opt/sbin/
	$(INSTALL_BIN) ./files/S90dovecot $(1)/opt/etc/init.d/
	rm  $(1)/opt/lib/dovecot/dovecot-config
	find $(1)/opt/lib/dovecot/ -name "*.a" -o -name "*.la" | xargs rm
endef

Package/dovecot-mysql/install = $(Package/dovecot/install)

$(eval $(call BuildPackage,dovecot))
$(eval $(call BuildPackage,dovecot-mysql))

#
# Copyright (C) 2007-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=loudmouth
PKG_VERSION:=1.5.3
PKG_RELEASE:=1

PKG_MAINTAINER:=W. Michael Petullo <mike@flyn.org>

PKG_SOURCE:=loudmouth-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://mcabber.com/files/loudmouth
PKG_MD5SUM:=0db0ce1c5a57f81b5736be8bd2217a82
PKG_BUILD_DIR:=$(BUILD_DIR)/loudmouth-$(PKG_VERSION)

PKG_INSTALL:=1

PKG_BUILD_DEPENDS:=libopenssl

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/loudmouth
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+glib2 +libopenssl +libidn
  TITLE:=loudmouth
  URL:=https://github.com/mcabber/loudmouth
endef

define Package/loudmouth/description
  Lightweight and easy-to-use C library for programming with the Jabber protocol
endef

CONFIGURE_VARS += \
	ac_cv_path_KRB5CONFIG=no \
	LIBS="-liconv -lgobject-2.0 -lintl"

CONFIGURE_ARGS += \
	--with-compile-warnings=no \
	--with-ssl=openssl

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/loudmouth-1.0/ \
		$(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.so* \
		$(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc \
		$(1)/opt/lib/pkgconfig/
endef

define Package/loudmouth/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.so* \
		$(1)/opt/lib/
endef

$(eval $(call BuildPackage,loudmouth))

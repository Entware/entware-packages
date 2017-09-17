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

PKG_LICENSE:=LGPLv2.1
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_MIRROR_HASH:=46a3f1a13a6ec5ff5377c028ce25bc723ab86247af40e686aa2b24718a5cd0d1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/mcabber/loudmouth.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/loudmouth
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+glib2 +libopenssl
  TITLE:=loudmouth
  URL:=https://github.com/mcabber/loudmouth
endef

define Package/loudmouth/description
  Lightweight and easy-to-use C library for programming with the Jabber protocol
endef

CONFIGURE_ARGS += \
	--with-ssl=openssl \
	--with-idn=no

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

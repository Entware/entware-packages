#
# Copyright (C) 2010-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libmms
PKG_VERSION:=0.6.4
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/libmms
PKG_MD5SUM:=d6b665b335a6360e000976e770da7691
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_LICENSE:=LGPLv2.1
PKG_LICENSE_FILES:=COPYING.LIB

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/libmms
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+glib2
  TITLE:=MMS stream protocol library
  URL:=http://libmms.sourceforge.net
  DEPENDS:=$(ICONV_DEPENDS)
endef

define Package/libmms/description
	LibMMS is a common library for parsing mms:// and mmsh:// type network streams.
	These are commonly used to stream Windows Media Video content over the web.
	LibMMS itself is only for receiving MMS stream,
	it doesn't handle sending at all.
endef

TARGET_CFLAGS += $(FPIC)
TARGET_LDFLAGS += $(if $(ICONV_FULL),-liconv)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libmms $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmms.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc \
		$(1)/opt/lib/pkgconfig
endef

define Package/libmms/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmms.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libmms))

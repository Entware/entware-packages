#
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=fcgi
PKG_VERSION:=2.4.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.fastcgi.com/dist/
PKG_HASH:=66fc45c6b36a21bf2fbbb68e90f780cc21a9da1fffbae75e76d2b4402d3f05b9

PKG_FIXUP:=libtool-ucxx

PKG_MAINTAINER:=Jacob Siverskog <jacob@teenageengineering.com>

PKG_INSTALL:=1

#include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/fcgi/Default
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=http://www.fastcgi.com/
endef

define Package/fcgi
  $(call Package/fcgi/Default)
  MENU:=1
  DEPENDS:= +libpthread
  TITLE:=Shared library of FastCGI
endef

define Package/fcgixx
  $(call Package/fcgi/Default)
  DEPENDS:=fcgi +libstdcpp
  TITLE:=Shared library of FastCGI++
endef

define Package/fcgi/description
 FastCGI is a language independent, scalable, open extension to
 CGI that provides high performance without the limitations of
 server specific APIs.
endef

TARGET_CFLAGS += $(FPIC)

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \

CONFIGURE_VARS += \
	LIBS="-lm" \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/fastcgi.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/fcgi{app,_config,misc,o,os,_stdio}.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfcgi{,++}.{a,so*} $(1)/opt/lib/
endef

define Package/fcgi/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/cgi-fcgi $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfcgi.so.* $(1)/opt/lib/
endef

define Package/fcgixx/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfcgi++.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,fcgi))
$(eval $(call BuildPackage,fcgixx))

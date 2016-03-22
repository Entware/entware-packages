#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsearpc
PKG_VERSION:=3.0.7
PKG_RELEASE=1
PKG_LICENSE:=GPL-3.0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/haiwen/libsearpc.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=13f49676cc5444d3a9e9397310f7d322fb7d887f
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/libsearpc
    SECTION:=libs
    CATEGORY:=Libraries
    TITLE:=Seafile RPC Library
    MAINTAINER:=Gergely Kiss <mail.gery@gmail.com>
    URL:=http://seafile.com/
    DEPENDS:=+glib2 +jansson +python $(ICONV_DEPENDS)
endef

define Package/libsearpc/description
    Searpc is a simple C language RPC framework based on GObject system.
    Searpc handles the serialization/deserialization part of RPC,
    the transport part is left to users.
endef

CONFIGURE_ARGS += --enable-compile-demo=no \
		    --disable-server-pkg

TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/opt/lib -liconv

include $(INCLUDE_DIR)/host-build.mk

define Host/Configure
endef

define Host/Compile
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR)/host/bin
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/lib/searpc-codegen.py $(STAGING_DIR)/host/bin/
endef

$(eval $(call HostBuild))

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/{bin,include}
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsearpc.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/searpc* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libsearpc.pc $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/searpc-codegen.py $(1)/opt/bin/
endef

define Package/libsearpc/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/python2.7/site-packages
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsearpc.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/python2.7/site-packages/pysearpc $(1)/opt/lib/python2.7/site-packages/
endef

$(eval $(call BuildPackage,libsearpc))

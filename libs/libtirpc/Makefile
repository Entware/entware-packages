#
# Copyright (C) 2006-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libtirpc
PKG_VERSION:=1.1.4
PKG_RELEASE:=2

PKG_SOURCE_URL:=@SF/libtirpc
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_HASH:=2ca529f02292e10c158562295a1ffd95d2ce8af97820e3534fe1b0e3aec7561d

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=BSD-3-Clause

PKG_FIXUP:=autoreconf
PKG_REMOVE_FILES:=autogen.sh aclocal.m4
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/libtirpc
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Library TI RPC for RPC bindings
  URL:=http://libtirpc.sourceforge.net/
  DEPENDS:=+libpthread
endef

CONFIGURE_ARGS += --disable-gssapi
HOST_CONFIGURE_ARGS += --disable-gssapi

TARGET_CFLAGS += -DGQ
HOST_CFLAGS += -DGQ

define Package/libtirpc/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtirpc.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/netconfig $(1)/opt/etc/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtirpc.{a,so*} $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include
	$(SED) 's,/opt,${STAGING_DIR}/opt,g' $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libtirpc.pc
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libtirpc.pc $(1)/opt/lib/pkgconfig/libtirpc.pc
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,libtirpc))

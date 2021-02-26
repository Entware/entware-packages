include $(TOPDIR)/rules.mk

PKG_NAME:=libtirpc
PKG_VERSION:=1.3.1
PKG_RELEASE:=1

PKG_SOURCE_URL:=@SF/libtirpc
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_HASH:=245895caf066bec5e3d4375942c8cb4366adad184c29c618d97f724ea309ee17

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
HOST_BUILD_PARALLEL:=1

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

ifeq ($(HOST_OS),Darwin)
HOST_CONFIGURE_ARGS += --disable-symvers
endif

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
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libtirpc.pc $(1)/opt/lib/pkgconfig/libtirpc.pc
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,libtirpc))

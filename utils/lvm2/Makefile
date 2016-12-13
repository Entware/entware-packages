#
# Copyright (C) 2009-2010 Stefan Monnier
# Copyright (C) 2011-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3+.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=LVM2
PKG_VERSION:=2.02.165
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0 LGPL-2.1

PKG_SOURCE:=$(PKG_NAME).$(PKG_VERSION).tgz
PKG_SOURCE_URL:=ftp://sources.redhat.com/pub/lvm2/releases
PKG_MD5SUM:=d459cfe50fd549fe41eeed4ef8fbca3f9833f68012f735adb3462483360e07c7
PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME).$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/libdevmapper
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=The Linux Kernel Device Mapper userspace library
  URL:=http://sourceware.org/dm/
  DEPENDS:=+libpthread +libuuid +librt
endef

define Package/libdevmapper/description
 The device-mapper is a component of the 2.6 linux kernel that supports logical
 volume management. It is required by LVM2 and EVMS.
endef

define Package/lvm2
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Disc
  TITLE:=The Linux Logical Volume Manager
  URL:=http://sourceware.org/lvm2/
  DEPENDS:=+libdevmapper +libblkid +libreadline +libncurses
endef

define Package/lvm2/description
 LVM2 refers to a new userspace toolset that provide logical volume management
 facilities on linux. It is reasonably backwards-compatible with the original
 LVM toolset.
endef

CONFIGURE_ARGS += --disable-o_direct

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(TARGET_LDFLAGS) $(FPIC)" \
		LIBS="-L$(STAGING_DIR)/opt/lib -luuid -lm" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/libdevmapper.h $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libdevmapper.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_BUILD_DIR)/libdm/libdevmapper.pc $(1)/opt/lib/pkgconfig
endef

define Package/libdevmapper/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/libdevmapper.so.* $(1)/opt/lib
endef

define Package/lvm2/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/{dmsetup,lvm} $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/lvm
	$(SED) '/^[[:space:]]*\(#\|$$$$\)/d; /cache_dir/s@.*@    cache_dir = "/opt/tmp/lvm/cache"@' $(PKG_BUILD_DIR)/conf/example.conf
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/example.conf $(1)/opt/etc/lvm/lvm.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S06lvm2 $(1)/opt/etc/init.d
	$(FIND) $(PKG_INSTALL_DIR)/opt/sbin/ -type l -exec $(CP) -a {} $(1)/opt/sbin/ \;
endef

define Package/lvm2/conffiles
/opt/etc/lvm/lvm.conf
endef

$(eval $(call BuildPackage,libdevmapper))
$(eval $(call BuildPackage,lvm2))

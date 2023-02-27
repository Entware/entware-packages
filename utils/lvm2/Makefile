#
# Copyright (C) 2009-2010 Stefan Monnier
# Copyright (C) 2011-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3+.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=LVM2
PKG_VERSION:=2.03.17
PKG_VERSION_DM:=1.02.187
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME).$(PKG_VERSION).tgz
PKG_SOURCE_URL:=https://sourceware.org/pub/lvm2
PKG_HASH:=7286cfa9651828c589389509546333b8da965dfa84a1a4c8ab3e681a47fabae7
PKG_BUILD_DIR:=$(BUILD_DIR)/lvm2-$(BUILD_VARIANT)/$(PKG_NAME).$(PKG_VERSION)

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=GPL-2.0 LGPL-2.1
PKG_LICENSE_FILES:=COPYING COPYING.lib
PKG_CPE_ID:=cpe:/a:heinz_mauelshagen:lvm2

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libdevmapper/Default
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=The Linux Kernel Device Mapper userspace library
  URL:=https://sourceware.org/dm/
  VERSION:=$(PKG_VERSION_DM)
  DEPENDS:=+libpthread +libuuid +librt +libblkid
endef


define Package/libdevmapper
  $(call Package/libdevmapper/Default)
  VARIANT := normal
endef

define Package/libdevmapper-selinux
  $(call Package/libdevmapper/Default)
  VARIANT := selinux
  DEPENDS += +libselinux
  PROVIDES := libdevmapper
endef

define Package/libdevmapper/description
 The device-mapper is a component of the 2.6 linux kernel that supports logical
 volume management. It is required by LVM2 and EVMS.
endef

define Package/libdevmapper-selinux/description
$(call Package/libdevmapper/description)
 This variant supports SELinux

endef

define Package/lvm2/default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Disc
  TITLE:=The Linux Logical Volume Manager
  URL:=https://sourceware.org/lvm2/
  DEPENDS:=+libreadline +libncurses +libaio
endef

define Package/lvm2
  $(call Package/lvm2/default)
  VARIANT := normal
  DEPENDS += +libdevmapper
endef

define Package/lvm2-selinux
  $(call Package/lvm2/default)
  VARIANT := selinux
  DEPENDS += +libdevmapper-selinux
  PROVIDES := lvm2
endef

define Package/lvm2/description
 LVM2 refers to a new userspace toolset that provide logical volume management
 facilities on linux. It is reasonably backwards-compatible with the original
 LVM toolset.
endef

define Package/lvm2-selinux/description
$(call Package/lvm2/description)
 This variant supports SELinux

endef


CONFIGURE_ARGS += \
	--disable-o_direct \
	--with-confdir=/opt/etc \
	--with-default-pid-dir=/opt/var/run \
	--with-default-dm-run-dir=/opt/var/run \
	--with-default-run-dir=/opt/var/run/lvm \
	--with-default-locking-dir=/opt/var/lock/lvm \
	--$(if $(findstring selinux,$(BUILD_VARIANT)),en,dis)able-selinux

ifneq ($(shell /bin/sh -c "echo -n 'X'"),X)
MAKE_SHELL = SHELL=/bin/bash
endif

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(TARGET_LDFLAGS) $(FPIC)" \
		LIBS="-L$(STAGING_DIR)/opt/lib -luuid -lm" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		$(MAKE_SHELL) \
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
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libdevmapper.so.* $(1)/opt/lib
endef

Package/libdevmapper-selinux/install = $(Package/libdevmapper/install)

define Package/lvm2/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/lvm $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/dmsetup $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/lvm
	$(SED) '/^[[:space:]]*\(#\|$$$$\)/d; /cache_dir/s@.*@	cache_dir = "/opt/tmp/lvm/cache"@' $(PKG_INSTALL_DIR)/opt/etc/lvm/lvm.conf
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/lvm/lvm.conf $(1)/opt/etc/lvm/
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/lvm/lvmlocal.conf $(1)/opt/etc/lvm/
	$(INSTALL_DIR) $(1)/opt/etc/lvm/profile
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/lvm/profile/* $(1)/opt/etc/lvm/profile/
#	$(INSTALL_DIR) $(1)/lib/preinit
#	$(INSTALL_DATA) ./files/lvm2.preinit $(1)/lib/preinit/80_lvm2
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S06lvm2 $(1)/opt/etc/init.d
#	$(INSTALL_DIR) $(1)/etc/hotplug.d/block
#	$(INSTALL_DATA) ./files/lvm2.hotplug $(1)/etc/hotplug.d/block/20-lvm2
	$(FIND) $(PKG_INSTALL_DIR)/opt/sbin/ -type l -exec $(CP) -a {} $(1)/opt/sbin/ \;
	# fix /opt
	$(SED) 's|/etc/lvm|/opt/etc/lvm|g;s|/run/lock|/opt/run/lock|' $(1)/opt/etc/lvm/lvm.conf
endef

Package/lvm2-selinux/install = $(Package/lvm2/install)

define Package/lvm2/conffiles
/opt/etc/lvm/lvm.conf
endef

Package/lvm2-selinux/conffiles = $(Package/lvm2/conffiles)

$(eval $(call BuildPackage,libdevmapper))
$(eval $(call BuildPackage,libdevmapper-selinux))
$(eval $(call BuildPackage,lvm2))
$(eval $(call BuildPackage,lvm2-selinux))

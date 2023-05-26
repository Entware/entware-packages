#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# XXX Entware specific: removed opts "--disable-librt"

include $(TOPDIR)/rules.mk

PKG_NAME:=xfsprogs
PKG_VERSION:=6.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/utils/fs/xfs/xfsprogs
PKG_HASH:=d67dcba5a28e0904b60886b6e5f752bc7c9c3a5c7096153855b5adca9db86c51

PKG_MAINTAINER:=
PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=LICENSES/GPL-2.0
PKG_CPE_ID:=cpe:/a:sgi:xfsprogs

PKG_BUILD_DEPENDS:=inih
PKG_BUILD_FLAGS:=no-mips16
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/xfsprogs/default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Filesystem
  DEPENDS:=+liburcu +libuuid +libpthread @!LINUX_2_6_36
  URL:=https://xfs.org/
endef

define Package/xfs-admin
$(call Package/xfsprogs/default)
  TITLE:=Utilities for changing parameters of an XFS filesystems
endef

define Package/xfs-mkfs
$(call Package/xfsprogs/default)
  TITLE:=Utility for creating XFS filesystems
  DEPENDS+=+libinih
endef

define Package/xfs-fsck
$(call Package/xfsprogs/default)
  TITLE:=Utilities for checking and repairing XFS filesystems
endef

define Package/xfs-growfs
$(call Package/xfsprogs/default)
  TITLE:=Utility for increasing the size of XFS filesystems
endef

CONFIGURE_ARGS += \
	--disable-gettext \
	--disable-blkid \
	--disable-readline \
	--disable-editline \
	--disable-termcap \
	--disable-lib64 \
	--disable-ubisan \
	--disable-addrsan \
	--disable-threadsan \
	--disable-scrub \
	--disable-libicu

TARGET_CFLAGS += -DHAVE_MAP_SYNC $(if $(CONFIG_USE_MUSL),-D_LARGEFILE64_SOURCE)
TARGET_CFLAGS += -I$(STAGING_DIR)/opt/include

TARGET_LDFLAGS += $(if $(CONFIG_USE_GLIBC),-lrt)

define Package/xfs-admin/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/xfs_db $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/xfs_admin $(1)/opt/sbin
endef

define Package/xfs-mkfs/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/mkfs.xfs $(1)/opt/sbin
endef

define Package/xfs-fsck/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/xfs_repair $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/xfs_db $(1)/opt/sbin
endef

define Package/xfs-growfs/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/xfs_growfs $(1)/opt/sbin
endef

$(eval $(call BuildPackage,xfs-admin))
$(eval $(call BuildPackage,xfs-mkfs))
$(eval $(call BuildPackage,xfs-fsck))
$(eval $(call BuildPackage,xfs-growfs))

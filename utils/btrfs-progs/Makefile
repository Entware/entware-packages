#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: added --disable-zoned (blkzoned.h since Linux 4.10)

include $(TOPDIR)/rules.mk

PKG_NAME:=btrfs-progs
PKG_VERSION:=6.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/kernel/people/kdave/btrfs-progs
PKG_HASH:=b5316fff1d811e2ad3a067973109eb912bb0d92805735625fd8b82e700201c48
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-v$(PKG_VERSION)

PKG_MAINTAINER:=Karel Kočí <karel.koci@nic.cz>
PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=acl

include $(INCLUDE_DIR)/package.mk

define Package/btrfs-progs
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Filesystem
  TITLE:=Btrfs filesystems utilities
  URL:=https://btrfs.wiki.kernel.org/
  DEPENDS:= \
    +libattr \
    +libuuid \
    +libmount \
    +zlib \
    +libblkid \
    +liblzo \
    +libpthread \
    +BTRFS_PROGS_ZSTD:libzstd
endef

define Package/btrfs-progs/description
 Btrfs is a new copy on write filesystem for Linux aimed at implementing
 advanced features while focusing on fault tolerance, repair and easy
 administration. Initially developed by Oracle, Btrfs is licensed under the
 GPL and open for contribution from anyone.
endef

define Package/btrfs-progs/config
	source "$(SOURCE)/Config.in"
endef

boxprogs = btrfsck mkfs.btrfs btrfs-image btrfstune btrfs-find-root
progs = btrfs-map-logical btrfs-select-super

TARGET_CFLAGS += -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections -Wl,--as-needed

EXTRA_CFLAGS=$(TARGET_CPPFLAGS)

CONFIGURE_ARGS += \
	--disable-backtrace \
	--disable-convert \
	--disable-documentation \
	--disable-libudev \
	--disable-python \
	--disable-zoned
ifneq ($(CONFIG_BTRFS_PROGS_ZSTD),y)
CONFIGURE_ARGS += --disable-zstd
endif

MAKE_INSTALL_FLAGS += BUILD_PROGRAMS=0

Build/Compile=$(call Build/Compile/Default,btrfs.box $(progs))

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libbtrfs* $(1)/opt/lib/
endef

define Package/btrfs-progs/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libbtrfs.so* $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libbtrfsutil.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/btrfs.box $(1)/opt/bin/btrfs
	$(foreach prog,$(boxprogs),$(LN) btrfs $(1)/opt/bin/$(prog);)
	$(foreach prog,$(progs),$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(prog) $(1)/opt/bin/;)
#	$(INSTALL_DIR) $(1)/lib/preinit
#	$(INSTALL_BIN) ./files/btrfs-scan.init $(1)/lib/preinit/85_btrfs_scan
endef

$(eval $(call BuildPackage,btrfs-progs))

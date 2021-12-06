# SPDX-License-Identifier: GPL-2.0-only

include $(TOPDIR)/rules.mk

PKG_NAME:=parted
PKG_VERSION:=3.4
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://ftp.gnu.org/gnu/parted/
PKG_HASH:=e1298022472da5589b7f2be1d5ee3c1b66ec3d96dfbad03dc642afd009da5342

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Oskari Rauta <oskari.rauta@gmail.com>

PKG_CONFIG_DEPENDS:= \
	CONFIG_PARTED_LVM2 \
	CONFIG_PARTED_READLINE

include $(INCLUDE_DIR)/package.mk

define Package/libparted
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=GNU Parted library
  DEPENDS:=+libblkid +libuuid +PARTED_LVM2:libdevmapper
endef

define Package/libparted/description
  GNU Parted shared library
endef

define Package/parted
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=GNU Parted
  SUBMENU:=Disc
  DEPENDS:=+libparted +PARTED_READLINE:libreadline +PARTED_READLINE:libncurses
endef

define Package/parted/description
  GNU Parted manipulates partition tables. This is useful for
  creating space for new operating systems, reorganizing
  disk usage, copying data on hard disks and disk imaging.
endef

define Package/parted/config
  source "$(SOURCE)/Config.in"
endef

CONFIGURE_ARGS += \
	$(if $(CONFIG_PARTED_READLINE),--with-readline,--without-readline) \
	$(if $(CONFIG_PARTED_LVM2),--enable-device-mapper,--disable-device-mapper)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/parted $(1)/opt/lib/ $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/parted/*.h $(1)/opt/include/parted/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libparted/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
endef

define Package/parted/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/parted $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/partprobe $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,libparted))
$(eval $(call BuildPackage,parted))

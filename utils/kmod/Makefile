#
# Copyright (C) 2015 Jeff Waugh
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kmod
PKG_VERSION:=30
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/utils/kernel/kmod
PKG_HASH:=f897dd72698dc6ac1ef03255cd0a5734ad932318e4adbaebc7338ef2f5202f9f

PKG_MAINTAINER:=Jeff Waugh <jdub@bethesignal.org>
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += --with-zlib

define Package/kmod/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Linux kernel module handling
  URL:=https://www.kernel.org/pub/linux/utils/kernel/kmod/
  DEPENDS:=+zlib
endef


define Package/kmod
$(call Package/kmod/Default)
  TITLE+= (tools)
  ALTERNATIVES:=\
    200:/opt/sbin/depmod:/opt/sbin/kmod \
    200:/opt/sbin/insmod:/opt/sbin/kmod \
    200:/opt/sbin/lsmod:/opt/sbin/kmod \
    200:/opt/sbin/modinfo:/opt/sbin/kmod \
    200:/opt/sbin/modprobe:/opt/sbin/kmod \
    200:/opt/sbin/rmmod:/opt/sbin/kmod
endef

define Package/kmod/description
Linux kernel module handling
 kmod is a set of tools to handle common tasks with Linux kernel modules like
 insert, remove, list, check properties, resolve dependencies and aliases.
endef

define Package/kmod/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/kmod $(1)/opt/sbin
endef


define Package/libkmod
$(call Package/kmod/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= (library)
endef

define Package/libkmod/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libkmod.so.* $(1)/opt/lib/
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include $(1)/opt/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libkmod.{so*,la} $(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libkmod.pc $(1)/opt/lib/pkgconfig/
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/libkmod.pc
	$(SED) 's,/opt/lib,$$$${exec_prefix}/lib,g' $(1)/opt/lib/pkgconfig/libkmod.pc
endef


$(eval $(call BuildPackage,kmod))
$(eval $(call BuildPackage,libkmod))

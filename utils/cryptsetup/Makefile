#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cryptsetup
PKG_VERSION:=2.3.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/utils/cryptsetup/v2.3
PKG_HASH:=3bca4ffe39e2f94cef50f6ea65acb873a6dbce5db34fc6bcefe38b6d095e82df

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=GPL-2.0-or-later LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING COPYING.LGPL

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/cryptsetup
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Encryption
  TITLE:=Cryptsetup
  DEPENDS:=$(ICONV_DEPENDS) +libblkid +libuuid +libpopt +lvm2 +libdevmapper +libjson-c +libopenssl $(INTL_DEPENDS)
  URL:=https://gitlab.com/cryptsetup/cryptsetup/
endef

define Package/cryptsetup/description
  Cryptsetup is utility used to conveniently setup disk encryption based on DMCrypt kernel module.
endef

CONFIGURE_ARGS += \
	--disable-cryptsetup-reencrypt \
	--disable-integritysetup \
	--disable-selinux \
	--disable-rpath \
	--disable-veritysetup \
	--disable-udev \
	--with-default-luks-format=LUKS2

ifneq ($(CONFIG_LINUX_2_6_36),y)
CONFIGURE_ARGS += \
	--with-luks2-lock-path=/opt/var/run/cryptsetup \
	--with-crypto_backend=kernel
endif

ifeq ($(CONFIG_LINUX_2_6_36),y)
CONFIGURE_ARGS+= \
	--disable-kernel_crypto
endif

TARGET_LDFLAGS += $(if $(ICONV_FULL),-liconv) $(if $(INTL_FULL),-lintl)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/libcryptsetup.h $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libcryptsetup.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libcryptsetup.pc $(1)/opt/lib/pkgconfig
endef

define Package/cryptsetup/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libcryptsetup.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/cryptsetup $(1)/opt/sbin
endef

$(eval $(call BuildPackage,cryptsetup))

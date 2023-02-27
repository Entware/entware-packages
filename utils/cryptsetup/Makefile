#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cryptsetup
PKG_VERSION:=2.6.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/utils/cryptsetup/v2.6
PKG_HASH:=44397ba76e75a9cde5b02177bc63cd7af428a785788e3a7067733e7761842735

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=GPL-2.0-or-later LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING COPYING.LGPL

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_BUILD_DEPENDS:=!USE_GLIBC:argp-standalone

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/cryptsetup
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Encryption
  TITLE:=Cryptsetup
  DEPENDS:=$(ICONV_DEPENDS) $(INTL_DEPENDS) +libblkid +libuuid +libpopt +lvm2 \
           +libdevmapper +libjson-c +LINUX_2_6_36:libopenssl
  URL:=https://gitlab.com/cryptsetup/cryptsetup/
endef

define Package/cryptsetup/description
  Cryptsetup is utility used to conveniently setup disk encryption based on DMCrypt kernel module.
endef

define Package/cryptsetup-ssh
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Encryption
  TITLE:=Cryptsetup SSH token
  DEPENDS:=+cryptsetup +PACKAGE_cryptsetup-ssh:libssh
  URL:=https://gitlab.com/cryptsetup/cryptsetup/
endef

define Package/cryptsetup-ssh/description
  Experimental SSH token support for cryptsetup.
endef

CONFIGURE_ARGS += \
	--disable-asciidoc \
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

ifeq ($(CONFIG_PACKAGE_cryptsetup-ssh),)
CONFIGURE_ARGS += --disable-ssh-token
endif

CONFIGURE_VARS += \
	LIBSSH_CFLAGS="-I$(STAGING_DIR)/opt/include" \
	LIBSSH_LIBS="-L$(STAGING_DIR)/opt/lib -lssh"

TARGET_LDFLAGS += -Wl,--gc-sections $(if $(INTL_FULL),-lintl)

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

define Package/cryptsetup-ssh/install
	$(INSTALL_DIR) $(1)/opt/lib/cryptsetup
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/cryptsetup/* $(1)/opt/lib/cryptsetup
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/cryptsetup-ssh $(1)/opt/sbin
endef

$(eval $(call BuildPackage,cryptsetup))
$(eval $(call BuildPackage,cryptsetup-ssh))

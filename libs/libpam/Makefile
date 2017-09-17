#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpam
PKG_VERSION:=1.2.0
PKG_RELEASE:=2

PKG_SOURCE:=Linux-PAM-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.linux-pam.org/library/
PKG_HASH:=cd8beac5961e942e9c73b32a3cd1a3457755f8fb35d07c9ec64511e19e135ea4
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_MAINTAINER:=Nikos Mavrogiannopoulos <n.mavrogiannopoulos@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/Linux-PAM-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/libpam
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=the Linux-PAM libraries and modules.
  URL:=http://www.kernel.org/pub/linux/libs/pam
endef

define Package/libpam/description
	The Linux-PAM Pluggable Authentication Modules.
endef

TARGET_CFLAGS += $(FPIC)

define Build/Configure
	$(call Build/Configure/Default, \
		--enable-shared \
		--enable-static \
		--enable-pamlocking \
		--disable-prelude \
		--disable-lckpwdf \
		--disable-selinux \
		--disable-nls \
		--disable-rpath \
		--disable-nis \
		--disable-regenerate-docu \
		--enable-db=no \
		--enable-read-both-confs \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/include/security
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/security
endef

define Package/libpam/install
	$(INSTALL_DIR) $(1)/opt/lib $(1)/opt/lib/security $(1)/opt/lib/security/pam_filter
	$(INSTALL_DIR) $(1)/opt/etc $(1)/opt/etc/pam.d
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/security/*.so* $(1)/opt/lib/security/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/security/pam_filter/* $(1)/opt/lib/security/pam_filter/
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/* $(1)/opt/etc/
	$(CP) ./files/* $(1)/opt/etc/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/* $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,libpam))

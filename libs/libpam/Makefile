#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: help other packages find headers

include $(TOPDIR)/rules.mk

PKG_NAME:=libpam
PKG_VERSION:=1.3.0
PKG_RELEASE:=1

PKG_SOURCE:=Linux-PAM-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.linux-pam.org/library/
PKG_HASH:=241aed1ef522f66ed672719ecf2205ec513fd0075ed80cda8e086a5b1a01d1bb
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
		--includedir=/opt/include/security \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
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

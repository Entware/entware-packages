#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpam
PKG_VERSION:=1.5.2
PKG_RELEASE:=1

PKG_SOURCE:=Linux-PAM-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/linux-pam/linux-pam/releases/download/v$(PKG_VERSION)
PKG_HASH:=e4ec7131a91da44512574268f493c6d8ca105c87091691b8e9b56ca685d4f94d
PKG_BUILD_DIR:=$(BUILD_DIR)/Linux-PAM-$(PKG_VERSION)

PKG_MAINTAINER:=Nikos Mavrogiannopoulos <n.mavrogiannopoulos@gmail.com>
PKG_LICENSE:=BSD-3c GPL
PKG_LICENSE_FILES:=COPYING Copyright
PKG_CPE_ID:=cpe:/a:kernel:linux-pam

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

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

CONFIGURE_ARGS += \
	--enable-pamlocking \
	--enable-shared \
	--enable-static \
	--disable-audit \
	--disable-cracklib \
	--disable-db \
	--disable-debug \
	--disable-doc \
	--disable-econf \
	--disable-lckpwdf \
	--disable-nis \
	--disable-prelude \
	--disable-regenerate-docu \
	--disable-rpath \
	--disable-selinux \
	--disable-Werror \
	--with-gnu-ld \
	--without-mailspool \
	--without-xauth \
	--includedir=/opt/include/security

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/* $(1)/opt/lib/
endef

define Package/libpam/install
	$(INSTALL_DIR) $(1)/opt/etc $(1)/opt/etc/pam.d
	$(INSTALL_DIR) $(1)/opt/lib $(1)/opt/lib/security $(1)/opt/lib/security/pam_filter
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/* $(1)/opt/etc/
	$(CP) ./files/* $(1)/opt/etc/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/security/*.so* $(1)/opt/lib/security/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/security/pam_filter/* $(1)/opt/lib/security/pam_filter/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/* $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc $(1)/opt/lib/pkgconfig/
endef

$(eval $(call BuildPackage,libpam))

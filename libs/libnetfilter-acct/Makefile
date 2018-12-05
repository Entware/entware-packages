#
# Copyright (C) 2009-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libnetfilter_acct
PKG_VERSION:=1.0.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://netfilter.org/projects/libnetfilter_acct/files
PKG_HASH:=4250ceef3efe2034f4ac05906c3ee427db31b9b0a2df41b2744f4bf79a959a1a

PKG_LICENSE:=LGPL-2.1+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Nicolas Thill <nico@openwrt.org>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libnetfilter-acct
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=API to extended accounting infrastructure
  URL:=http://www.netfilter.org/projects/libnetfilter_acct/
  DEPENDS:=+libmnl
endef

define Package/libnetfilter-acct/description
 libnetfilter_acct is a userspace library providing a programming interface
 (API) to the extended accounting infrastructure.
endef

TARGET_CFLAGS += $(FPIC)

CONFIGURE_ARGS += \
	--enable-static \
	--enable-shared \


define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/libnetfilter_acct \
		$(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libnetfilter_acct*.{so*,a,la} \
		$(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libnetfilter_acct.pc \
		$(1)/opt/lib/pkgconfig/
endef

define Package/libnetfilter-acct/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libnetfilter_acct.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libnetfilter-acct))

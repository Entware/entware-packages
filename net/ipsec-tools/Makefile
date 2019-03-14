#
# Copyright (C) 2006-2015 OpenWrt.org
#               2014 Noah Meyerhans <frodo@morgul.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ipsec-tools
PKG_VERSION:=0.8.2
PKG_RELEASE:=9
PKG_MAINTAINER:=Noah Meyerhans <frodo@morgul.net>, \
	Vitaly Protsko <villy@sft.ru>
PKG_LICENSE := BSD-3-Clause

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/ipsec-tools
PKG_HASH:=8eb6b38716e2f3a8a72f1f549c9444c2bc28d52c9536792690564c74fe722f2d

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/ipsec-tools
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  DEPENDS:=+libopenssl
  TITLE:=IPsec management tools
  URL:=http://ipsec-tools.sourceforge.net/
  MAINTAINER:=Noah Meyerhans <frodo@morgul.net>
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--with-kernel-headers="$(LINUX_DIR)/include" \
	--without-readline \
	--with-openssl="$(STAGING_DIR)/opt" \
	--without-libradius \
	--without-libpam \
	--enable-dpd \
	--enable-hybrid \
	--enable-security-context=no \
	--enable-natt \
	--enable-adminport \
	--enable-frag \
	 $(call autoconf_bool,CONFIG_IPV6,ipv6)

# Entware specific: set _DEFAULT_SOURCE
TARGET_CFLAGS += -D_DEFAULT_SOURCE

# override CFLAGS holding "-Werror" that break builds on compile warnings
MAKE_FLAGS+=\
	CFLAGS="$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS)"

define Build/Prepare
	$(call Build/Prepare/Default)
	chmod -R u+w $(PKG_BUILD_DIR)
endef

define Build/Configure
	(cd $(PKG_BUILD_DIR); touch \
		configure.ac \
		aclocal.m4 \
		Makefile.in \
		config.h.in \
		configure \
	);
	$(call Build/Configure/Default)
ifndef CONFIG_SHADOW_PASSWORDS
	echo "#undef HAVE_SHADOW_H" >> $(PKG_BUILD_DIR)/config.h
endif
endef

define Package/ipsec-tools/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S49racoon $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libipsec.so.* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libracoon.so.* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/plainrsa-gen $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/racoon $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/racoonctl $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/setkey $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,ipsec-tools))

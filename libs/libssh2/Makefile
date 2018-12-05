#
# Copyright (C) 2015-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libssh2
PKG_VERSION:=1.8.0
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.libssh2.org/download
PKG_HASH:=39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

PKG_LICENSE:=BSD
PKG_LICENSE_FILES:=COPYING

PKG_CONFIG_DEPENDS:= \
	CONFIG_LIBSSH2_MBEDTLS \
	CONFIG_LIBSSH2_OPENSSL

include $(INCLUDE_DIR)/package.mk

define Package/libssh2
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=SSH2 library
  URL:=https://www.libssh2.org/
  DEPENDS:=+LIBSSH2_MBEDTLS:libmbedtls +LIBSSH2_OPENSSL:libopenssl +zlib
  MAINTAINER:=Jiri Slachta <jiri@slachta.eu>
endef

define Package/libssh2/description
 libssh2 is a client-side C library implementing the SSH2 protocol.
endef

define Package/libssh2/config
	source "$(SOURCE)/Config.in"
endef

CONFIGURE_ARGS += \
	--disable-examples-build \
	--disable-silent-rules \
	$(if $(CONFIG_LIBSSH2_MBEDTLS),--with-mbedtls --with-libmbedtls-prefix=$(STAGING_DIR)/opt) \
	$(if $(CONFIG_LIBSSH2_OPENSSL),--with-openssl --with-libssl-prefix=$(STAGING_DIR)/opt) \
	--with-libz-prefix=$(STAGING_DIR)/opt

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libssh2.so* $(1)/opt/lib/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libssh2.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libssh2/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libssh2.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libssh2))

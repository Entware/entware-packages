#
# Copyright (C) 2018 Jianhui Zhao
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libuhttpd
PKG_VERSION:=3.9.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL=https://github.com/zhaojh329/libuhttpd/releases/download/v$(PKG_VERSION)
PKG_HASH:=9939cd5f9aaad2c118bc04417fb2d21994fb1cdca7fff475a0930a1374635af0

PKG_MAINTAINER:=Jianhui Zhao <zhaojh329@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1
CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libuhttpd/Default
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Networking
  TITLE:=A lightweight HTTP server library based on libev
  URL:=https://github.com/zhaojh329/libuhttpd
  DEPENDS:=+libev $(2)
  VARIANT:=$(1)
  PROVIDES:=libuhttpd
endef

Package/libuhttpd-openssl=$(call Package/libuhttpd/Default,openssl,+PACKAGE_libuhttpd-openssl:libopenssl)
Package/libuhttpd-wolfssl=$(call Package/libuhttpd/Default,wolfssl,+PACKAGE_libuhttpd-wolfssl:libwolfssl)
Package/libuhttpd-mbedtls=$(call Package/libuhttpd/Default,mbedtls,+PACKAGE_libuhttpd-mbedtls:libmbedtls +PACKAGE_libuhttpd-mbedtls:zlib)
Package/libuhttpd-nossl=$(call Package/libuhttpd/Default,nossl)

ifeq ($(BUILD_VARIANT),openssl)
  CMAKE_OPTIONS += -DUHTTPD_USE_OPENSSL=ON
else ifeq ($(BUILD_VARIANT),wolfssl)
  CMAKE_OPTIONS += -DUHTTPD_USE_WOLFSSL=ON
else ifeq ($(BUILD_VARIANT),mbedtls)
  CMAKE_OPTIONS += -DUHTTPD_USE_MBEDTLS=ON
else
  CMAKE_OPTIONS += -DUHTTPD_SSL_SUPPORT=OFF
endif

define Package/libuhttpd-$(BUILD_VARIANT)/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libuhttpd.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libuhttpd-openssl))
$(eval $(call BuildPackage,libuhttpd-mbedtls))
$(eval $(call BuildPackage,libuhttpd-wolfssl))
$(eval $(call BuildPackage,libuhttpd-nossl))

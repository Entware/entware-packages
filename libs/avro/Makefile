#
# avro - Makefile for Apache Avro library
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=avro-c
PKG_VERSION:=1.8.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@APACHE/avro/avro-$(PKG_VERSION)/c
PKG_MD5SUM:=b268348536714541e10411823a1b59b0

PKG_MAINTAINER:=John Clark <inindev@gmail.com>

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/avro-c
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+jansson +zlib +liblzma
  TITLE:=Apache Avro C Library
  URL:=https://avro.apache.org
endef

define Package/avro-c/description
  This package contains the Apache Avro C library.
endef

CMAKE_OPTIONS += \
        -DCMAKE_BUILD_TYPE:STRING=MINSIZEREL

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/{lib,include}
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libavro.{a,so*} $(1)/opt/lib/
endef

define Package/avro-c/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libavro.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,avro-c))


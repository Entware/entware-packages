#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=hidapi
PKG_VERSION:=0.8.0-rc1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/signal11/hidapi.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=hidapi-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=95b39035f94c35b0c360ec2e02a01fe25e971490135d7137f163974d4a88471f
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE-bsd.txt

PKG_MAINTAINER:=Paul Fertser <fercerpav@gmail.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/hidapi
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libusb-1.0 +librt $(ICONV_DEPENDS)
  TITLE:=Library to talk to HID devices
  URL:=http://www.signal11.us/oss/hidapi/
endef

define Package/hidapi/description
HIDAPI is a multi-platform library which allows an application to interface
with USB and Bluetooth HID-Class devices on Windows, Linux, FreeBSD, and Mac
OS X.  HIDAPI can be either built as a shared library (.so or .dll) or
can be embedded directly into a target application by adding a single source
file (per platform) and a single header.
endef

define Build/Configure
endef

MAKE_PATH=libusb
MAKE_FLAGS+=-f Makefile.linux
TARGET_CFLAGS+=$(FPIC)

define Build/Compile
	$(call Build/Compile/Default, libhidapi-libusb.so)
	mv $(PKG_BUILD_DIR)/libusb/libhidapi-libusb.so \
		$(PKG_BUILD_DIR)/libusb/libhidapi-libusb.so.0
	ln -s libhidapi-libusb.so.0 $(PKG_BUILD_DIR)/libusb/libhidapi-libusb.so
	sed    's^@prefix@^/opt^; \
		s^@exec_prefix@^/opt^; \
		s^@libdir@^$$$${exec_prefix}/lib^; \
		s^@includedir@^$$$${prefix}/include^' \
		< $(PKG_BUILD_DIR)/pc/hidapi-libusb.pc.in \
		> $(PKG_BUILD_DIR)/pc/hidapi-libusb.pc
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/hidapi
	$(CP) $(PKG_BUILD_DIR)/hidapi/hidapi.h $(1)/opt/include/hidapi/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/libusb/libhidapi-libusb.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_BUILD_DIR)/pc/hidapi-libusb.pc $(1)/opt/lib/pkgconfig/
endef

define Package/hidapi/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/libusb/libhidapi-libusb.so* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,hidapi))

#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: TARGET_CFLAGS

include $(TOPDIR)/rules.mk

PKG_NAME:=hidapi
PKG_VERSION:=0.12.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/libusb/hidapi/tar.gz/$(PKG_NAME)-$(PKG_VERSION)?
PKG_HASH:=28ec1451f0527ad40c1a4c92547966ffef96813528c8b184a665f03ecbb508bc
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=Paul Fertser <fercerpav@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE-bsd.txt

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/hidapi
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libusb-1.0 +libudev $(ICONV_DEPENDS)
  TITLE:=Library to talk to HID devices
  URL:=https://github.com/libusb/hidapi
endef

define Package/hidapi/description
HIDAPI is a multi-platform library which allows an application to interface
with USB and Bluetooth HID-Class devices on Windows, Linux, FreeBSD, and Mac
OS X.  HIDAPI can be either built as a shared library (.so or .dll) or
can be embedded directly into a target application by adding a single source
file (per platform) and a single header.
endef

ifdef CONFIG_LINUX_2_6_36
	TARGET_CFLAGS += -DHIDAPI_ALLOW_BUILD_WORKAROUND_KERNEL_2_6_39
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/hidapi
	$(CP) $(PKG_INSTALL_DIR)/opt/include/hidapi/hidapi.h $(1)/opt/include/hidapi/
	$(CP) $(PKG_INSTALL_DIR)/opt/include/hidapi/hidapi_libusb.h $(1)/opt/include/hidapi/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libhidapi-hidraw.so* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libhidapi-libusb.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/hidapi-libusb.pc $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/hidapi-hidraw.pc $(1)/opt/lib/pkgconfig/
endef

define Package/hidapi/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libhidapi-hidraw.so.* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libhidapi-libusb.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,hidapi))

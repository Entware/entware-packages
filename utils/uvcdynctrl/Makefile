#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uvcdynctrl
PKG_VERSION:=0.2.4

PKG_SOURCE:=libwebcam-src-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/libwebcam
PKG_MD5SUM:=31dbb5713e95a699c5fc4dbe1493f764
PKG_MAINTAINER:=Roger D <rogerdammit@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/libwebcam-src-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/uvcdynctrl
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libwebcam +PACKAGE_UVCDYNCTRL_UDEV_RULE:udev
  TITLE:=Manage dynamic controls in uvcvideo
  URL:=http://sourceforge.net/projects/libwebcam/
  MENU:=1
endef

define Package/uvcdynctrl/description
  The webcam-tools package contains the following two components:
  - libwebcam: Webcam Library (LGPL)
  - uvcdynctrl: Manage dynamic controls in uvcvideo (GPL)
endef

define Package/uvcdynctrl/config
config PACKAGE_UVCDYNCTRL_UDEV_RULE
	bool "uvcdynctrl udev rule, selects udev"
	depends on PACKAGE_uvcdynctrl
	default no
	help
	  Installs an udev rule to load uvcdynctrl with dynamic controls
	  from xml files in /opt/share/uvcdynctrl when a webcam is attached.
endef

define Package/libwebcam
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libxml2 +libiconv-full
  TITLE:=Webcam library
  URL:=http://sourceforge.net/projects/libwebcam/
endef

define Package/libwebcam/description
  $(call Package/uvcdynctrl/description)
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/opt/lib/libiconv-full/include -liconv
TARGET_LDFLAGS += -L$(STAGING_DIR)/opt/lib/libiconv-full/lib

define Package/uvcdynctrl/install
	$(INSTALL_DIR) $(1)/opt/{bin,share}
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/uvcdynctrl* $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/share/uvcdynctrl/ $(1)/opt/share/

ifeq ($(CONFIG_PACKAGE_UVCDYNCTRL_UDEV_RULE),y)
	$(INSTALL_DIR) $(1)/lib/udev/rules.d
	$(CP) $(PKG_INSTALL_DIR)/lib/udev/rules.d/*.rules $(1)/lib/udev/rules.d/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/lib/udev/uvcdynctrl $(1)/lib/udev/
endif
endef

define Package/libwebcam/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libwebcam.so* $(1)/opt/lib/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/{include,lib}
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libwebcam.{a,so*} $(1)/opt/lib/
endef

$(eval $(call BuildPackage,uvcdynctrl))
$(eval $(call BuildPackage,libwebcam))

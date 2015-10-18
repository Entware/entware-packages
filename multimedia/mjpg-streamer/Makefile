#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mjpg-streamer
PKG_REV:=181
PKG_VERSION:=r$(PKG_REV)
PKG_RELEASE:=2
PKG_MAINTAINER:=Roger D <rogerdammit@gmail.com>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://svn.code.sf.net/p/mjpg-streamer/code/mjpg-streamer
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=svn

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_DEPENDS:=MJPG_STREAMER_V4L2:libv4l

define Package/mjpg-streamer
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=MJPG-streamer
  DEPENDS:=+libpthread +libjpeg +MJPG_STREAMER_V4L2:libv4l
  URL:=http://mjpg-streamer.wiki.sourceforge.net/
  MENU:=1
endef

define Package/mjpg-streamer/description
 Streaming application for Linux-UVC compatible webcams
endef

define Package/mjpg-streamer/config
  source "$(SOURCE)/Config.in"
endef

EXTRA_CFLAGS += $(TARGET_CPPFLAGS) $(TARGET_LDFLAGS)

ifeq ($(CONFIG_MJPG_STREAMER_V4L2),y)
    TARGET_CFLAGS+= -DUSE_LIBV4L2
    TARGET_LDFLAGS+= -lv4l2
endif

define Package/mjpg-streamer/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mjpg_streamer $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S96mjpg-streamer $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/lib
ifeq ($(CONFIG_MJPG_STREAMER_INPUT_FILE),y)
	$(CP) $(PKG_BUILD_DIR)/input_file.so $(1)/opt/lib
endif
ifeq ($(CONFIG_MJPG_STREAMER_INPUT_UVC),y)
	$(CP) $(PKG_BUILD_DIR)/input_uvc.so $(1)/opt/lib
endif
ifeq ($(CONFIG_MJPG_STREAMER_INPUT_TESTPICTURE),y)
	$(CP) $(PKG_BUILD_DIR)/input_testpicture.so $(1)/opt/lib
endif
ifeq ($(CONFIG_MJPG_STREAMER_OUTPUT_FILE),y)
	$(CP) $(PKG_BUILD_DIR)/output_file.so $(1)/opt/lib
endif
ifeq ($(CONFIG_MJPG_STREAMER_OUTPUT_HTTP),y)
	$(CP) $(PKG_BUILD_DIR)/output_http.so $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/share/www/webcam
    ifeq ($(CONFIG_MJPG_STREAMER_WWW),y)
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/* $(1)/opt/share/www/webcam
    else
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/stream_simple.html $(1)/opt/share/www/webcam/index.html
    endif
endif
endef

$(eval $(call BuildPackage,mjpg-streamer))

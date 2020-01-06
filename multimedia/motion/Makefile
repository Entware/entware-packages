#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=motion
PKG_VERSION:=4.2.2
PKG_RELEASE:=2

PKG_MAINTAINER:=Roger D <rogerdammit@gmail.com>
PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:lavrsen:motion

PKG_SOURCE:=$(PKG_NAME)-release-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/Motion-Project/motion/tar.gz/release-$(PKG_VERSION)?
PKG_HASH:=c8d40976b41da8eb9f9f7128599403a312fc26b7226bf3787d75f78cb5a6cc6e
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-release-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/motion
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+libjpeg +libpthread +libmicrohttpd-ssl
  TITLE:=webcam motion sensing and logging
  URL:=https://motion-project.github.io/
endef

define Package/motion/conffiles
/opt/etc/motion/motion.conf
endef

# Entware specific: help motion find the correct microhttpd.h (CFLAGS...)
CONFIGURE_ARGS+= \
	--without-optimizecpu \
	--without-ffmpeg \
	--without-jpeg-mmx \
	--without-sdl \
	--without-mysql \
	--without-pgsql \
	--without-sqlite3 \
	--without-bktr \
	--without-webp \
	CFLAGS='$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)'

ifeq ($(CONFIG_TARGET_armv7_2_6)$(CONFIG_TARGET_x86_2_6),y)
CONFIGURE_ARGS+= \
	--without-v4l2
endif

define Package/motion/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/motion
	$(INSTALL_BIN) ./files/S99motion $(1)/opt/etc/init.d
	$(CP) $(PKG_BUILD_DIR)/motion-dist.conf $(1)/opt/etc/motion/motion.conf
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/motion $(1)/opt/bin/
endef

$(eval $(call BuildPackage,motion))

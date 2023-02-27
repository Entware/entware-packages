#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=motion
PKG_VERSION:=4.5.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-release-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/Motion-Project/motion/tar.gz/release-$(PKG_VERSION)?
PKG_HASH:=42320a1c7b54a3f0b5a49cecf34a5d752760b28383bc573b3ca1240581786fe5
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-release-$(PKG_VERSION)

PKG_MAINTAINER:=Roger D <rogerdammit@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:lavrsen:motion

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=gettext-full/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/motion
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+libjpeg +libpthread +libmicrohttpd $(INTL_DEPENDS)
  TITLE:=webcam motion sensing and logging
  URL:=https://motion-project.github.io/
endef

define Package/motion/conffiles
/opt/etc/motion/motion.conf
endef

# Entware specific: help motion find the correct microhttpd.h (CFLAGS...)
CONFIGURE_ARGS += \
	--without-bktr \
	--without-webp \
	--without-mmal \
	--without-ffmpeg \
	--without-mariadb \
	--without-mysql \
	--without-pgsql \
	--without-sqlite3 \
	--without-optimizecpu \
	CFLAGS='$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)'

ifeq ($(CONFIG_LINUX_2_6_36),y)
CONFIGURE_ARGS+= \
	--without-v4l2
endif

define Package/motion/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/motion
	$(INSTALL_BIN) ./files/S99motion $(1)/opt/etc/init.d
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/motion/motion-dist.conf $(1)/opt/etc/motion/motion.conf
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/motion $(1)/opt/bin/
endef

$(eval $(call BuildPackage,motion))

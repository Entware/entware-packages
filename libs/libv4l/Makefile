#
# Copyright (C) 2009-2012 OpenWrt.org
# Copyright (C) 2009 David Cooper <dave@kupesoft.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Downgraded to 0.8.6 - the last one working on kernel 2.6.22

include $(TOPDIR)/rules.mk

PKG_NAME:=v4l-utils
PKG_VERSION:=0.8.6
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.linuxtv.org/downloads/v4l-utils
PKG_MD5SUM:=80062780ae90e5955473b09b31e9828a

PKG_BUILD_DEPENDS:=USE_MUSL:argp-standalone

# glibc doen not need argp-standalone
PATCH_DIR=./patches/$(CONFIG_LIBC)

include $(INCLUDE_DIR)/package.mk

define Package/libv4l/Default
  TITLE:=Video 4 Linux
  URL:=http://www.linuxtv.org/
endef

define Package/libv4l/Default/description
  libv4l is a collection of libraries which adds a thin abstraction layer on
  top of video4linux2 devices. The purpose of this (thin) layer is to make it
  easy for application writers to support a wide variety of devices without
  having to write separate code for different devices in the same class. libv4l
  consists of 3 different libraries: libv4lconvert, libv4l1 and libv4l2.

  libv4l1 offers the (deprecated) v4l1 API on top of v4l2 devices, independent
  of the drivers for those devices supporting v4l1 compatibility (which many
  v4l2 drivers do not).

  libv4l2 offers the v4l2 API on top of v4l2 devices, while adding for the
  application transparent libv4lconvert conversion where necessary.
endef

define Package/libv4l
  $(call Package/libv4l/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= wrapper libraries
  DEPENDS := +libpthread +librt
endef

define Package/libv4l/description
  $(call Package/libv4l/Default/description)
endef

define Package/v4l-utils
  $(call Package/libv4l/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= utilities
  DEPENDS := +libv4l +libstdcpp
endef

define Package/v4l-utils/description
  $(call Package/libv4l/Default/description)
  This package contains the video4linux utilities.
endef

TARGET_CFLAGS += $(FPIC)

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" PREFIX="/opt" \
		DISABLE_LIBJPEG="1" \
		$(CONFIGURE_VARS) \
		all install
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" PREFIX="/opt" \
		DISABLE_LIBJPEG="1" \
		$(CONFIGURE_VARS) \
		LINKTYPE="static" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libv4l{1,2,convert}.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libv4l{1,2,convert}.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libv4l/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libv4l{1,2,convert}.so.* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/libv4l
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libv4l/v4l{1compat,2convert}.so $(1)/opt/lib/libv4l/
endef

define Package/v4l-utils/install
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) $(PKG_INSTALL_DIR)/etc/rc_maps.cfg $(1)/opt/etc/
	$(CP) $(PKG_INSTALL_DIR)/etc/rc_keymaps $(1)/opt/etc/
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/{cx18,ivtv}-ctl $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/decode_tm6000 $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ir-keytable $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/v4l2-{compliance,ctl,sysfs-path} $(1)/opt/bin/
endef

$(eval $(call BuildPackage,libv4l))
$(eval $(call BuildPackage,v4l-utils))

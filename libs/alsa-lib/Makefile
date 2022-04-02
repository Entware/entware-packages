#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=alsa-lib
PKG_VERSION:=1.2.6.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ftp://ftp.alsa-project.org/pub/lib/ \
		http://distfiles.gentoo.org/distfiles/
PKG_HASH:=ad582993d52cdb5fb159a0beab60a6ac57eab0cc1bdf85dc4db6d6197f02333f

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>, \
		Peter Wagner <tripolar@gmx.at>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/alsa-lib
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=ALSA (Advanced Linux Sound Architecture) library
  URL:=http://www.alsa-project.org/
  DEPENDS:=@AUDIO_SUPPORT +libpthread +librt
  LICENSE:=LGPL-2.1-or-later
  LICENSE_FILES:=COPYING
endef

define Package/alsa-lib/description
 This is the library package for alsa, needed by some userspace programs.
 You must have enabled the ALSA support in the kernel.
endef

define Package/aserver
  SECTION:=sound
  CATEGORY:=Sound
  TITLE:=ALSA (Advanced Linux Sound Architecture) server
  URL:=http://www.alsa-project.org/
  DEPENDS:=+alsa-lib
  LICENSE:=GPL-2.0-or-later
  LICENSE_FILES:=aserver/COPYING
endef

define Package/aserver/description
 This is the aserver application for ALSA.
endef

define Package/alsa-lib/conffiles
/opt/etc/asound.conf
endef

TARGET_CFLAGS += $(FPIC)

CONFIGURE_ARGS+= \
		--disable-python \
		--disable-debug \
		--without-debug \
		--without-versioned \
		$(SOFT_FLOAT_CONFIG_OPTION)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/alsa \
		$(1)/opt/include/

	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libasound.{la,so*} \
		$(1)/opt/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libatopology.{la,so*} \
		$(1)/opt/lib/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/alsa.pc \
		$(1)/opt/lib/pkgconfig/

	$(INSTALL_DIR) $(1)/opt/share/aclocal
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/aclocal/alsa.m4 \
		$(1)/opt/share/aclocal/
endef

define Package/alsa-lib/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libasound.so.* \
		$(1)/opt/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libatopology.so.* \
		$(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/share/alsa/{cards,ctl,pcm}
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/alsa/alsa.conf \
		$(1)/opt/share/alsa/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/alsa/ctl/* \
		$(1)/opt/share/alsa/ctl/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/alsa/pcm/* \
		$(1)/opt/share/alsa/pcm/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/share/alsa/cards/* \
		$(1)/opt/share/alsa/cards/
endef

define Package/aserver/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/aserver $(1)/opt/bin
endef

$(eval $(call BuildPackage,alsa-lib))
$(eval $(call BuildPackage,aserver))

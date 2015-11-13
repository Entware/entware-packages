#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mpg123
PKG_VERSION:=1.22.3
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.mpg123.de/download/
PKG_MD5SUM:=fca857bc5ad0d2070cd38bd5f0f85f1c
PKG_MAINTAINER:=Zoltan HERPAI <wigyori@uid0.hu>

PKG_FIXUP:=libtool

PKG_LICENSE:=LGPL-2.1 GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mpg123/Default
  URL:=http://www.mpg123.de
  DEPENDS:=@BUILD_PATENTED
endef

define Package/libmpg123
  $(call Package/mpg123/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=fast console mpeg audio decoder library
  DEPENDS:=+libltdl
endef

define Package/mpg123
  $(call Package/mpg123/Default)
  SECTION:=sound
  CATEGORY:=Sound
  TITLE:=fast console mpeg audio player
  DEPENDS+=+libmpg123 +alsa-lib
endef

define Build/Configure
	$(call Build/Configure/Default, \
		--enable-shared \
		--enable-static \
		--with-cpu=generic_nofpu \
		--with-default-audio=alsa \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/include/mpg123.h \
		$(1)/opt/include/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libmpg123.{la,a,so*} \
		$(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/lib/mpg123
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/mpg123/* \
		$(1)/opt/lib/mpg123

	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libmpg123.pc \
		$(1)/opt/lib/pkgconfig
endef

define Package/libmpg123/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/libmpg123.so* \
		$(1)/opt/lib/
endef

#mpg123 if compiled after pulseaudio will build pulseaudio plugin. It is removed!
define Package/mpg123/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/mpg123{,-id3dump,-strip} \
		$(1)/opt/bin

	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/out123 \
		$(1)/opt/bin

	$(INSTALL_DIR) $(1)/opt/lib/mpg123
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/mpg123/*.so \
		$(1)/opt/lib/mpg123
	$(RM) $(1)/opt/lib/mpg123/*pulse*.so
endef

$(eval $(call BuildPackage,libmpg123))
$(eval $(call BuildPackage,mpg123))

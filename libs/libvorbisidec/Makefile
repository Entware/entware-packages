#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libvorbisidec
PKG_REV:=20180319
PKG_VERSION:=1.0.3-$(PKG_REV)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.xiph.org/xiph/tremor.git
PKG_SOURCE_VERSION:=7c30a66346199f3f09017a09567c6c8a3a0eedc8
PKG_MIRROR_HASH:=9cdec0bf6663d7c9e615dd556a2f115efccded884fe52c8dd18b42120781bed0

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/libvorbisidec
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=A fixed-point Ogg/Vorbis decoder library
  DEPENDS:= +libogg
  URL:=http://wiki.xiph.org/index.php/Tremor
endef

define Package/libvorbisidec/description
  libvorbisidec is "tremor", a fixed-point implementation of libvorbis.
  It also has libogg built-in. It is suitable as a replacement for
  libvorbis and libogg in tremor-aware applications.
  Tremor is a decoder only.
endef

TARGET_CFLAGS += $(FPIC)
CONFIGURE_ARGS += --enable-shared --enable-static

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/tremor $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libvorbisidec.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/* $(1)/opt/lib/pkgconfig/
endef

define Package/libvorbisidec/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libvorbisidec.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libvorbisidec))

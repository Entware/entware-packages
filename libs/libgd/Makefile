#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libgd
PKG_VERSION:=2.3.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/$(PKG_NAME)/$(PKG_NAME)/releases/download/gd-$(PKG_VERSION)/
PKG_HASH:=9767917d9f818faec4ddd763fe4a4ad9f6322c3d25da290ab2ea3e2ce4b52a7b

PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:libgd:libgd

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libgd/default
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libjpeg +libpng +libwebp +LIBGD_TIFF:libtiff +LIBGD_FREETYPE:libfreetype
  TITLE:=The GD graphics library
  URL:=https://libgd.github.io/
endef

define Package/libgd
  $(call Package/libgd/default)
  MENU:=1
  DEPENDS+=+LIBGD_TIFF:libtiff +LIBGD_FREETYPE:libfreetype
  VARIANT:=default
endef

define Package/libgd-full
  $(call Package/libgd/default)
  DEPENDS+=+libtiff +libfreetype
  TITLE+=(full)
  VARIANT:=full
endef

define Package/libgd/description/default
  GD is an open source code library for the dynamic creation of images by
  programmers. GD creates PNG, JPEG and GIF images, among other formats.
endef

Package/libgd/description=$(Package/libgd/description/default)

define Package/libgd-full/description
  $(call Package/libgd/description/default)
  .
  This variant of the libgd package is compiled will all features enabled.
endef

define Package/libgd/config
	if PACKAGE_libgd
		config LIBGD_TIFF
			bool "TIFF image support"
			default n
			help
				Enable TIFF image support through libtiff
	endif
	if PACKAGE_libgd
		config LIBGD_FREETYPE
			bool "Freetype 2.x library support"
			default n
			help
				Enable Freetype 2.x font engine support through libfreetype
	endif
endef

TARGET_CFLAGS += $(FPIC) -ffunction-sections -fdata-sections -flto

CMAKE_OPTIONS += \
	-DENABLE_FONTCONFIG=OFF \
	-DENABLE_ICONV=OFF \
	-DENABLE_JPEG=ON \
	-DENABLE_LIQ=OFF \
	-DENABLE_PNG=ON \
	-DENABLE_TIFF=$(if $(CONFIG_LIBGD_TIFF),ON,OFF) \
	-DENABLE_WEBP=ON \
	-DENABLE_XPM=OFF \
	-DZLIB_INCLUDE_DIR="$(STAGING_DIR)/opt"

ifeq ($(BUILD_VARIANT),full)
	CMAKE_OPTIONS += \
		-DENABLE_TIFF=ON \
		-DFREETYPE_INCLUDE_DIRS=$(STAGING_DIR)/opt/include/freetype2/ \
		-DENABLE_FREETYPE=ON

else

ifdef CONFIG_LIBGD_FREETYPE
	CMAKE_OPTIONS += \
		-DFREETYPE_INCLUDE_DIRS=$(STAGING_DIR)/opt/include/freetype2/ \
		-DENABLE_FREETYPE=ON
else
	CMAKE_OPTIONS += \
		-DENABLE_FREETYPE=OFF
endif

endif

define Build/InstallDev
	$(call Build/InstallDev/cmake,$(1))
	$(SED) 's,/opt/lib,$(STAGING_DIR)/opt/lib,g' $(1)/opt/lib/pkgconfig/gdlib.pc
	$(SED) 's,/opt/include,$(STAGING_DIR)/opt/include,g' $(1)/opt/lib/pkgconfig/gdlib.pc
endef

define Package/libgd/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libgd.so* $(1)/opt/lib/
endef

Package/libgd-full/install=$(Package/libgd/install)

$(eval $(call BuildPackage,libgd))
$(eval $(call BuildPackage,libgd-full))

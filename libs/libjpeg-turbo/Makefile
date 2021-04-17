include $(TOPDIR)/rules.mk

PKG_NAME:=libjpeg-turbo
PKG_VERSION:=2.0.6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/$(PKG_NAME)
PKG_HASH:=d74b92ac33b0e3657123ddcf6728788c90dc84dcb6a52013d758af3c4af481bb

PKG_MAINTAINER:=Rosen Penev <rosenp@gmail.com>
PKG_LICENSE:=BSD-3-Clause IJG zlib
PKG_LICENSE_FILES:=LICENSE.md

PKG_USE_MIPS16:=0 #Allows ASM compilation for speed.

include $(INCLUDE_DIR)/package.mk
include ../../devel/ninja/ninja-cmake.mk

define Package/libjpeg-turbo/Default
  TITLE:=libjpeg-turbo
  URL:=https://www.libjpeg-turbo.org/
endef

define Package/libjpeg-turbo
  $(call Package/libjpeg-turbo/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= runtime library
  PROVIDES:=libjpeg
endef

define Package/libjpeg-turbo-utils
  $(call Package/libjpeg-turbo/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Image Manipulation
  DEPENDS:=+libjpeg-turbo
  TITLE+= manipulation tools
  PROVIDES:=jpeg-tools
endef

define Package/libjpeg-turbo/description
	libjpeg-turbo is a speed focused fork of libjpeg.
endef

define Package/libjpeg-turbo-utils/description
	These are the JPEG utilities that come with libjpeg-turbo.
endef

CMAKE_OPTIONS += \
	-DENABLE_SHARED=ON \
	-DENABLE_STATIC=OFF \
	-DREQUIRE_SIMD=OFF \
	-DWITH_12BIT=OFF \
	-DWITH_ARITH_DEC=OFF \
	-DWITH_ARITH_ENC=OFF \
	-DWITH_JAVA=OFF \
	-DWITH_JPEG7=OFF \
	-DWITH_JPEG8=OFF \
	-DWITH_MEM_SRCDST=OFF \
	-DWITH_SIMD=O$(if $(findstring mips,$(CONFIG_ARCH)),FF,N) \
	-DWITH_TURBOJPEG=OFF

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libjpeg.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc $(1)/opt/lib/pkgconfig/
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/libjpeg.pc
	$(SED) 's,/opt/lib,$$$${exec_prefix}/lib,g' $(1)/opt/lib/pkgconfig/libjpeg.pc
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/libturbojpeg.pc
	$(SED) 's,/opt/lib,$$$${exec_prefix}/lib,g' $(1)/opt/lib/pkgconfig/libturbojpeg.pc
endef

define Package/libjpeg-turbo/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libjpeg.so* $(1)/opt/lib
endef

define Package/libjpeg-turbo-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/rdjpgcom $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/wrjpgcom $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/cjpeg $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/djpeg $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/jpegtran $(1)/opt/bin
endef

$(eval $(call BuildPackage,libjpeg-turbo))
$(eval $(call BuildPackage,libjpeg-turbo-utils))

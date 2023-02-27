#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=imagemagick
PKG_VERSION:=7.0.9
PKG_REVISION:=5
PKG_RELEASE:=4a
PKG_MAINTAINER:=Val Kulkov <val.kulkov@gmail.com>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REVISION).tar.gz
PKG_SOURCE_URL:=http://github.com/ImageMagick/ImageMagick/archive/$(PKG_VERSION)-$(PKG_REVISION)
PKG_HASH:=d15abd31e7e18f7edec47df156773a23e5100386e55c6ce50f5353e9572d3413
PKG_BUILD_DIR:=$(BUILD_DIR)/ImageMagick-$(PKG_VERSION)-$(PKG_REVISION)
PKG_FIXUP:=autoreconf

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:imagemagick:imagemagick

PKG_USE_MIPS16:=0
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/imagemagick/Default
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Image manipulation tools
  URL:=https://www.imagemagick.org/
endef

define Package/imagemagick
  $(call Package/imagemagick/Default)
  DEPENDS:=+libltdl +libpthread +zlib +libfreetype +libpng +libjpeg +libtiff
  DEPENDS+=+dejavu-fonts-ttf-DejaVuSans \
	+dejavu-fonts-ttf-DejaVuSans-Bold \
	+dejavu-fonts-ttf-DejaVuSans-BoldOblique \
	+dejavu-fonts-ttf-DejaVuSansCondensed \
	+dejavu-fonts-ttf-DejaVuSansCondensed-Bold \
	+dejavu-fonts-ttf-DejaVuSansCondensed-BoldOblique \
	+dejavu-fonts-ttf-DejaVuSansCondensed-Oblique \
	+dejavu-fonts-ttf-DejaVuSans-ExtraLight \
	+dejavu-fonts-ttf-DejaVuSansMono \
	+dejavu-fonts-ttf-DejaVuSansMono-Bold \
	+dejavu-fonts-ttf-DejaVuSansMono-BoldOblique \
	+dejavu-fonts-ttf-DejaVuSansMono-Oblique \
	+dejavu-fonts-ttf-DejaVuSans-Oblique \
	+dejavu-fonts-ttf-DejaVuSerif \
	+dejavu-fonts-ttf-DejaVuSerif-Bold \
	+dejavu-fonts-ttf-DejaVuSerif-BoldItalic \
	+dejavu-fonts-ttf-DejaVuSerifCondensed \
	+dejavu-fonts-ttf-DejaVuSerifCondensed-Bold \
	+dejavu-fonts-ttf-DejaVuSerifCondensed-BoldItalic \
	+dejavu-fonts-ttf-DejaVuSerifCondensed-Italic \
	+dejavu-fonts-ttf-DejaVuSerif-Italic
endef

define Package/imagemagick/description
ImageMagick is a free and open-source software suite for displaying,
converting, and editing raster image and vector image files.
NOTE: this package may not be suitable for many embedded devices because
of its large size. Consider using extroot or alternatively consider
graphicsmagick which is smaller but similar in functionality.
endef

define Package/imagemagick/conffiles
/opt/etc/ImageMagick-7/colors.xml
/opt/etc/ImageMagick-7/delegates.xml
/opt/etc/ImageMagick-7/log.xml
/opt/etc/ImageMagick-7/mime.xml
/opt/etc/ImageMagick-7/policy.xml
/opt/etc/ImageMagick-7/quantization-table.xml
/opt/etc/ImageMagick-7/thresholds.xml
/opt/etc/ImageMagick-7/type-apple.xml
/opt/etc/ImageMagick-7/type-dejavu.xml
/opt/etc/ImageMagick-7/type-ghostscript.xml
/opt/etc/ImageMagick-7/type-urw-base35.xml
/opt/etc/ImageMagick-7/type-windows.xml
/opt/etc/ImageMagick-7/type.xml
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--disable-static \
	--disable-docs \
	--enable-dependency-tracking \
	--with-modules \
	--with-threads \
	--with-ltdl \
	--with-zlib \
	--disable-hdri \
	--with-quantum-depth=8 \
	--disable-deprecated \
	--disable-cipher \
	--without-bzlib \
	--without-autotrace \
	--without-djvu \
	--without-dps \
	--without-fftw \
	--without-flif \
	--without-fpx \
	--without-fontconfig \
	--without-gslib \
	--without-gvc \
	--without-heic \
	--without-jbig \
	--without-lcms \
	--without-lqr \
	--without-lzma \
	--without-magick-plus-plus \
	--without-openexr \
	--without-openjp2 \
	--without-raqm \
	--without-raw \
	--without-webp \
	--without-x \
	--without-zstd \
	--without-gslib \
	--without-gvc \
	--without-pango \
	--without-perl \
	--without-rsvg \
	--without-wmf \
	--without-xml \
	--with-freetype \
	--with-jpeg \
	--with-png \
	--with-tiff \
	--with-gs-font-dir=/opt/share/fonts/type1/gsfonts \
	--with-dejavu-font-dir=/opt/share/fonts/ttf-dejavu

TARGET_CFLAGS += $(if $(filter-out 5 6 7 8 9,$(word 1,$(subst ., ,$(call qstrip,$(CONFIG_GCC_VERSION))))),,-flto)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/* \
		$(1)/opt/include/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.so* \
		$(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/* \
		$(1)/opt/lib/pkgconfig/

	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/*-config \
		$(1)/opt/bin/
	$(SED) 's|prefix=/opt|prefix=$(STAGING_DIR)/opt|' \
		$(1)/opt/bin/*-config
endef

IMlibdir:=opt/lib/ImageMagick-$(PKG_VERSION)
define Package/imagemagick/install
	$(INSTALL_DIR) $(1)/opt/etc $(1)/opt/bin $(1)/$(IMlibdir)
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so.* $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
	$(RM) $(1)/opt/bin/*-config
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/ImageMagick-* $(1)/opt/etc/
	$(CP) $(PKG_INSTALL_DIR)/$(IMlibdir)/* $(1)/$(IMlibdir)/
	# Entware specific:
	$(SED) 's,$(STAGING_DIR),,g;s,$(TOOLCHAIN_DIR),/opt,g; \
		s,$(STAGING_DIR_HOST),/opt,g; \
		s,-f\(file\|macro\)-prefix-map=$(PKG_BUILD_DIR)=ImageMagick-$(PKG_VERSION),,g' \
			$(1)/$(IMlibdir)/config-Q8/configure.xml
	$(FIND) $(1)/$(IMlibdir) -type f -a -name "*.la" -exec $(SED) \
		's,$(STAGING_DIR),,g;s,-L$(TOOLCHAIN_DIR)/lib ,,g' {} +
endef

$(eval $(call BuildPackage,imagemagick))

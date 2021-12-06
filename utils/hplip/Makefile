#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: hplip-common and hplip-sane merged into hplip-full
# We use sane-libs packages

include $(TOPDIR)/rules.mk

PKG_NAME:=hplip
PKG_VERSION:=3.21.6
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/hplip
PKG_HASH:=cc3360d3d913684fb080db97a434b04be45e2cef23cc5bc4cbc5f64b0c5e7bca

PKG_MAINTAINER:=Luiz Angelo Daros de Luca <luizluca@gmail.com>
PKG_LICENSE:=GPL-2.0 GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING LICENSE

PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:= python3 libcups
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-version.mk

define Package/hplip/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=HP Linux Imaging and Printing
  URL:=https://sourceforge.net/projects/hplip/
endef

define Package/hplip/Default/description
	HPLIP is an HP developed solution for printing, scanning, and faxing with HP inkjet and laser based printers in Linux.
endef

define Package/hplip-common
$(call Package/hplip/Default)
  TITLE+= (common files)
  DEPENDS+=+libusb-1.0
endef

define Package/hplip-common/description
$(call Package/hplip/Default/description)

These are common files shared between subpackages
endef

define Package/hplip-sane
$(call Package/hplip/Default)
  TITLE+= (scanner drivers)
  DEPENDS+=+sane-libs +hplip-common
endef

define Package/hplip-sane/description
$(call Package/hplip/Default/description)

S.A.N.E backend for HP Scanners
endef

define Package/hplip-full
$(call Package/hplip/Default)
  TITLE+= (full files)
  DEPENDS:=+libusb-compat +sane-libs +dbus +python3 +libcups
endef

define Package/hplip-full/description
$(call Package/hplip/Default/description)

These are full files shared between subpackages
endef

CONFIGURE_ARGS += \
	--disable-gui-build \
	--disable-network-build \
	--disable-fax-build \
	--disable-pp-build \
	--disable-doc-build \
	--disable-imageProcessor-build

ifneq ($(CONFIG_PACKAGE_hplip-full),m)
CONFIGURE_ARGS += \
	--disable-dbus-build \
	--disable-hpijs-only-build \
	--disable-hpcups-install \
	--disable-hpps-install \
	--disable-cups-drv-install \
	--enable-lite-build
endif

ifeq ($(CONFIG_PACKAGE_hplip-full),m)

PKG_INSTALL:=1

TARGET_CPPFLAGS += \
	-I$(STAGING_DIR)/opt/include/libusb-1.0 \
	-I$(STAGING_DIR)/opt/include/python$(PYTHON3_VERSION)

  define Build/Configure
	$(call Build/Configure/Default,\
		$(CONFIGURE_ARGS) \
		--enable-cups-ppd-install \
		--with-cupsbackenddir=/opt/lib/cups/backend \
		--with-cupsfilterdir=/opt/lib/cups/filter \
		--with-icondir=/opt/var \
		--with-systraydir=/opt/var \
		ac_cv_lib_cups_cupsDoFileRequest=yes \
		am_cv_python_version=$(PYTHON3_VERSION) \
		LIBS="-lz -ljpeg -lusb -lcups -lpng -ltiff" \
		PYTHON="$(STAGING_DIR_HOSTPKG)/bin/python3" \
		PYTHON_PREFIX="$(STAGING_DIR_HOSTPKG)" \
		PYTHON_EXEC_PREFIX="$(STAGING_DIR_HOSTPKG)" \
		PYTHON_PLATFORM="linux" \
		PYTHONINCLUDEDIR="$(STAGING_DIR)/opt/include/python$(PYTHON3_VERSION)" \
	)
  endef
endif

#define Build/Install
#	mkdir -p $(PKG_INSTALL_DIR)/usr/share/sane
#	sed -n -e '/key="usb.product_id"/{s/.*int_outof="0x//;s/;0x/\n/g;s/".*//;p}' \
#		$(PKG_BUILD_DIR)/data/rules/20-hplip-devices.fdi | sort -u > \
#		$(PKG_INSTALL_DIR)/usr/share/sane/03f0-hplip.usbid
#endef

define Package/hplip-common/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/.libs/libhpip.so* $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/.libs/libhpmud.so* $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/etc/hp
	$(CP) $(PKG_BUILD_DIR)/hplip.conf $(1)/etc/hp/hplip.conf

	$(INSTALL_DIR) $(1)/usr/share/hplip/data/models/
	$(CP) $(PKG_BUILD_DIR)/data/models/models.dat $(1)/usr/share/hplip/data/models/
endef

define Package/hplip-sane/install
	$(INSTALL_DIR) $(1)/usr/lib/sane
	$(CP) $(PKG_BUILD_DIR)/.libs/libsane-hpaio.so* $(1)/usr/lib/sane

	$(INSTALL_DIR) $(1)/etc/sane.d/dll.d/
	$(INSTALL_DATA) ./files/hplib.conf $(1)/etc/sane.d/dll.d/hplib

	$(INSTALL_DIR) $(1)/usr/share/sane
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/sane/03f0-hplip.usbid \
		$(1)/usr/share/sane/03f0-hplip.usbid
endef

define Package/hplip-full/install
	$(FIND) $(PKG_INSTALL_DIR)/opt/share/hplip -name *.py | $(XARGS) $(SED) \
		's,^#!.*python$$$$,#!/opt/bin/python3,'
	$(FIND) $(PKG_INSTALL_DIR)/opt -name *.py | $(XARGS) $(SED) 's,/usr/,/opt/,g'
#		's,\(/usr/\|/usr/local/\),/opt/,g'
	$(SED) 's,^#!.*python$$$$,#!/opt/bin/python3,;s,/usr/,/opt/,g' \
		$(PKG_INSTALL_DIR)/opt/lib/cups/filter/pstotiff

	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libhp{ip,ipp,mud}.so* $(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/lib/cups/{backend,filter}
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/cups/backend/hp $(1)/opt/lib/cups/backend
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/cups/filter/{hpcups,hpps,pstotiff} $(1)/opt/lib/cups/filter

	$(INSTALL_DIR) $(1)/opt/lib/sane
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/sane/libsane-hpaio.so* $(1)/opt/lib/sane

	$(INSTALL_DIR) $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/python$(PYTHON3_VERSION)/site-packages/{cups,hpmud,pcard,scan}ext.so $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages

	$(INSTALL_DIR) $(1)/opt/etc/hp
	$(SED) 's|/usr/|/opt/|g' $(PKG_INSTALL_DIR)/opt/etc/hp/hplip.conf
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/hp/hplip.conf $(1)/opt/etc/hp

	$(INSTALL_DIR) $(1)/opt/etc/sane.d/
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/sane.d/dll.conf $(1)/opt/etc/sane.d

	$(INSTALL_DIR) $(1)/opt/share/hal/fdi/preprobe/10osvendor
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/hal/fdi/preprobe/10osvendor/20-hplip-devices.fdi $(1)/opt/share/hal/fdi/preprobe/10osvendor

	$(INSTALL_DIR) $(1)/opt/share/cups/drv/hp/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/cups/drv/hp/hpcups.drv  $(1)/opt/share/cups/drv/hp/

	$(INSTALL_DIR) $(1)/opt/share/ppd/HP
	$(CP) $(PKG_INSTALL_DIR)/opt/share/ppd/HP/hp-*.ppd.gz $(1)/opt/share/ppd/HP

	$(INSTALL_DIR) $(1)/opt/share/hplip
	$(CP) $(PKG_INSTALL_DIR)/opt/share/hplip/* $(1)/opt/share/hplip

	$(INSTALL_DIR) $(1)/opt/etc/hotplug.d/usb/
	$(INSTALL_BIN) ./files/20-hplip $(1)/opt/etc/hotplug.d/usb/

	$(INSTALL_DIR) $(1)/opt/etc/sane.d/dll.d/
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/sane.d/dll.conf $(1)/opt/etc/sane.d/dll.d/hplib

	$(INSTALL_DIR) $(1)/opt/var/{lib,log}/hp
endef

define Package/hplip-common/conffiles
/etc/hp/hplip.conf
endef

define Package/hplip-sane/conffiles
/etc/sane.d/dll.d/hplib
endef

define Package/hplip-full/conffiles
/opt/etc/hp/hplip.conf
/opt/etc/sane.d/dll.d/hplib
endef

$(eval $(call BuildPackage,hplip-full))
#$(eval $(call BuildPackage,hplip-common))
#$(eval $(call BuildPackage,hplip-sane))

#
# Copyright (C) 2007-2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=glib2
PKG_VERSION:=2.66.4
PKG_RELEASE:=1

PKG_SOURCE:=glib-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@GNOME/glib/2.66
PKG_HASH:=97df8670e32f9fd4f7392b0980e661dd625012015d58350da1e58e343f4af984

PKG_MAINTAINER:=Peter Wagner <tripolar@gmx.at>
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:gnome:glib

PKG_BUILD_DIR:=$(BUILD_DIR)/glib-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/glib-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=meson/host gettext-full libiconv/host
HOST_BUILD_DEPENDS:=meson/host gettext-full/host libiconv/host libffi/host
PKG_CONFIG_DEPENDS:=CONFIG_BUILD_NLS
PKG_INSTALL:=1

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include ../../devel/meson/meson.mk

define Package/glib2
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=$(ICONV_DEPENDS) $(INTL_DEPENDS) +zlib +libpthread +libffi +libattr
  TITLE:=glib 2.0
  URL:=http://www.gtk.org/
endef

define Package/glib2/description
  The GLib library of C routines
endef

HOST_LDFLAGS += -liconv -Wl,-rpath,$(STAGING_DIR_HOSTPKG)/lib
TARGET_CFLAGS += -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections -liconv $(if $(INTL_FULL),-lintl)

COMP_ARGS= \
	-Ddefault_library=both \
	-Diconv=external \
	-Dselinux=disabled \
	-Dlibmount=disabled \
	-Dinternal_pcre=true \
	-Dman=false \
	-Ddtrace=false \
	-Dsystemtap=false \
	-Dgtk_doc=false \
	-Dbsymbolic_functions=true \
	-Dforce_posix_threads=true \
	-Dfam=false \
	-Dinstalled_tests=false \
	-Dnls=$(if $(CONFIG_BUILD_NLS),en,dis)abled \
	-Doss_fuzz=disabled \
	-Dglib_assert=false \
	-Dglib_checks=false

MESON_HOST_ARGS += $(COMP_ARGS) -Dxattr=false
MESON_ARGS += $(COMP_ARGS) -Dxattr=true -Db_lto=true

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/bin/* \
		$(1)/opt/bin/

	$(INSTALL_DIR) $(1)/opt/include
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/glib-2.0 \
		$(1)/opt/include/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/glib-2.0/include/*.h \
		$(1)/opt/include/glib-2.0/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/gio-unix-2.0 \
		$(1)/opt/include/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/glib-2.0 \
		$(1)/opt/lib/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.{so*,a} \
		$(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
ifneq ($(INTL_FULL),)
	$(SED) '/^Libs:/s/$$$$/ -lintl/' \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/glib-2.0.pc
endif
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc \
		$(1)/opt/lib/pkgconfig

	$(INSTALL_DIR) $(2)/share/aclocal/
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/aclocal/*.m4  \
		$(2)/share/aclocal/

	$(INSTALL_DIR) $(1)/opt/share/glib-2.0
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/share/glib-2.0/codegen \
		$(1)/opt/share/glib-2.0/
endef

define Package/glib2/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/*.so* \
		$(1)/opt/lib/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,glib2))

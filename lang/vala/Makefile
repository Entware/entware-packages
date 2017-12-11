#
# Copyright (C) 2006-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=vala
PKG_VERSION:=0.34.5
PKG_RELEASE:=1
PKG_LICENSE:=LGPL-2.1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@GNOME/vala/0.34/
PKG_HASH:=3fd4ba371778bc87da42827b8d23f1f42b0629759a9a1c40c9683dfb7e73fae5

PKG_BUILD_DEPENDS:=glib2 glib2/host vala/host
HOST_BUILD_DEPENDS:=glib2/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/host-build.mk

TARGET_LDFLAGS+=\
        -Wl,-rpath-link=$(STAGING_DIR)/opt/lib

define Package/vala
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=C-sharp like language for the GObject system
  URL:=https://wiki.gnome.org/Projects/Vala
  MAINTAINER:=Gergely Kiss <mail.gery@gmail.com>
  DEPENDS:=+glib2 +libpthread
endef

define Package/vala/description
Vala is a C-sharp like language for the GObject system. This package contains
the Vala-to-C compiler.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) \
		$(1)/opt/share/vala-0.34/vapi \
		$(1)/opt/lib \
		$(1)/opt/lib/pkgconfig

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/vala-0.34/vapi/* \
		$(1)/opt/share/vala-0.34/vapi

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/libvala-0.34.{so*,la} \
		$(1)/opt/lib

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc \
		$(1)/opt/lib/pkgconfig
endef

define Package/vala/install
	$(INSTALL_DIR) \
		$(1)/opt/share/vala-0.34/vapi \
		$(1)/opt/lib \
		$(1)/opt/lib/pkgconfig \
		$(1)/opt/bin

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/vala-0.34/vapi/* \
		$(1)/opt/share/vala-0.34/vapi

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/libvala-0.34.{so*,la} \
		$(1)/opt/lib

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/{vala,vala-0.34,valac,valac-0.34,vapicheck,vapicheck-0.34,vapigen,vapigen-0.34,vala-gen-introspect,vala-gen-introspect-0.34} \
		$(1)/opt/bin

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/lib/pkgconfig/*.pc \
		$(1)/opt/lib/pkgconfig
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,vala))

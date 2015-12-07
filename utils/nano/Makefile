#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Wrapping and syntax highlight enabled.

include $(TOPDIR)/rules.mk

PKG_NAME:=nano
PKG_VERSION:=2.4.2
PKG_RELEASE:=1c
PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.nano-editor.org/dist/v2.4
PKG_MD5SUM:=ce6968992fec4283c17984b53554168b

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nano
  SUBMENU:=Editors
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=An enhanced clone of the Pico text editor
  URL:=http://www.nano-editor.org/
  MAINTAINER:=Jonathan Bennett <JBennett@incomsystems.biz>
  DEPENDS:=+libncursesw +zlib +file
endef

define Package/nano/description
  GNU nano (Nano's ANOther editor, or Not ANOther editor) is an enhanced clone
  of the Pico text editor.
endef

CONFIGURE_ARGS += \
	--disable-glibtest \
	--enable-utf8 \
	--enable-wrapping \
	--enable-wrapping-as-root \
	--without-slang \

define Package/nano/conffiles
/opt/etc/nanorc
endef

define Package/nano/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/$(PKG_NAME) $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) $(PKG_BUILD_DIR)/doc/nanorc.sample $(1)/opt/etc/nanorc
	$(SED) 's,# include "/opt,include "/opt,g' $(1)/opt/etc/nanorc
	$(INSTALL_DIR) $(1)/opt/share/nano
	$(CP) $(PKG_INSTALL_DIR)/opt/share/nano/* $(1)/opt/share/nano
	for f in $(1)/opt/share/nano/*.nanorc; do \
		$(SED) 's/\\</\\b/g' $$$$f; \
		$(SED) 's/\\>/\\b/g' $$$$f; \
	done;
endef

$(eval $(call BuildPackage,nano))


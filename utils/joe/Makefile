#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# changes by Vitaly Prosko <villy TA sft TOD ru>:
#
#  - added new package joe-extra with all additional joe's stuff
#
# changes by Vitaly Prosko <villy TA sft TOD ru>:
#
#  - updated for new build system rules
#  - added static joerc config - no more defaults for native mode
#  - got maintenance role
#

include $(TOPDIR)/rules.mk

PKG_NAME:=joe
PKG_VERSION:=4.6
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/joe-editor
PKG_HASH:=495a0a61f26404070fe8a719d80406dc7f337623788e445b92a9f6de512ab9de

PKG_MAINTAINER:=Vitaly Protsko <villy@sft.ru>
PKG_LICENCE:=GPL-2.0
PKG_CPE_ID:=cpe:/a:joseph_allen:joe

include $(INCLUDE_DIR)/package.mk

define Package/joe
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Editors
  TITLE:=JOE - Joes own editor
  URL:=https://sourceforge.net/projects/joe-editor/
  DEPENDS:=+libncurses
endef

define Package/joe-extras
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Editors
  TITLE:=Extra data for JOE - Joes own editor
  URL:=https://sourceforge.net/projects/joe-editor/
  DEPENDS:=+joe
endef

define Package/joe/description
Joe is world-famous Wordstar like text editor, that also features
Emacs and Pico emulation
endef

define Package/joe-extras/description
Additional data for full Joe editor functionality
endef

define Package/joe/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/joe/joe $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/joe
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/rc/joerc $(1)/opt/etc/joe/joerc
endef

define Package/joe-extras/install
	$(INSTALL_DIR) $(1)/opt/etc/joe
	$(INSTALL_DIR) $(1)/opt/share/joe/{syntax,lang,charmaps,colors}
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/rc/{ftyperc,jicerc.ru,jmacsrc,jpicorc,jstarrc,rjoerc} $(1)/opt/etc/joe/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/syntax/*.jsf $(1)/opt/share/joe/syntax/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/po/*.po $(1)/opt/share/joe/lang/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/charmaps/klingon $(1)/opt/share/joe/charmaps/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/colors/*.jcf $(1)/opt/share/joe/colors/
endef

define Package/joe/conffiles
/opt/etc/joe/joerc
endef

define Package/joe-extras/conffiles
/opt/etc/joe/ftype
/opt/etc/joe/jicerc.ru
/opt/etc/joe/jmacsrc
/opt/etc/joe/jpicorc
/opt/etc/joe/jstarrc
/opt/etc/joe/rjoerc
endef

$(eval $(call BuildPackage,joe))
$(eval $(call BuildPackage,joe-extras))

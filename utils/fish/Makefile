# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=fish
PKG_VERSION:=3.5.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/fish-shell/fish-shell/releases/download/$(PKG_VERSION)
PKG_HASH:=291e4ec7c6c3fea54dc1aed057ce3d42b356fa6f70865627b2c7dfcecaefd210

PKG_MAINTAINER:=Curtis Jiang <jqqqqqqqqqq@gmail.com>, Hao Dong <halbertdong@gmail.com>
PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:fishshell:fish

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/fish
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Shells
  TITLE:=A smart and user-friendly command line shell
  DEPENDS:=+libncurses +libstdcpp +libatomic +libpcre2-32
  URL:=https://fishshell.com
endef

define Package/fish/description
  Fish is a smart and user-friendly command line shell for OS X, Linux, and the
  rest of the family. Fish includes features like syntax highlighting,
  autosuggest-as-you-type, and fancy tab completions that just work, with no
  configuration required.
endef

CMAKE_OPTIONS += \
	-DBUILD_DOCS=FALSE \
	-DWITH_GETTEXT=FALSE

define Package/fish/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/share/fish
	$(CP) $(PKG_INSTALL_DIR)/opt/share/fish/* $(1)/opt/share/fish/
	rm -rf $(1)/opt/share/fish/groff
	rm -rf $(1)/opt/share/fish/man
	rm -rf $(1)/opt/share/fish/tools
	$(CP) ./files/apropos $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/fish/conf.d
	$(CP) ./files/config.fish $(1)/opt/etc/fish/
	# Entware specific: fix exec path in scripts
	$(FIND) $(1)/opt/share -type f | $(XARGS) $(SED) \
		's,^#!.*fish,#!/opt/bin/fish,'
endef

#define Package/fish/postinst
##!/bin/sh
#grep fish $${IPKG_INSTROOT}/etc/shells || \
#    echo "/usr/bin/fish" >> $${IPKG_INSTROOT}/etc/shells

## Backwards compatibility
#if [ -e /bin/fish ] && { [ ! -L /bin/fish ] || [ "$(readlink -fn $${IPKG_INSTROOT}/bin/fish)" != "../$(CONFIGURE_PREFIX)/bin/fish" ]; }; then
#    ln -fs "../$(CONFIGURE_PREFIX)/bin/fish" "$${IPKG_INSTROOT}/bin/fish"
#fi
#endef

#define Package/fish/postrm
#	rm -rf "$${IPKG_INSTROOT}/$(CONFIGURE_PREFIX)/share/fish/$(PKG_VERSION)"
#endef

$(eval $(call BuildPackage,fish))

#
# Copyright (C) 2014-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=attr
PKG_VERSION:=2.5.1
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://git.savannah.nongnu.org/cgit/attr.git/snapshot
PKG_HASH:=69991b2fc5fe7917d996b05d5d4fe3c44d074c9d806dd263b14a42fab57bfc2f

PKG_MAINTAINER:=Maxim Storchak <m.storchak@gmail.com>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/attr/Default
  TITLE:=Extended attributes (xattr) manipulation
  URL:=http://savannah.nongnu.org/projects/attr
  SUBMENU:=Filesystem
endef

define Package/attr/Default/description
  Extended attributes support
endef

define Package/attr
$(call Package/attr/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+=utils
  LICENSE:=GPL-2.0-or-later
  LICENSE_FILES:=doc/COPYING
  DEPENDS:=+libattr
endef

define Package/libattr
$(call Package/attr/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+=library
  LICENSE:=LGPL-2.1-or-later
  LICENSE_FILES:=doc/COPYING.LGPL
endef

define Package/libattr/description
$(call Package/attr/Default/description)
 This package provides libattr
endef

define Package/attr/description
$(call Package/attr/Default/description)
 This package provides xattr manipulation utilities
 - attr
 - getfattr
 - setfattr
endef

CONFIGURE_ARGS += --enable-static --enable-shared

define Package/attr/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
endef

define Package/libattr/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) $(PKG_INSTALL_DIR)/opt/etc $(1)/opt/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
endef

define Package/attr/conffiles
/opt/etc/xattr.conf
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/{include,lib} $(1)/opt/
endef

$(eval $(call BuildPackage,attr))
$(eval $(call BuildPackage,libattr))

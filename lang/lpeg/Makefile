#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: bump to 1.1.0 / enable host build (neovim)

include $(TOPDIR)/rules.mk

PKG_NAME:=lpeg
PKG_VERSION:=1.1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=Dirk Chang <dirk@kooiot.com>
PKG_LICENSE:=MIT

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.inf.puc-rio.br/~roberto/lpeg/
PKG_HASH:=4b155d67d2246c1ffa7ad7bc466c1ea899bbc40fef0257cc9c03cecbaed4352a

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/lpeg
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=LPeg
  URL:=http://www.inf.puc-rio.br/~roberto/lpeg/
  DEPENDS:=+lua
endef

define Package/lpeg/description
	LPeg is a new pattern-matching library for Lua, based on Parsing Expression Grammars (PEGs)
endef

Host/Configure:=:

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/lib/lua/5.1
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/lpeg.so $(STAGING_DIR_HOSTPKG)/lib/lua/5.1
endef

define Build/Configure
endef

# add make variable overrides here
MAKE_FLAGS += \
	COPT="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -O2"

define Package/lpeg/install
	$(INSTALL_DIR) $(1)/opt/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lpeg.so $(1)/opt/lib/lua
endef

$(eval $(call BuildPackage,lpeg))
$(eval $(call HostBuild))

include $(TOPDIR)/rules.mk

PKG_NAME:=lua-ffi
PKG_VERSION:=1.3.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL=https://github.com/zhaojh329/lua-ffi/releases/download/v$(PKG_VERSION)
PKG_HASH:=718eaa7688ee85af6f8a5a7ac9cdf523e81c5a95a99ae81d8ae262b6622f1983

PKG_MAINTAINER:=Jianhui Zhao <zhaojh329@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/lua-ffi/default
  TITLE:=A portable lightweight C FFI for $(1), based on libffi
  CATEGORY:=Languages
  SECTION:=lang
  SUBMENU:=Lua
  DEPENDS:=+libffi
  URL:=https://github.com/zhaojh329/lua-ffi
endef

define Package/lua-ffi/default/description
  Lua-ffi is a portable lightweight C FFI for Lua, based on libffi
  and aiming to be mostly compatible with LuaJIT FFI, but written
  from scratch in C language.
endef

define Package/lua-ffi
  $(call Package/lua-ffi/default,lua5.1)
  DEPENDS+=+liblua
  VARIANT:=lua51
endef

define Package/lua-ffi-lua5.3
  $(call Package/lua-ffi/default,lua5.3)
  DEPENDS+=+liblua5.3
  VARIANT:=lua53
endef

define Package/lua-ffi-lua5.4
  $(call Package/lua-ffi/default,lua5.4)
  DEPENDS+=+liblua5.4
  VARIANT:=lua54
endef

Package/lua-ffi/description = $(Package/lua-ffi/default/description)
Package/lua-ffi-lua5.3/description = $(Package/lua-ffi/default/description)
Package/lua-ffi-lua5.4/description = $(Package/lua-ffi/default/description)

ifeq ($(BUILD_VARIANT),lua51)
  CMAKE_HOST_OPTIONS += -DLUA_INCLUDE_DIR="$(STAGING_DIR_HOSTPKG)/include"
  CMAKE_OPTIONS += -DLUA_INCLUDE_DIR="$(STAGING_DIR)/opt/include"
  LUA_INSTALL_DIR:=/opt/lib/lua
endif

ifeq ($(BUILD_VARIANT),lua53)
  CMAKE_HOST_OPTIONS += -DLUA_INCLUDE_DIR="$(STAGING_DIR_HOSTPKG)/include/lua5.3"
  CMAKE_OPTIONS += -DLUA_INCLUDE_DIR="$(STAGING_DIR)/opt/include/lua5.3"
  LUA_INSTALL_DIR:=/opt/local/lib/lua/5.3
endif

ifeq ($(BUILD_VARIANT),lua54)
  CMAKE_HOST_OPTIONS += -DLUA_INCLUDE_DIR="$(STAGING_DIR_HOSTPKG)/include/lua5.4"
  CMAKE_OPTIONS += -DLUA_INCLUDE_DIR="$(STAGING_DIR)/opt/include/lua5.4"
  LUA_INSTALL_DIR:=/opt/lib/lua/5.4
endif

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/lib/lua/5.1
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/ffi.so $(STAGING_DIR_HOSTPKG)/lib/lua/5.1
endef

define Package/lua-ffi/install
	$(INSTALL_DIR) $(1)$(LUA_INSTALL_DIR)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ffi.so $(1)$(LUA_INSTALL_DIR)
endef
Package/lua-ffi-lua5.3/install = $(Package/lua-ffi/install)
Package/lua-ffi-lua5.4/install = $(Package/lua-ffi/install)

$(eval $(call HostBuild))
$(eval $(call BuildPackage,lua-ffi))
#$(eval $(call BuildPackage,lua-ffi-lua5.3))
#$(eval $(call BuildPackage,lua-ffi-lua5.4))

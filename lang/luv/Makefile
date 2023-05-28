# Entware specific: bump version (neovim)

include $(TOPDIR)/rules.mk

PKG_NAME:=luv
PKG_VERSION:=1.43.0-0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/luvit/luv/releases/download/$(PKG_VERSION)
PKG_HASH:=567a6f3dcdcf8a9b54ddc57ffef89d1e950d72832b85ee81c8c83a9d4e0e9de2

PKG_MAINTAINER:=Morteza Milani <milani@pichak.co>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/luv
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Luv
  URL:=https://github.com/luvit/luv
  DEPENDS:=+libuv +!LUV_USE_LUAJIT_ENGINE:lua
endef

define Package/luv/description
  Bare libuv bindings for lua
endef

define Package/luv/config
	source "$(SOURCE)/Config.in"
endef

CMAKE_OPTIONS += \
	-DLUA_BUILD_TYPE=System \
	-DWITH_SHARED_LIBUV=ON \
	-DBUILD_MODULE=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DWITH_LUA_ENGINE=$(if $(CONFIG_LUV_USE_LUAJIT_ENGINE),Luajit,Lua)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/luv
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/include/luv/*.h $(1)/opt/include/luv
	$(INSTALL_DIR) $(1)/opt/lib/lua
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libluv.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libluv.pc $(1)/opt/lib/pkgconfig
	$(SED) 's,/opt/include,$$$${prefix}/include,g' $(1)/opt/lib/pkgconfig/libluv.pc
	$(SED) 's,/opt/lib,$$$${exec_prefix}/lib,g' $(1)/opt/lib/pkgconfig/libluv.pc
endef

define Package/luv/install
	$(INSTALL_DIR) $(1)/opt/lib/lua
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libluv.so.1.43.0 $(1)/opt/lib/lua/luv.so
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libluv.so.* $(1)/opt/lib
endef


$(eval $(call BuildPackage,luv))

#
# Copyright (C) 2007 OpenWrt
# Copyright (C) 2011-2020 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific - we use 1.2.x as more compatible

include $(TOPDIR)/rules.mk

PKG_NAME:=libtorrent-rasterbar
PKG_VERSION:=1.2.13
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/arvidn/libtorrent/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=976d2771ffcd564f08a63351e9c22e842aaa8cd29f6f7fe25d169c038a844e85

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
include $(INCLUDE_DIR)/nls.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-version.mk

define Package/libtorrent-rasterbar/Default
	TITLE:=Rasterbar BitTorrent library
	URL:=https://libtorrent.org/
endef

define Package/libtorrent-rasterbar
	$(call Package/libtorrent-rasterbar/Default)
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+boost-system +libatomic +libopenssl +libstdcpp $(ICONV_DEPENDS) $(INTL_DEPENDS)
endef

define Package/python3-libtorrent
	$(call Package/libtorrent-rasterbar/Default)
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE+= (Python 3)
	DEPENDS:=+libtorrent-rasterbar +boost-python3
endef

define Package/libtorrent-rasterbar/description
	Rasterbar libtorrent is a C++ library that aims to be a good alternative to
	all the other bittorrent implementations around.
endef

define Package/python3-libtorrent/description
	$(call Package/libtorrent-rasterbar/description)
	This package contains Python 3 bindings for the libtorrent-rasterbar library.
endef

TARGET_CXXFLAGS += -DBOOST_BIND_GLOBAL_PLACEHOLDERS

TARGET_LDFLAGS += -latomic $(if $(INTL_FULL),-liconv) $(if $(INTL_FULL),-lintl)

CMAKE_OPTIONS += \
	-Dpython-bindings:BOOL=ON \
	-DPYTHON_EXECUTABLE:FILEPATH=$(STAGING_DIR_HOSTPKG)/bin/python$(PYTHON3_VERSION) \
	-DPYTHON_SITE_PACKAGES="/opt/lib/python$(PYTHON3_VERSION)/site-packages" \
	-DPYTHON_EXT_SUFFIX=""

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libtorrent $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtorrent-rasterbar.so* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libtorrent-rasterbar.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libtorrent-rasterbar/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtorrent-rasterbar.so* $(1)/opt/lib
endef

define Package/python3-libtorrent/install
	$(INSTALL_DIR) $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/python$(PYTHON3_VERSION)/site-packages/*.so $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages
endef

$(eval $(call BuildPackage,libtorrent-rasterbar))
$(eval $(call BuildPackage,python3-libtorrent))

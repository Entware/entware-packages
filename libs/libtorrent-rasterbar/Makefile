# boost bumped

include $(TOPDIR)/rules.mk

PKG_NAME:=libtorrent-rasterbar
PKG_VERSION:=2.0.9
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/arvidn/libtorrent/releases/download/v$(PKG_VERSION)/
PKG_HASH:=90cd92b6061c5b664840c3d5e151d43fedb24f5b2b24e14425ffbb884ef1798e

PKG_MAINTAINER:=David Yang <mmyangfl@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

PYTHON3_PKG_BUILD:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
include ../../lang/python/python3-package.mk

define Package/libtorrent-rasterbar/Default
	TITLE:=Rasterbar BitTorrent library
	URL:=https://libtorrent.org/
endef

define Package/libtorrent-rasterbar
	$(call Package/libtorrent-rasterbar/Default)
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+boost-system +libatomic +libopenssl +libstdcpp
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

TARGET_LDFLAGS += -latomic -pthread

CMAKE_OPTIONS += \
	-Dpython-bindings=ON \
	-Dpython-egg-info=ON

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
	$(INSTALL_DIR) $(1)$(PYTHON3_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR)/* $(1)$(PYTHON3_PKG_DIR)
endef

$(eval $(call BuildPackage,libtorrent-rasterbar))
$(eval $(call BuildPackage,python3-libtorrent))

include $(TOPDIR)/rules.mk

PKG_NAME:=libtorrent-rasterbar
PKG_VERSION:=2.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/arvidn/libtorrent/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=cf906167e0b332681f6304a9bb740404a53bb0efed39897e1d2bd0f6f0d9e9cd

PKG_MAINTAINER:=David Yang <mmyangfl@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_PARALLEL:=1
CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-version.mk

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

define Download/try_signal
	VERSION:=2a99893f92b29a5948569cba1e16fd259dbc2016
	SUBDIR:=deps/try_signal
	FILE:=$(PKG_NAME)-try_signal-$$(VERSION).tar.xz
	URL:=https://github.com/arvidn/try_signal.git
	MIRROR_HASH:=4dee408897de3475e6f7eca9c4e4617c3e746351d01cec3cccac38b9b4d38302
	PROTO:=git
endef
$(eval $(call Download,try_signal))

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Build/Prepare
	$(Build/Prepare/Default)
	$(eval $(Download/try_signal))
	xzcat $(DL_DIR)/$(FILE) | tar -C $(PKG_BUILD_DIR) $(TAR_OPTIONS)
endef

TARGET_CXXFLAGS += -DBOOST_BIND_GLOBAL_PLACEHOLDERS

TARGET_LDFLAGS += -latomic

CMAKE_OPTIONS += \
	-Dpython-bindings=ON

#define Build/InstallDev
#	$(INSTALL_DIR) $(1)/opt/include
#	$(CP) $(PKG_INSTALL_DIR)/opt/include/libtorrent $(1)/opt/include/
#	$(INSTALL_DIR) $(1)/opt/lib
#	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtorrent-rasterbar.so* $(1)/opt/lib/
#	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
#	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libtorrent-rasterbar.pc $(1)/opt/lib/pkgconfig/
#endef

define Package/libtorrent-rasterbar/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libtorrent-rasterbar.so.* $(1)/opt/lib/
endef

define Package/python3-libtorrent/install
	$(INSTALL_DIR) $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/python$(PYTHON3_VERSION)/site-packages/*.so $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages
endef

$(eval $(call BuildPackage,libtorrent-rasterbar))
$(eval $(call BuildPackage,python3-libtorrent))

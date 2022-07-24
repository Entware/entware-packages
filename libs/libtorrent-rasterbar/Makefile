include $(TOPDIR)/rules.mk

PKG_NAME:=libtorrent-rasterbar
PKG_VERSION:=2.0.6
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/arvidn/libtorrent/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=75b17d9db3adf0da5896edeaff4db3879f38ee66be953dc9567089db83a070be

PKG_MAINTAINER:=David Yang <mmyangfl@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING

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

define Download/try_signal
	VERSION:=751a7e5a5be14892bcfdff1e63c653bcbf71cf39
	SUBDIR:=deps/try_signal
	FILE:=$(PKG_NAME)-try_signal-$$(VERSION).tar.xz
	URL:=https://github.com/arvidn/try_signal.git
	MIRROR_HASH:=32a432e35e81c79f21c49744f00696c112e0deab45d15d91c61ceb63fe25a5f8
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
	$(INSTALL_DIR) $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/python$(PYTHON3_VERSION)/site-packages/*.so $(1)/opt/lib/python$(PYTHON3_VERSION)/site-packages
endef

$(eval $(call BuildPackage,libtorrent-rasterbar))
$(eval $(call BuildPackage,python3-libtorrent))

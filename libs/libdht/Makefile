# Entware specific: link libdht statically. It is needed for old kernels.

include $(TOPDIR)/rules.mk

PKG_NAME:=libdht
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/jech/dht
PKG_SOURCE_DATE:=2023-03-18
PKG_SOURCE_VERSION:=0bbb8f4a5bd914b60de5e9fbb51573aa33a1cf18
PKG_MIRROR_HASH:=4a24bd406dd0ac9e69d75f062b45bc0d660f1f8bed9672afc35a7afe4b13acf4

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>

include $(INCLUDE_DIR)/package.mk

define Package/libdht
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Kademlia Distributed Hash Table (DHT) library
  BUILDONLY:=1
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/dht $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/dht.h $(1)/opt/include/dht
	$(CP) $(PKG_BUILD_DIR)/libdht.a $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libdht))

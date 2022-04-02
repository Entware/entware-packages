include $(TOPDIR)/rules.mk

PKG_NAME:=libupnp
PKG_VERSION:=1.14.12
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/pupnp
PKG_HASH:=091c80aada1e939c2294245c122be2f5e337cc932af7f7d40504751680b5b5ac

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:libupnp_project:libupnp

PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_libupnp-sample \
	CONFIG_IPV6

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libupnp/Default
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=http://pupnp.sourceforge.net/
endef

define Package/libupnp
  $(call Package/libupnp/Default)
  DEPENDS:=+libpthread
  TITLE:=UPnP SDK library
  MENU:=1
endef

define Package/libupnp/description
The portable SDK for UPnP Devices (libupnp) provides developers with an API and
open source code for building control points, devices, and bridges that are
compliant with Version 1.0 of the  Universal Plug and Play Device Architecture
Specification.
endef

define Package/libupnp-sample
  $(call Package/libupnp/Default)
  DEPENDS:=libupnp
  TITLE:=UPnP sample applications
endef

define Package/libupnp-sample/description
TVcontrolpoint & tvdevice sample applications run inside /opt/etc/upnp-tvdevice/
endef

CMAKE_OPTIONS += \
	-DBUILD_TESTING=OFF \
	-Dclient=ON \
	-Ddevice=ON \
	-Dwebserver=OFF \
	-Dssdp=ON \
	-Doptssdp=OFF \
	-Dsoap=ON \
	-Dgena=ON \
	-Dtools=ON \
	-Dipv6=O$(if $(CONFIG_IPV6),N,FF) \
	-Dunspecified_server=OFF \
	-Dopen_ssl=OFF \
	-Dblocking_tcp_connections=ON \
	-Dscriptsupport=OFF \
	-Dpostwrite=OFF \
	-Dreuseaddr=ON \
	-Dsamples=O$(if $(CONFIG_PACKAGE_libupnp-sample),N,FF) \
	-DDOWNLOAD_AND_BUILD_DEPS=OFF

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/upnp $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib{ixml,upnp}.{a,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/cmake
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/cmake/* $(1)/opt/lib/cmake
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libupnp.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libupnp/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib{ixml,upnp}.so.* $(1)/opt/lib/
endef

define Package/libupnp-sample/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/tv* $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/share/upnp
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/upnp/tv* $(1)/opt/share/upnp
endef

$(eval $(call BuildPackage,libupnp))
$(eval $(call BuildPackage,libupnp-sample))

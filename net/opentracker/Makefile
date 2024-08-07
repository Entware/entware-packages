# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=opentracker
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://erdgeist.org/gitweb/opentracker
PKG_SOURCE_DATE:=2021-08-23
PKG_SOURCE_VERSION:=110868ec4ebe60521d5a4ced63feca6a1cf0aa2a
PKG_MIRROR_HASH:=9c48e442c1ac28d9141146cdf58cd733cf82a18bbef7880df1c61231b01e1329

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=Beerware

PKG_BUILD_DEPENDS:=libowfat

include $(INCLUDE_DIR)/package.mk

define Package/opentracker/Default
  SUBMENU:=BitTorrent
  SECTION:=net
  CATEGORY:=Network
  TITLE:=opentracker
  URL:=http://erdgeist.org/arts/software/opentracker/
  DEPENDS:=+zlib +libpthread
endef

define Package/opentracker
$(call Package/opentracker/Default)
  VARIANT:=ipv4
endef

define Package/opentracker6
$(call Package/opentracker/Default)
  TITLE+= (IPv6 build)
  VARIANT:=ipv6
endef


define Package/opentracker-default/description
 opentracker - An open and free bittorrent tracker

 opentracker is an open and free bittorrent tracker project.
 It aims for minimal resource usage and is intended to run at your wlan router.
 Currently it is deployed as an open and free tracker instance.
 Read our free and open tracker blog and announce your torrents there
 (but do not hesitate to setup your own free trackers!).
endef

define Package/opentracker/description
 $(call Package/opentracker-default/description)

 This package contains the IPv4-build of opentracker.

endef

define Package/opentracker6/description
 $(call Package/opentracker-default/description)

 This package contains the IPv6-build of opentracker.

endef


MAKE_FLAGS += PREFIX="$(STAGING_DIR)/opt"

ifeq ($(BUILD_VARIANT),ipv6)
  MAKE_FLAGS += FEATURES="-DWANT_V6"
endif

define Package/opentracker/conffiles
/opt/etc/opentracker.conf
endef

define Package/opentracker6/conffiles
/opt/etc/opentracker6.conf
endef

define Package/opentracker/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/opentracker $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/opentracker.conf.sample $(1)/opt/etc/opentracker.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S78opentracker $(1)/opt/etc/init.d
endef

define Package/opentracker6/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/opentracker $(1)/opt/bin/opentracker6
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/opentracker.conf.sample $(1)/opt/etc/opentracker6.conf
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S78opentracker6 $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,opentracker))
$(eval $(call BuildPackage,opentracker6))

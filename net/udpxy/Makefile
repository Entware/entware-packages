include $(TOPDIR)/rules.mk

PKG_NAME:=udpxy
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pcherenkov/udpxy
PKG_SOURCE_DATE:=2024-03-03
PKG_SOURCE_VERSION:=23b434374d76e5de74138d44cbb8bda1b32dcfe0
PKG_MIRROR_HASH:=719dd6f667f2f92e2b0d911e6bc5dd191e4ee719dd199f648e89832de960f16a

PKG_MAINTAINER:=Álvaro Fernández Rojas <noltari@gmail.com>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=chipmunk/gpl.txt

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

MAKE_PATH:=chipmunk

define Package/udpxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Convert UDP IPTV streams into HTTP streams
  URL:=https://github.com/pcherenkov/udpxy
endef

define Package/udpxy/description
	udproxy makes it possible to convert UDP IPTV streams into HTTP
	streams which can be viewed even over WLANs. HTTP streams do
	not generate huge amounts of multicast traffic, so a sd stream
	only takes about 300k. Interesting for peoply who have IPTV at
	home and do not want to rent multiple decoders from their
	provider but just use their own streaming client (for example
	popcornhour/mediatomb/vlc).
endef

MAKE_FLAGS += \
	INSTALLROOT="$(PKG_INSTALL_DIR)/opt" \
	ALL_CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)"

define Package/udpxy/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
#	$(INSTALL_CONF) ./files/udpxy.conf $(1)/etc/config/udpxy
	$(INSTALL_BIN) ./files/S29udpxy $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/udpxy $(1)/opt/bin/
	ln -sf udpxy $(1)/opt/bin/udpxrec
endef

$(eval $(call BuildPackage,udpxy))

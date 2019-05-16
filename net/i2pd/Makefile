#
# Copyright (C) 2015, 2016 gxcreator
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=i2pd
PKG_VERSION:=2.24.0
PKG_RELEASE:=1
PKG_BUILD_PARALLEL:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/PurpleI2P/i2pd/tar.gz/$(PKG_VERSION)?
PKG_HASH:=809b37100f0f176432b01ab6edee96dc62b0f65d5bf7531e008a87117e742566

PKG_MAINTAINER:=David Yang <mmyangfl@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/i2pd
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libopenssl +boost +boost-system +boost-filesystem \
	         +boost-program_options +boost-date_time +libatomic +zlib
	TITLE:=full-featured C++ implementation of I2P client
	URL:=https://github.com/PurpleI2P/i2pd
#	USERID:=i2pd:i2pd
endef

define Package/i2pd/description
	I2P (Invisible Internet Protocol) is a universal anonymous network layer. All
	communications over I2P are anonymous and end-to-end encrypted, participants
	don't reveal their real IP addresses.
endef

define Package/i2pd/conffiles
/opt/etc/i2pd/i2pd.conf
/opt/etc/i2pd/tunnels.conf
endef

TARGET_LDFLAGS+=-latomic
MAKE_FLAGS+=USE_AESNI=no USE_AVX=no

define Package/i2pd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/i2pd $(1)/opt/sbin
#	$(INSTALL_DIR) $(1)/usr/share/i2pd
#	$(CP) $(PKG_BUILD_DIR)/contrib/certificates  $(1)/usr/share/i2pd
	$(INSTALL_DIR) $(1)/opt/etc/i2pd
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/contrib/i2pd.conf $(1)/opt/etc/i2pd
	$(SED) 's/127.0.0.1/192.168.1.1/g' $(1)/opt/etc/i2pd/i2pd.conf
#	$(INSTALL_BIN) $(PKG_BUILD_DIR)/contrib/subscriptions.txt $(1)/etc/i2pd
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/contrib/tunnels.conf $(1)/opt/etc/i2pd
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S30i2p $(1)/opt/etc/init.d
	###
	$(INSTALL_DIR) $(1)/opt/var/lib/i2pd
	$(CP) $(PKG_BUILD_DIR)/contrib/certificates $(1)/opt/var/lib/i2pd/
endef

$(eval $(call BuildPackage,i2pd))

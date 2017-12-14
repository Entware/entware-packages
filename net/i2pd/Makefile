#
# Copyright (C) 2015, 2016 gxcreator
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=i2pd
PKG_VERSION:=2.17.0
PKG_REV:=1c970b07147908fd2351577f09298fa82601f7a2
PKG_RELEASE:=1
PKG_BUILD_PARALLEL:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/orignal/i2pd
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_MIRROR_HASH:=e9dee670dc53d258919e1fb9444fcaeab0d380c438e71cd5323f08332b937918
PKG_LICENSE:=BSD-3-clause

include $(INCLUDE_DIR)/package.mk

define Package/i2pd
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libopenssl +boost +boost-system +boost-filesystem +boost-regex \
		 +boost-program_options +boost-date_time +libatomic +zlib
	TITLE:=full-featured C++ implementation of I2P client
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=David Yang <mmyangfl@gmail.com>
endef

define Package/i2pd/description
	I2P (Invisible Internet Protocol) is a universal anonymous network layer. All
	communications over I2P are anonymous and end-to-end encrypted, participants
	don't reveal their real IP addresses.
endef

define Package/i2pd/conffiles
	/opt/etc/i2pd.conf
	/opt/var/lib/i2pd/subscriptions.txt
	/opt/etc/tunnels.conf
endef

MAKE_FLAGS+=USE_AESNI=no USE_AVX=no

define Package/i2pd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/i2pd $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/contrib/i2pd.conf $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/contrib/tunnels.conf \
		$(1)/opt/etc/i2pd_tunnels.conf
	$(INSTALL_BIN) ./files/S30i2p $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/var/lib/i2pd
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/contrib/subscriptions.txt \
		$(1)/opt/var/lib/i2pd
	$(CP) $(PKG_BUILD_DIR)/contrib/certificates \
		$(1)/opt/var/lib/i2pd
endef

define Package/i2pd/postinst
#!/bin/sh

[ -f /opt/etc/i2p.conf ] || exit 0
echo 'Please note: new path of configuration file is /opt/etc/i2pd.conf'
echo 'You may check /opt/etc/i2p.conf for custom options and delete it as obsolete.'
endef

$(eval $(call BuildPackage,i2pd))

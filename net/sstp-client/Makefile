#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sstp-client
PKG_VERSION:=1.0.19
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.com/sstp-project/sstp-client/-/archive/1.0.19/
PKG_HASH:=e2652365f69f5037102e78f4e115ff764a390b27bb3fd513a8a50b10a61bb613

PKG_MAINTAINER:=Federico Di Marco <fededim@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/sstp-client
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  DEPENDS=+libevent2 +libopenssl +ppp +resolveip
  TITLE:=SSTP-Client is a SSTP client for Linux.
  URL:=http://sstp-client.sourceforge.net/
endef

define Package/sstp-client/description
The advantage of SSTP compared to other vpn protocols like PPTP and L2TP is that it cannot be easily blocked by firewalls since the traffic is transmitted over HTTPS on port 443.
This software has a similar commandline and configuration to the standard linux pptp-client software.

Features:
- Connect to Microsoft RAS network using SSTP
- Use HTTPS with strong encryption over port 443
- Asynchronous HDLC frame support
- Integration with pon/poff

endef

define Package/sstp-client/conffiles
/opt/etc/ppp/chap-secrets
/opt/etc/ppp/peers/peer-sstp-example-nopty.txt
/opt/etc/ppp/peers/peer-sstp-example.txt
endef

TARGET_CPPFLAGS += -I$(PKG_BUILD_DIR)/include

define Package/sstp-client/install
	$(INSTALL_DIR) $(1)/opt/{bin,lib}
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/.libs/sstpc $(1)/opt/bin/
	$(CP) $(PKG_BUILD_DIR)/src/libsstp-api/.libs/*.so* $(1)/opt/lib/
	$(CP) $(PKG_BUILD_DIR)/src/pppd-plugin/.libs/*.so* $(1)/opt/lib/

	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) files/etc $(1)/opt/
#	$(INSTALL_DIR) $(1)/lib/netifd/proto
#	$(INSTALL_BIN) ./files/lib/netifd/proto/sstp.sh $(1)/lib/netifd/proto
endef

$(eval $(call BuildPackage,sstp-client))

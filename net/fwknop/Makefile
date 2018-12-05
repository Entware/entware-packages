#
# Copyright (C) 2011-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=fwknop
PKG_VERSION:=2.6.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.cipherdyne.org/fwknop/download
PKG_HASH:=f6c09bec97ed8e474a98ae14f9f53e1bcdda33393f20667b6af3fb6bb894ca77
PKG_MAINTAINER:=Jonathan Bennett <JBennett@incomsystems.biz>
PKG_LICENSE:=GPLv2+
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/fwknop/Default
  TITLE:=FireWall KNock OPerator
  URL:=https://www.cipherdyne.org/fwknop/
endef

define Package/fwknop/Default/description
  Fwknop implements an authorization scheme known as Single Packet Authorization
  (SPA) for Linux systems running iptables.  This mechanism requires only a
  single encrypted and non-replayed packet to communicate various pieces of
  information including desired access through an iptables policy. The main
  application of this program is to use iptables in a default-drop stance to
  protect services such as SSH with an additional layer of security in order to
  make the exploitation of vulnerabilities (both 0-day and unpatched code) much
  more difficult.
endef

define Package/fwknopd
  $(call Package/fwknop/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Firewall
  TITLE+= Daemon
  DEPENDS:=+libfko +!FWKNOPD_NFQ_CAPTURE:libpcap +FWKNOP_GPG:gnupg
endef

define Package/fwknopd/description
  $(call Package/fwknop/Default/description)
  This package contains the fwknop daemon.
endef

define Package/fwknopd/conffiles
/opt/etc/fwknop/access.conf
/opt/etc/fwknop/fwknopd.conf
/opt/etc/config/fwknopd
endef

define Package/fwknopd/config
	source "$(SOURCE)/Config.in"
endef

define Package/fwknop
  $(call Package/fwknop/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Firewall
  TITLE+= Client
  DEPENDS:=+libfko
endef

define Package/fwknop/description
  $(call Package/fwknop/Default/description)
  This package contains the fwknop client.
endef

define Package/libfko
  $(call Package/fwknop/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Firewall
  TITLE+= Library
endef

define Package/libfko/description
  $(call Package/fwknop/Default/description)
  This package contains the libfko shared library.
endef


ifneq ($(CONFIG_FWKNOPD_GPG),y)
	CONFIGURE_ARGS += --without-gpgme 
endif

ifeq ($(CONFIG_FWKNOPD_NFQ_CAPTURE),y)
	CONFIGURE_ARGS += --enable-nfq-capture
endif

CONFIGURE_ARGS += \
	--with-iptables=/opt/sbin/iptables \
	--disable-stack-protector \
	--disable-fortify-source

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/fko.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfko.{a,la,so*} $(1)/opt/lib/
endef

define Package/fwknopd/install
	$(INSTALL_DIR) $(1)/opt/etc/fwknop
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/fwknop/{access,fwknopd}.conf \
		$(1)/opt/etc/fwknop/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S05fwknopd $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/fwknopd $(1)/opt/sbin/
endef

define Package/fwknop/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/fwknop $(1)/opt/bin/
endef

define Package/libfko/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libfko.so.* $(1)/opt/lib/
endef

$(eval $(call BuildPackage,fwknopd))
$(eval $(call BuildPackage,fwknop))
$(eval $(call BuildPackage,libfko))

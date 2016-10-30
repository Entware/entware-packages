#
# Copyright (C) 2009-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=netatalk
PKG_VERSION:=3.1.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/netatalk
PKG_MD5SUM:=2b40161985bb32cff5660bf689a4704f15c33bb87565efc7805dd5c75ad1fcc7

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/netatalk
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Filesystem
  DEPENDS:=+libevent2 +libdb47 +libgcrypt +libopenssl
  TITLE:=netatalk
  URL:=http://netatalk.sourceforge.net
  MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
endef

define Package/netatalk/decription
  Netatalk is a freely-available Open Source AFP fileserver.
  It also provides a kernel level implementation of the AppleTalk
  Protocol Suite.
endef

define Package/netatalk/conffiles
/opt/etc/afp.conf
/opt/etc/dbus-session.conf
/opt/etc/extmap.conf
endef

CONFIGURE_ARGS += \
	--disable-admin-group \
	--disable-zeroconf \
	--disable-debugging \
	--disable-tcp-wrappers \
	--disable-shell-check \
	--with-mysql-config=false \
	--with-cnid-default-backend=dbd \
	--without-pam \
	$(if $(CONFIG_SHADOW_PASSWORDS),--with-shadow,--without-shadow) \
	--with-uams-path="/opt/lib/uams" \
	--with-libgcrypt-dir="$(STAGING_DIR)/opt" \
	--with-ssl-dir="$(STAGING_DIR)/opt" \
	--with-bdb="$(STAGING_DIR)/opt/" \
	--without-ldap \
	--without-acls \
	--without-kerberos \
	--with-libevent-header="$(STAGING_DIR)/opt/include/event2" \
	--with-libevent-lib="$(STAGING_DIR)/opt/lib" \
	--with-lockfile=/opt/var/lock

define Package/netatalk/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
	    $(PKG_INSTALL_DIR)/opt/bin/{ad,afpldaptest,afppasswd,dbd} \
	    $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/*.conf $(1)/opt/etc
	$(INSTALL_BIN) ./files/{S26cnid_metad,S27afpd} $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/lib/uams
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/uams/*.so $(1)/opt/lib/uams
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) \
	    $(PKG_INSTALL_DIR)/opt/sbin/{afpd,cnid_dbd,cnid_metad,netatalk} \
	    $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/var/netatalk/CNID
endef

$(eval $(call BuildPackage,netatalk))

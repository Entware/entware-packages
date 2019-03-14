#
# Copyright (C) 2009-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=netatalk
PKG_VERSION:=3.1.12
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/netatalk
PKG_HASH:=1560f83a3da41be97e0b70a96e2402159b8ddc631d38538360b14784beada5d1

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

PKG_BUILD_DEPENDS:=libevent2

include $(INCLUDE_DIR)/package.mk

define Package/netatalk
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Filesystem
  DEPENDS:=+libattr +libdb47 +libgcrypt +libopenssl
  TITLE:=netatalk
  URL:=http://netatalk.sourceforge.net
  MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>
endef

define Package/netatalk/decription
  Netatalk is a freely-available Open Source AFP fileserver.
  It also provides a kernel level implementation of the AppleTalk
  Protocol Suite.
endef

TARGET_CFLAGS += -std=gnu99

CONFIGURE_ARGS += \
	--disable-afs \
	--enable-hfs \
	--disable-debugging \
	--disable-shell-check \
	--disable-timelord \
	--disable-a2boot \
	--disable-cups \
	--disable-tcp-wrappers \
	--with-cnid-default-backend=dbd \
	--with-bdb="$(STAGING_DIR)/opt/" \
	--with-libevent=no \
	--with-libgcrypt-dir="$(STAGING_DIR)/opt" \
	--with-ssl-dir="$(STAGING_DIR)/opt" \
	--with-uams-path="/opt/lib/uams" \
	--without-acls \
	--without-kerberos \
	--without-mysql \
	--with-mysql-config=false \
	--without-pam \
	--disable-admin-group \
	--disable-srvloc \
	--disable-zeroconf \
	$(if $(CONFIG_SHADOW_PASSWORDS),--with-shadow,--without-shadow) \
	--without-ldap \
	--with-libevent-header="$(STAGING_DIR)/opt/include/event2" \
	--with-libevent-lib="$(STAGING_DIR)/opt/lib" \
	--with-lockfile=/opt/var/lock

define Package/netatalk/conffiles
/opt/etc/afp.conf
/opt/etc/extmap.conf
/opt/etc/dbus-session.conf
endef

define Package/netatalk/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/lib/uams
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libatalk.so* $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/dbd $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ad $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/afppasswd $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/afpd $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/cnid_dbd $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/cnid_metad $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/uams/*.so $(1)/opt/lib/uams/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/*.conf $(1)/opt/etc/
	$(INSTALL_BIN) ./files/{S26cnid_metad,S27afpd} $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/var/netatalk/CNID
endef

$(eval $(call BuildPackage,netatalk))

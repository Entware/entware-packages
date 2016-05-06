#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=seafile-ccnet
PKG_VERSION:=5.1.1
PKG_RELEASE=1
PKG_LICENSE:=GPL-3.0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/haiwen/ccnet.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=5ab709ec0960428c9916dd5ecc65530d206a7dd2
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/seafile-ccnet
    SECTION:=net
    CATEGORY:=Network
    TITLE:=Seafile server - ccnet component
    MAINTAINER:=Gergely Kiss <mail.gery@gmail.com>
    URL:=http://seafile.com/
    DEPENDS:=+libsearpc +libevent2 +libopenssl \
		+glib2 +python +libzdb +libuuid \
		+libpthread +libsqlite3 +jansson $(ICONV_DEPENDS)
endef

define Package/seafile-ccnet/description
   Ccnet is a framework for writing networked applications in C.
endef

CONFIGURE_ARGS += --disable-client \
		    --enable-server \
		    --disable-ldap \
		    --disable-cluster \
		    --enable-python \
		    --disable-server-pkg \
		    --disable-static-build \
		    --disable-compile-demo \
		    --disable-console

PKG_BUILD_DEPENDS:=vala/host \
		   libsearpc/host

TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/opt/lib -liconv \
		    -L$(STAGING_DIR)/opt/lib/mysql -lmysqlclient -lz

MAKE_VARS += LC_ALL= LANG=en_US.UTF-8


define Package/seafile-ccnet/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/python2.7/site-packages
	$(INSTALL_DIR) $(1)/opt/share/seafile/seafile-server/seafile/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/ccnet* $(1)/opt/share/seafile/seafile-server/seafile/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/python2.7/site-packages/ccnet $(1)/opt/lib/python2.7/site-packages
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libccnet.so* $(1)/opt/lib
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/include/ccnet* $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libccnet.pc $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libccnet.a $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libccnet.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,seafile-ccnet))

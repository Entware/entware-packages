#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# NOTE: make sure to update EXTRA_DEPENDS in case of version/release changes!

include $(TOPDIR)/rules.mk

PKG_NAME:=seafile-server
PKG_VERSION:=5.0.6
PKG_RELEASE=1
PKG_LICENSE:=GPL-3.0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/haiwen/seafile.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=b6891b40a002515355aa2b0d475e822c543d30e9
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/seafile-server
    SECTION:=net
    CATEGORY:=Network
    TITLE:=Seafile server
    MAINTAINER:=Gergely Kiss <mail.gery@gmail.com>
    URL:=http://seafile.com/
    DEPENDS:=+libarchive +libopenssl +glib2 +libsearpc +seafile-ccnet +seafile-seahub \
		+sqlite3-cli +python-mysql +jansson +libevent2 +libevent2-openssl +zlib +libzdb +libsqlite3 \
		+libmysqlclient +libpthread +libuuid \
		+bash +procps-ng +procps-ng-pkill $(ICONV_DEPENDS)
endef

define Package/seafile-server/description
   Open source cloud storage with advanced features on privacy protection and teamwork.
endef

define Package/seafile-server/conffiles
/etc/config/seafile
endef

CONFIGURE_ARGS += --disable-riak \
		    --disable-client \
		    --disable-fuse \
		    --enable-server \
		    --enable-python \
		    --disable-static-build \
		    --disable-server-pkg \
		    --disable-console

PKG_BUILD_DEPENDS:=vala/host \
		    libsearpc/host \
		    libevhtp-1.1

TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/opt/lib -liconv \
		    -L$(STAGING_DIR)/opt/lib/mysql -lmysqlclient -lz

MAKE_VARS += LC_ALL= LANG=en_US.UTF-8

define Build/Configure
	$(call Build/Configure/Default,)
	find $(PKG_BUILD_DIR)/scripts -name *.sh | xargs $(SED) 's|/bin/bash|/opt/bin/bash|'
	find $(PKG_BUILD_DIR)/scripts -name *.sh | xargs $(SED) 's|SCRIPT=.*|SCRIPT=/opt/share/seafile/seafile-server/0.sh|'
endef

define Package/seafile-server/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/python2.7/site-packages
	$(INSTALL_DIR) $(1)/opt/share/seafile/seafile-server/runtime
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/share/seafile/seafile-server/seafile/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/share/seafile/seafile-server/seafile/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/python2.7/site-packages/seafile/ $(1)/opt/lib/python2.7/site-packages
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/python2.7/site-packages/seaserv/ $(1)/opt/lib/python2.7/site-packages
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libseafile.so* $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/scripts/sea{f-fsck,f-fuse,f-gc,file,hub}.sh $(1)/opt/share/seafile/seafile-server
	$(CP) $(PKG_BUILD_DIR)/scripts/setup-{seafile-mysql,seafile}.sh $(1)/opt/share/seafile/seafile-server
	$(CP) $(PKG_BUILD_DIR)/scripts/reset-admin.sh $(1)/opt/share/seafile/seafile-server
	$(CP) $(PKG_BUILD_DIR)/scripts/{check_init_admin,setup-seafile-mysql}.py $(1)/opt/share/seafile/seafile-server
	$(CP) $(PKG_BUILD_DIR)/scripts/seahub.conf $(1)/opt/share/seafile/seafile-server/runtime
	$(INSTALL_BIN) ./files/S66seafile $(1)/opt/etc/init.d/
	$(INSTALL_BIN) ./files/S67seahub  $(1)/opt/etc/init.d/
endef

define Package/seafile-server/postinst
#!/bin/sh
    rm -rf /opt/tmp/seahub_cache
    if [ ! -d /opt/share/seafile/seafile-data ]
    then
	echo "*** Installation completed, running configuration script..."
	/opt/share/seafile/seafile-server/setup-seafile.sh
    else
	echo "*** It seems you are upgrading from an older version."
	echo "*** If so, please run the appropriate upgrade scripts before using the new version of Seafile."
	echo "*** For more information, please read http://manual.seafile.com/"
    fi
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/include/seafile/ $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libseafile.pc $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libseafile.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,seafile-server))

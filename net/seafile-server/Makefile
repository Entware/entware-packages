#
# Copyright (C) 2007-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# NOTE: make sure to update EXTRA_DEPENDS in case of version/release changes!

include $(TOPDIR)/rules.mk

PKG_NAME:=seafile-server
PKG_VERSION:=6.3.4
PKG_RELEASE:=6
PKG_LICENSE:=GPL-3.0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/haiwen/seafile-server/tar.gz/v$(PKG_VERSION)-server?
PKG_HASH:=1ba4c641bad8d7592fd2592827e81470c88b8e802707d2b1e6d551c16d0da100
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-server
PKG_MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include ../../lang/python/python-package.mk

# Check that the actual Makefile version-relase match the above.
$(eval $(shell awk '/^PKG_VERSION.*=/ { print "SEAHUB_" $$$$0 }' ../seafile-seahub/Makefile))
ifneq ($(PKG_VERSION),$(SEAHUB_PKG_VERSION))
    $(error $(if $(SEAHUB_PKG_VERSION), \
		Version mismatch between seafile-seahub ($(SEAHUB_PKG_VERSION)) and \
		seafile-server ($(PKG_VERSION)), \
		Could not get PKG_VERSION from seafile-seahub Makefile))
endif

define Package/seafile-server
    SECTION:=net
    CATEGORY:=Network
    TITLE:=Seafile server
    URL:=https://seafile.com/
    DEPENDS:=+libarchive +libopenssl +glib2 +libsearpc +seafile-ccnet +seafile-seahub +sqlite3-cli \
		+python-mysqlclient +python-urllib3 \
		+jansson +libevent2 +libevent2-openssl +zlib +libzdb +libsqlite3 +libmysqlclient +oniguruma \
		+libpthread +libuuid +bash +procps-ng +procps-ng-pkill +SEAFILE_FUSE_SUPPORT:libfuse $(ICONV_DEPENDS)
    MENU:=1
endef

define Package/seafile-server/config
	source "$(SOURCE)/Config.in"
endef

define Package/seafile-server/description
   Open source cloud storage with advanced features on privacy protection and teamwork.
endef

CONFIGURE_ARGS += --enable-python

ifeq ($(CONFIG_SEAFILE_FUSE_SUPPORT),y)
	CONFIGURE_ARGS += --enable-fuse
	TARGET_CFLAGS += -I$(STAGING_DIR)/opt/include/fuse
else
	CONFIGURE_ARGS += --disable-fuse
endif

ifeq ($(CONFIG_SEAFILE_CONSOLE_SUPPORT),y)
	CONFIGURE_ARGS += --enable-console
else
	CONFIGURE_ARGS += --disable-console
endif

PKG_BUILD_DEPENDS:=vala/host libevhtp

# This is required as python-package.mk overrides the default setting of having interlinking enabled
ifdef CONFIG_USE_MIPS16
	TARGET_CFLAGS += -minterlink-mips16
endif
TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/opt/lib -liconv \
		    -L$(STAGING_DIR)/opt/lib/mysql -lmysqlclient -lz -levent_openssl -levent

ifdef CONFIG_GCC_LIBSSP
TARGET_LDFLAGS += -lssp
endif

MAKE_VARS += LC_ALL= LANG=en_US.UTF-8

define Package/seafile-server/conffiles
/opt/etc/config/seafile
endef

define Build/Configure
	$(call Build/Configure/Default,)
	find $(PKG_BUILD_DIR)/scripts -name *.sh | xargs $(SED) 's|/bin/bash|/opt/bin/bash|'
	find $(PKG_BUILD_DIR)/scripts -name *.sh | xargs $(SED) 's|SCRIPT=.*|SCRIPT=/opt/share/seafile/seafile-server/0.sh|'
endef

define Package/seafile-server/install
	$(INSTALL_DIR) $(1)/opt/{bin,lib}
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DIR) $(1)/opt/share/seafile/seafile-server/runtime
	$(INSTALL_DIR) $(1)/opt/share/seafile/seafile-server/seafile
	$(INSTALL_DIR) $(1)/opt/share/seafile/conf
	$(INSTALL_DIR) $(1)/opt/etc/{config,init.d}
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/seafile/ $(1)$(PYTHON_PKG_DIR)/
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/seaserv/ $(1)$(PYTHON_PKG_DIR)/
	$(CP) $(PKG_BUILD_DIR)/scripts/sea{f-gc,f-fsck,file,hub}.sh $(1)/opt/share/seafile/seafile-server/
ifeq ($(CONFIG_SEAFILE_FUSE_SUPPORT),y)
	$(CP) $(PKG_BUILD_DIR)/scripts/seaf-fuse.sh $(1)/opt/share/seafile/seafile-server/
endif
	$(CP) $(PKG_BUILD_DIR)/scripts/setup-seafile-mysql.py $(1)/opt/share/seafile/seafile-server/
	$(CP) $(PKG_BUILD_DIR)/scripts/setup-{seafile-mysql,seafile}.sh $(1)/opt/share/seafile/seafile-server/
	$(CP) $(PKG_BUILD_DIR)/scripts/sqlite2mysql.py $(1)/opt/share/seafile/seafile-server/
	$(CP) $(PKG_BUILD_DIR)/scripts/sqlite2mysql.sh $(1)/opt/share/seafile/seafile-server/
	$(CP) $(PKG_BUILD_DIR)/scripts/check_init_admin.py $(1)/opt/share/seafile/seafile-server/
	$(CP) $(PKG_BUILD_DIR)/scripts/upgrade/ $(1)/opt/share/seafile/seafile-server/
	$(CP) ./files/seafile.conf $(1)/opt/etc/config/seafile
	$(CP) $(PKG_BUILD_DIR)/scripts/seahub.conf $(1)/opt/share/seafile/seafile-server/runtime
	$(INSTALL_BIN) ./files/S66seafile $(1)/opt/etc/init.d/
	$(INSTALL_BIN) ./files/S67seahub $(1)/opt/etc/init.d/
	find $(1) -name "*\.pyc" -o -name "*\.pyo" | xargs rm -f
	# Entware specific: fix exec path in scripts
	$(FIND) $(1)/opt -name '*.py' | $(XARGS) $(SED) 's,^#!.*python,#!/opt/bin/python,'
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)/opt/include/seafile/ $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libseafile.pc $(1)/opt/lib/pkgconfig/
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/seafile/ $(1)$(PYTHON_PKG_DIR)/
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/seaserv/ $(1)$(PYTHON_PKG_DIR)/
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

$(eval $(call BuildPackage,seafile-server))

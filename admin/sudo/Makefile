#
# Copyright (C) 2006-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: the newer versions throws 'you do not exist in the passwd database`
# exception, see https://github.com/Entware/Entware/issues/626

include $(TOPDIR)/rules.mk

PKG_NAME:=sudo
PKG_VERSION:=1.8.31
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.sudo.ws/dist
PKG_HASH:=7ea8d97a3cee4c844e0887ea7a1bd80eb54cc98fd77966776cb1a80653ad454f

PKG_MAINTAINER:=

PKG_LICENSE:=ISC
PKG_LICENSE_FILES:=doc/LICENSE
PKG_CPE_ID:=cpe:/a:todd_miller:sudo

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=sudo/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/sudo
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Delegate authority to run commands
  URL:=https://www.sudo.ws/
endef

define Package/sudo/description
 Sudo (su "do") allows a system administrator to delegate authority to
 give certain users (or groups of users) the ability to run some (or
 all) commands as root or another user while providing an audit trail of
 the commands and their arguments.
endef

define Package/sudo/conffiles
/opt/etc/sudoers
/opt/etc/sudoers.d/
endef

TARGET_LDFLAGS += $(if $(CONFIG_GCC_LIBSSP),-lssp)

CONFIGURE_ARGS += \
	--without-pam \
	--disable-pam-session \
	--with-editor=/bin/vi \
	--without-lecture \
	--disable-zlib \
	--with-rundir=/opt/var/lib/sudo \
	--with-vardir=/opt/var/lib/sudo

CONFIGURE_VARS += \
	sudo_cv_uid_t_len=10 \
	sudo_cv_func_unsetenv_void=no

define Host/Compile
	cd $(HOST_BUILD_DIR)/lib/util; \
	    $(MAKE) mksiglist; $(MAKE) mksigname
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/bin
	$(CP) $(HOST_BUILD_DIR)/lib/util/mksig{list,name} $(STAGING_DIR_HOSTPKG)/bin/
endef

define Package/sudo/install
	$(INSTALL_DIR) \
		$(1)/opt/etc/{init.d,sudoers.d} \
		$(1)/opt/{bin,sbin} \
		$(1)/opt/lib/sudo

	$(CP) $(PKG_INSTALL_DIR)/opt/bin/sudo $(1)/opt/bin/
	chmod 4755 $(1)/opt/bin/sudo
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/visudo $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/sudoers $(1)/opt/etc/
	chmod 0440 $(1)/opt/etc/sudoers
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/sudo/*.so* $(1)/opt/lib/sudo/
#	$(INSTALL_BIN) ./files/sudo.init $(1)/etc/init.d/sudo
endef

#define Package/sudo/postinst
##!/bin/sh
#
#[ -n "$$IPKG_INSTROOT" ] || {
#	/etc/init.d/sudo enable
#	/etc/init.d/sudo start
#}
#endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,sudo))

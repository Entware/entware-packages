#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=logrotate
PKG_VERSION:=3.15.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:= https://github.com/logrotate/logrotate/releases/download/$(PKG_VERSION)
PKG_HASH:=313612c4776a305393454c874ef590d8acf84c9ffa648717731dfe902284ff8f

PKG_MAINTAINER:=Christian Beier <cb@shoutrlabs.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:gentoo:logrotate

include $(INCLUDE_DIR)/package.mk

define Package/logrotate
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libpopt +LOGROTATE_ACL:libacl
  TITLE:=rotates, compresses, and mails system logs
  URL:=https://github.com/logrotate/logrotate
  MENU:=1
endef

define Package/logrotate/config
	if PACKAGE_logrotate
		config LOGROTATE_ACL
			bool
			prompt "Enable ACL support"
			default y if USE_FS_ACL_ATTR
	endif
endef

define Package/logrotate/description
 logrotate is designed to ease administration of systems that generate large
 numbers of log files. It allows auto-matic rotation, compression, removal and
 mailing of log files. Each log file may be handled daily, weekly, monthly or
 when it grows too large.
endef

define Package/logrotate/conffiles
/opt/etc/logrotate.conf
endef

CONFIGURE_ARGS += $(if $(CONFIG_LOGROTATE_ACL),--with,--without)-acl

define Build/Compile
	$(call Build/Compile/Default, \
		RPM_OPT_FLAGS:="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		DEFAULT_MAIL_COMMAND="/opt/bin/mail" \
		STATEFILE="/opt/var/lib/logrotate.status" \
		logrotate \
	)
endef

define Package/logrotate/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/logrotate $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/logrotate.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/examples/logrotate.conf $(1)/opt/etc
endef

$(eval $(call BuildPackage,logrotate))

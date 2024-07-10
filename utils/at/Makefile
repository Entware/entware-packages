#
# Copyright (C) 2008-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=at
PKG_VERSION:=3.2.5
PKG_RELEASE:=1

PKG_SOURCE:=at_$(PKG_VERSION).orig.tar.gz
PKG_SOURCE_URL:=http://software.calhariz.com/at
PKG_HASH:=bb066b389d7c9bb9d84a35738032b85c30cba7d949f758192adc72c9477fd3b8

PKG_MAINTAINER:=Phil Eichinger <phil@zankapfel.net>
PKG_LICENSE:=GPL-2.0-or-later GPL-3.0-or-later ISC
PKG_LICENSE_FILES:=COPYING Copyright

include $(INCLUDE_DIR)/package.mk

define Package/at
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libelf
  TITLE:=Delayed job execution and batch processing
  URL:=https://salsa.debian.org/debian/at
endef

define Package/at/description
 At and batch read shell commands from standard input storing them as a job to
 be scheduled for execution in the future.
endef

export SENDMAIL=/bin/true
EXTRA_CFLAGS:=-DNEED_YYWRAP -I$(PKG_BUILD_DIR) \
	$(TARGET_LDFLAGS)

CONFIGURE_ARGS += \
	--prefix=/opt \
	--without-selinux \
	--with-daemon_username=nobody \
	--with-daemon_groupname=nobody \
	--with-etcdir=/opt/etc \
	--with-jobdir=/opt/var/spool/cron/atjobs \
	--with-atspool=/opt/var/spool/cron/atspool

CONFIGURE_VARS += \
	ac_cv_header_security_pam_appl_h=no

define Package/at/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/sbin $(1)/opt/etc/init.d/ $(1)/opt/var/run
	$(INSTALL_BIN) ./files/S50atd $(1)/opt/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/at $(1)/opt/bin
	ln -sf at $(1)/opt/bin/atq
	ln -sf at $(1)/opt/bin/atrm
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/atd $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/batch $(1)/opt/bin
endef

define Package/at/postinst
#!/bin/sh
mkdir -m 0755 -p /opt/var/spool/cron/atjobs
touch /opt/var/spool/cron/atjobs/.SEQ
chown -R nobody:nobody /opt/var/spool/cron/atjobs || echo 'check owner of /opt/var/spool/cron/atjobs'
mkdir -m 0755 -p /opt/var/spool/cron/atspool
chown -R nobody:nobody /opt/var/spool/cron/atspool || echo 'check owner of /opt/var/spool/cron/atspool'
endef

$(eval $(call BuildPackage,at))

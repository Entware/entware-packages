#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=aiccu
PKG_VERSION:=20070115
PKG_RELEASE:=16

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.sixxs.net/archive/sixxs/aiccu/unix
PKG_MD5SUM:=c9bcc83644ed788e22a7c3f3d4021350
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=doc/LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/aiccu/Default
  TITLE:=SixXS IPv6 Connectivity Client ($(1))
  SECTION:=net
  CATEGORY:=Network
  VARIANT:=$(2)
  DEPENDS:=+libpthread
  URL:=http://www.sixxs.net/tools/aiccu/
  MAINTAINER:=Ondrej Caletka <ondrej@caletka.cz>
endef

Package/aiccu=$(call Package/aiccu/Default,without GNUTLS support,default)
Package/aiccu-gnutls=$(call Package/aiccu/Default,with GNUTLS support,gnutls,+libgnutls)

define Build/Configure
	$(SED) "s,strip,/bin/true," $(PKG_BUILD_DIR)/unix-console/Makefile
endef

ifeq ($(BUILD_VARIANT),gnutls)
CONFIG_AICCU_GNUTLS:=y
endif

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" OS_NAME="Linux" OS_VERSION="$(LINUX_VERSION)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_LDFLAGS="$(TARGET_LDFLAGS) -pthread" \
		$(if $(CONFIG_AICCU_GNUTLS),HAVE_GNUTLS=1) \
		DEBUG=0
endef

define Package/aiccu/conffiles
/opt/etc/aiccu.conf
endef

Package/aiccu-gnutls/conffiles=$(call Package/aiccu/conffiles)

define Package/aiccu/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/unix-console/$(PKG_NAME) $(1)/opt/sbin/
	$(INSTALL_BIN) ./files/S50aiccu $(1)/opt/etc/init.d/
	$(INSTALL_CONF) ./files/aiccu.conf $(1)/opt/etc/
endef

Package/aiccu-gnutls/install=$(call Package/aiccu/install,$(1))

$(eval $(call BuildPackage,aiccu))
$(eval $(call BuildPackage,aiccu-gnutls))

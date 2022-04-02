# Entware specific: added depends and ldflags, revert back config,
# disabled extra_cflags (config.h:45: warning: "HAVE_GETOPT_LONG" redefined),
# keep NLS

include $(TOPDIR)/rules.mk

PKG_NAME:=whois
PKG_VERSION:=5.5.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/w/whois
PKG_HASH:=2391037b079695d0e9fd3c85ab021809a539cf093d25b6c51ca65019a54158dd

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=perl/host

PKG_MAINTAINER:=Paul Spooren <mail@aparcar.org>
PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/whois
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Intelligent WHOIS client
  URL:=https://github.com/rfc1036/whois
  DEPENDS:=$(INTL_DEPENDS)
endef

define Package/whois/description
This client is intelligent and can automatically select the appropriate whois
server for most queries.

The internal database is often more accurate than IANA's published one, but
please send me any information you have regarding domains and network resources
which are not correctly handled by the program.
endef

TARGET_LDFLAGS += $(if $(INTL_FULL),-lintl)

#EXTRA_CFLAGS+=-DHAVE_GETOPT_LONG
MAKE_FLAGS += PERL=$(STAGING_DIR_HOSTPKG)/usr/bin/perl

define Package/whois/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/whois $(1)/opt/bin/whois
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/whois.conf $(1)/opt/etc/whois.conf
endef

$(eval $(call BuildPackage,whois))

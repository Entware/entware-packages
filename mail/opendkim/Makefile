#
# Copyright (C) 2017 Val Kulkov <val.kulkov@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
#
# Entware specific: use bundled strl* from https://github.com/trusteddomainproject/OpenDKIM/pull/54/files

include $(TOPDIR)/rules.mk

PKG_NAME:=opendkim
PKG_VERSION:=2.10.3
PKG_RELEASE:=6

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/$(PKG_NAME)
PKG_HASH:=43a0ba57bf942095fe159d0748d8933c6b1dd1117caf0273fa9a0003215e681b
PKG_MAINTAINER:=Val Kulkov <val.kulkov@gmail.com>

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE LICENSE.Sendmail

PKG_INSTALL:=1
PKG_BUILD_DEPENDS:=openssl
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/opendkim
  SECTION:=mail
  CATEGORY:=Mail
  DEPENDS:=+libopendkim
  TITLE:=Open source milter for providing DKIM service
  URL:=http://opendkim.org/
  USERID:=opendkim:opendkim
endef

define Package/opendkim/description
  The OpenDKIM daemon application and the opendkim-genkey Perl script for generating public/private key pairs.
endef

define Package/libopendkim
  SECTION:=mail
  CATEGORY:=Libraries
  DEPENDS:=+libopenssl +libmilter-sendmail
  TITLE:=Library for signing and verifying DKIM signatures
  URL:=http://opendkim.org/
endef

define Package/libopendkim/description
  Library for signing and verifying DomainKeys Identified Mail (DKIM) signatures.
endef

define Package/opendkim-tools
  SECTION:=mail
  CATEGORY:=Mail
  DEPENDS:=+libopendkim
  TITLE:=genzone, testkey and testmsg tools for OpenDKIM
  URL:=http://opendkim.org/
endef

define Package/opendkim-tools/description
  opendkim-genzone, opendkim-testkey and opendkim-testmsg tools.
endef

CONFIGURE_ARGS += \
	--enable-bundled-strl \
	--without-db \
	--without-gcov \
	--without-gprof \
	--without-lcov \
	--without-libbsd \
	--with-milter=$(STAGING_DIR)/opt \
	--with-pic

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/lib $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/opendkim $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/opendkim-{genkey,genzone,testkey,testmsg} $(1)/opt/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libopendkim.so* $(1)/opt/lib/
endef

define Package/opendkim/conffiles
/opt/etc/opendkim.conf
/opt/etc/opendkim/
endef

define Package/opendkim/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/etc/opendkim $(1)/opt/etc/init.d
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/opendkim $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/opendkim-genkey $(1)/opt/sbin/opendkim-genkey.pl
	$(INSTALL_BIN) ./files/opendkim-genkey $(1)/opt/sbin/
	$(INSTALL_DATA) ./files/opendkim.conf.simple $(1)/opt/etc/opendkim/
	$(INSTALL_BIN) ./files/S68opendkim $(1)/opt/etc/init.d/
endef

define Package/libopendkim/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libopendkim.so* $(1)/opt/lib/
endef

define Package/opendkim-tools/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/opendkim-{genzone,testkey,testmsg} $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,opendkim))
$(eval $(call BuildPackage,libopendkim))
$(eval $(call BuildPackage,opendkim-tools))

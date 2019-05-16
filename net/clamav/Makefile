#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=clamav
PKG_VERSION:=0.101.2
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=Marko Ratkaj <marko.ratkaj@sartura.hr> \
		Lucian Cristian <lucian.cristian@gmail.com>
PKG_CPE_ID:=cpe:/a:clamav:clamav

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.clamav.net/downloads/production/
PKG_HASH:=0a12ebdf6ff7a74c0bde2bdc2b55cae33449e6dd953ec90824a9e01291277634

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/clamav/Default
  SECTION:=net
  DEPENDS:=$(CXX_DEPENDS) +libpthread +zlib +libcurl +libjson-c +libmilter-sendmail +libopenssl +libltdl +libpcre2 +USE_MUSL:musl-fts
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=ClamAV
  URL:=https://www.clamav.net/
endef

define Package/clamav
    $(call Package/clamav/Default)
endef

define Package/freshclam
    $(call Package/clamav/Default)
    DEPENDS+= +clamav
    TITLE+=database updater
endef

define Package/clamav/description
 ClamAV is an open source antivirus engine for detecting trojans,
 viruses, malware & other malicious threats.
endef

define Package/freshclam/description
 Database updater for ClamAV
endef

define Package/clamav/conffiles
endef

CONFIGURE_VARS += \
	INCLUDES="" \
	CXXFLAGS="$$$$CXXFLAGS -fno-rtti" \
	$(if $(CONFIG_USE_MUSL),LIBS="-lpthread -lfts",LIBS="-lpthread") \

define Build/Configure
	$(call Build/Configure/Default, \
		--sysconfdir=/opt/etc/clamav/ \
		--prefix=/opt/ \
		--exec-prefix=/opt/ \
		--enable-milter \
		--with-xml=no \
		--disable-bzip2 \
		--with-user nobody \
		--with-group nogroup \
		--with-pcre="$(STAGING_DIR)/opt/" \
		--with-openssl="$(STAGING_DIR)/opt/" \
		--with-zlib="$(STAGING_DIR)/opt/" \
		--disable-zlib-vcheck \
		--disable-clamdtop \
	)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Package/clamav/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/clamd $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/clamav-milter $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clamav-config $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clambc $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clamconf $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clamdscan $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clamscan $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/sigtool $(1)/opt/sbin/

#	$(INSTALL_DIR) $(1)/opt/include
#	$(CP) $(PKG_INSTALL_DIR)/opt/include/clamav.h $(1)/opt/include/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*so* $(1)/opt/lib/

#	$(INSTALL_DIR) $(1)/opt/etc/config
#	$(INSTALL_CONF) ./files/clamav.config $(1)/opt/etc/config/clamav

#	$(INSTALL_DIR) $(1)/opt/etc/init.d/
#	$(INSTALL_BIN) ./files/clamav.init $(1)/opt/etc/init.d/clamav

	$(INSTALL_DIR) $(1)/opt/share/clamav
	$(CP) ./files/bytecode.cvd $(1)/opt/share/clamav/
endef

define Package/freshclam/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/freshclam $(1)/opt/sbin/

#	$(INSTALL_DIR) $(1)/opt/etc/config
#	$(INSTALL_CONF) ./files/freshclam.config $(1)/opt/etc/config/freshclam

#	$(INSTALL_DIR) $(1)/opt/etc/init.d/
#	$(INSTALL_BIN) ./files/freshclam.init $(1)/opt/etc/init.d/freshclam
endef

$(eval $(call BuildPackage,clamav))
$(eval $(call BuildPackage,freshclam))

#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=clamav
PKG_VERSION:=0.101.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.clamav.net/downloads/production/
PKG_HASH:=68d42aac4a9cbde293288533a9a3c3d55863de38f2b8707c1ef2d987b1260338

PKG_MAINTAINER:=Marko Ratkaj <marko.ratkaj@sartura.hr> \
		Lucian Cristian <lucian.cristian@gmail.com>
PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=COPYING*
PKG_CPE_ID:=cpe:/a:clamav:clamav

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

#include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/clamav/Default
  SECTION:=net
  DEPENDS:=+libstdcpp +libpthread +zlib +libcurl +libjson-c +libmilter-sendmail +libopenssl +libltdl +libpcre2 +USE_MUSL:musl-fts
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

CONFIGURE_ARGS += \
	--sysconfdir=/opt/etc/clamav/ \
	--enable-milter \
	--disable-bzip2 \
	--disable-check \
	--disable-clamdtop \
	--disable-rpath \
	--disable-xml \
	--disable-zlib-vcheck \
	--with-user=nobody \
	--with-group=nogroup \
	--with-libcurl="$(STAGING_DIR)/opt/" \
	--with-libjson="$(STAGING_DIR)/opt/" \
	--with-openssl="$(STAGING_DIR)/opt/" \
	--with-pcre="$(STAGING_DIR)/opt/" \
	--with-zlib="$(STAGING_DIR)/opt/" \
	--without-iconv \
	--without-libncurses-prefix

CONFIGURE_VARS += \
	ax_cv_uname_syscall=yes \
	ac_cv_c_mmap_private=yes \
	have_cv_gai=yes \
	ac_cv_sys_file_offset_bits=no

CONFIGURE_VARS += $(if $(CONFIG_IPV6),have_cv_ipv6=yes)

TARGET_CXXFLAGS += -ffunction-sections -fdata-sections -fno-rtti -flto
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed $(if $(CONFIG_USE_MUSL),-lfts)
TARGET_LDFLAGS += -lcurl

define Package/clamav/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/clamd $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/clamav-milter $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clambc $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clamconf $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clamdscan $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/clamscan $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/sigtool $(1)/opt/sbin/

	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib*/lib*.so.* $(1)/opt/lib/

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

#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Don't loose TARGET_CPPFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
# or write access will be broken. This is a CFLAGS from libneon

include $(TOPDIR)/rules.mk

PKG_NAME:=davfs2
PKG_VERSION:=1.5.4
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.savannah.gnu.org/releases/davfs2/
PKG_HASH:=c9c4e0f0912a782386216b2147eb9c36c47f193b8fcf3d637719e0b9fe7c96e0

PKG_FIXUP:=gettext-version autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/davfs2
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Filesystem
  DEPENDS=+libneon +libfuse $(ICONV_DEPENDS) $(INTL_DEPENDS)
  TITLE:=Mount a WebDAV resource as a regular file system.
  URL:=http://savannah.nongnu.org/projects/davfs2/
  MAINTAINER:=Federico Di Marco <fededim@gmail.com>
endef

define Package/davfs2/description
 Web Distributed Authoring and Versioning (WebDAV), an extension to the HTTP-protocol,
 allows authoring of resources on a remote web server.davfs2 provides the ability to
 access such resources like a typical filesystem, allowing for use by standard
 applications with no built-in support for WebDAV.

 davfs2 is designed to fully integrate into the filesystem semantics of Unix-like
 systems (mount, umount, etc.). davfs2 makes mounting by unprivileged users as easy
 and secure as possible.

 davfs2 does extensive caching to make the file system responsive, to avoid
 unnecessary network traffic and to prevent data loss, and to cope for slow or
 unreliable connections.

 davfs2 will work with most WebDAV servers needing little or no configuration.
endef

define Package/davfs2/conffiles
/opt/etc/davfs2/davfs2.conf
/opt/etc/davfs2/secrets
endef

CONFIGURE_ARGS += \
	dav_user=nobody \
	dav_group=nobody \
	ssbindir=/opt/sbin \
	dav_localstatedir=/opt/var/run \
	dav_syscachedir=/opt/var/cache

TARGET_CFLAGS += -I$(STAGING_DIR)/opt/include # $(ICONV_CFLAGS) $(INTL_CFLAGS)

TARGET_CPPFLAGS += -D_GNU_SOURCE  # $(ICONV_CPFLAGS) $(INTL_CPPFLAGS)

CONFIGURE_VARS += \
       LDFLAGS="$(TARGET_LDFLAGS) -L$(TOOLCHAIN_DIR)/lib $(if $(INTL_FULL),-lintl) $(if $(ICONV_FULL),-liconv)" #$(INTL_LDFLAGS) $(ICONV_LDFLAGS) 

CONFIGURE_ARGS += --with-neon="$(STAGING_DIR)/opt" --enable-largefile #--with-libintl-prefix=$(INTL_PREFIX) --with-libiconv-prefix=$(ICONV_PREFIX)

define Package/davfs2/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/mount.davfs $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/umount.davfs $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/davfs2/certs/private
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/etc/{davfs2.conf,secrets} \
	    $(1)/opt/etc/davfs2/
	$(INSTALL_DIR) $(1)/opt/var/{run,cache}
endef

$(eval $(call BuildPackage,davfs2))

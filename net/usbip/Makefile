#
# Copyright (C) 2010-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=usbip
PKG_RELEASE:=15
PKG_LICENSE:=GPL-2.0-only

# Since kernel 2.6.39.1 userspace tools are inside the kernel tree
# Package Automatic match version in kernel
# HASH is not useful kernel package already check it
PKG_VERSION:=$(shell  sed -n -e '/^AC_INIT/s/.*\[\([[:digit:]\.]*\)\].*/\1/gp' $(LINUX_DIR)/drivers/staging/usbip/userspace/configure.ac)
PKG_SOURCE:=
PKG_SOURCE_URL:=
PKG_HASH:=unknown

PKG_MAINTAINER:=Nuno Goncalves <nunojpg@gmail.com>

PATCH_DIR:=./patches-$(PKG_VERSION)

define prepare_source_directory
	rm -rf $(PKG_BUILD_DIR)
	$(CP) $(LINUX_DIR)/drivers/staging/usbip/userspace $(PKG_BUILD_DIR)
endef
Hooks/Prepare/Pre += prepare_source_directory

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_ASLR_PIE:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/usbip/Common
  TITLE:=USB-over-IP
  URL:=http://usbip.sourceforge.net/
  DEPENDS:=@USB_SUPPORT +libsysfs +glib2 @!LINUX_2_6_36
endef

define Package/usbip/Default
  $(call Package/usbip/Common)
  SECTION:=net
  CATEGORY:=Network
endef

define Package/usbip
  $(call Package/usbip/Default)
  TITLE+= (common)
  DEPENDS+= +libwrap +libudev +usbids
endef

define Package/usbip-client
  $(call Package/usbip/Default)
  TITLE+= (client)
  DEPENDS+= usbip
endef

define Package/usbip-server
  $(call Package/usbip/Default)
  TITLE+= (server)
  DEPENDS+= usbip
endef

#define Package/usbip-server/conffiles
#/etc/config/usbipd
#endef

CONFIGURE_PATH:=.
MAKE_PATH:=.
LIBTOOL_PATHS:=.
CONFIGURE_ARGS+= --disable-silent-rules

# Entware specific: add CFLAGS -Wno-*
MAKE_FLAGS += \
	CFLAGS='-Wno-format-truncation \
		-Wno-format-overflow \
		-Wno-implicit-fallthrough'
CONFIGURE_ARGS += --with-usbids-dir=/opt/share/hwdata

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh );
	$(call Build/Configure/Default)
endef

CFLAGS+="$(TARGET_CFLAGS) -I$(STAGING_DIR)/opt/include"

define Package/usbip/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libusbip.so.* $(1)/opt/lib/
endef

define Package/usbip-client/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/usbip $(1)/opt/sbin/
endef

define Package/usbip-server/install
	$(INSTALL_DIR) $(1)/opt/sbin $(1)/opt/etc/init.d
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/usbipd $(1)/opt/sbin/
	$(INSTALL_BIN) ./files/S74usbipd $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,usbip))
$(eval $(call BuildPackage,usbip-client))
$(eval $(call BuildPackage,usbip-server))

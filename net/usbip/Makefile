#
# Copyright (C) 2010-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=usbip
PKG_RELEASE:=11
PKG_LICENSE:=GPL-2.0

# Since kernel 2.6.39.1 userspace tools are inside the kernel tree
# Package Automatic match version in kernel
# MD5SUM is not useful kernel package already check it
PKG_VERSION:=$(shell  sed -n -e '/^AC_INIT/s/.*\[\([[:digit:]\.]*\)\].*/\1/gp' $(LINUX_DIR)/drivers/staging/usbip/userspace/configure.ac)
PKG_SOURCE:=
PKG_SOURCE_URL:=
PKG_MD5SUM:=unknown

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
  DEPENDS+= +libwrap +libudev-fbsd
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

CONFIGURE_PATH:=.
MAKE_PATH:=.
LIBTOOL_PATHS:=.

# Entware specific CFLAGS -Wno-...
MAKE_FLAGS+=CFLAGS='-Wno-format-truncation -Wno-format-overflow -Wno-implicit-fallthrough \
	-Dudev_device_get_devpath\(x\)=udev_device_get_syspath\(x\)+strlen\(\"/sys\"\) \
	-DSIGCLD=SIGCHLD'
CONFIGURE_ARGS += \
	--disable-silent-rules \
	--with-usbids-dir=/opt/share/hwdata

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh );
	$(call Build/Configure/Default)
endef

CONFIGURE_VARS+= $(if $(CONFIG_USE_GLIBC),LIBS='-lpthread')
CFLAGS+="$(TARGET_CFLAGS) -I$(STAGING_DIR)/opt/include"

USB_IDS_VER:=0.318
USB_IDS_FILE:=usb.ids.$(USB_IDS_VER)
define Download/usb.ids
  FILE:=$(USB_IDS_FILE)
  URL_FILE:=usb.ids
  URL:=@GITHUB/vcrhonek/hwdata/v$(USB_IDS_VER)
  HASH:=84bc5452e4e45c2250e01bc74e03528b2a53c4724b2c4a5feaea76a922f83915
endef

define Package/usbip/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libusbip.so.* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/share/hwdata
	$(CP) $(DL_DIR)/usb.ids.$(USB_IDS_VER) $(1)/opt/share/hwdata/usb.ids
endef

define Package/usbip-client/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/usbip $(1)/opt/sbin/
endef

define Package/usbip-server/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S74usbipd $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/usbipd $(1)/opt/sbin/
endef

$(eval $(call Download,usb.ids))
$(eval $(call BuildPackage,usbip))
$(eval $(call BuildPackage,usbip-client))
$(eval $(call BuildPackage,usbip-server))

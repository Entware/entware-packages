#
# Copyright (C) 2010-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=usbip
PKG_RELEASE:=10a
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
  DEPENDS+= +libwrap +USE_GLIBC:libudev-fbsd
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
CONFIGURE_ARGS+= --disable-silent-rules

define Build/Configure
	(cd $(PKG_BUILD_DIR); ./autogen.sh );
	$(call Build/Configure/Default)
endef

CONFIGURE_VARS+= $(if $(CONFIG_USE_GLIBC),LIBS='-lpthread')
CONFIGURE_ARGS += "--with-usbids-dir=/opt/share/hwdata"
CFLAGS+="$(TARGET_CFLAGS) -I$(STAGING_DIR)/opt/include"

USB_IDS_REV:=0a6be488b4c1485d30c9efee1cc895af5d4a1383
USB_IDS_FILE:=usb.ids.$(USB_IDS_REV)
define Download/usb.ids
  FILE:=$(USB_IDS_FILE)
  URL_FILE:=usb.ids
  URL:=@GITHUB/gentoo/hwids/$(USB_IDS_REV)
  HASH:=2d0403ffccc0ff7150e32c0bf8e2878816b76ba08d2c3bb1059f33627a3da30f
endef

define Package/usbip/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libusbip.so.* $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/share/hwdata
	$(CP) $(DL_DIR)/usb.ids.$(USB_IDS_REV) $(1)/opt/share/hwdata/usb.ids
endef

define Package/usbip-client/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/usbip $(1)/opt/sbin/
endef

define Package/usbip-server/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/usbipd $(1)/opt/sbin/
endef

$(eval $(call Download,usb.ids))
$(eval $(call BuildPackage,usbip))
$(eval $(call BuildPackage,usbip-client))
$(eval $(call BuildPackage,usbip-server))

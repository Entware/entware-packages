#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# super voodoo dance (((

include $(TOPDIR)/rules.mk

PKG_NAME:=cffi
PKG_VERSION:=1.10.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/5b/b9/790f8eafcdab455bcd3bd908161f802c9ce5adbf702a83aa7712fcc345b7
PKG_HASH:=b3b02911eb1f6ada203b0763ba924234629b51586f72a21faacc638269f4ced5

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_UNPACK=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

PKG_BUILD_DEPENDS:=python python-setuptools
HOST_BUILD_DEPENDS:=libffi/host python-pycparser/host PACKAGE_python-cffi:python/host PACKAGE_python3-cffi:python3/host 

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jeffery To <jeffery.to@gmail.com>, Alexandru Ardelean <ardeleanalex@gmail.com>

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)
$(call include_mk, python-host.mk)

define Package/python-cffi/Default
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  URL:=http://cffi.readthedocs.org/
  DEPENDS:=+libffi
endef

define Package/python-cffi
$(call Package/python-cffi/Default)
  TITLE:=python-cffi
  DEPENDS+=+python-light +python-pycparser
  VARIANT:=python
endef

define Package/python3-cffi
$(call Package/python-cffi/Default)
  TITLE:=python3-cffi
  DEPENDS+=+python3-light +python3-pycparser
  VARIANT:=python3
endef

define Package/python-cffi/description
Foreign Function Interface for Python calling C code.
endef

define Package/python3-cffi/description
$(call Package/python-cffi/description)
.
(Variant for Python3)
endef

ifdef CONFIG_PACKAGE_python-cffi
define Host/Compile/python-cffi
	$(call Build/Compile/HostPyMod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
endef
endif

ifdef CONFIG_PACKAGE_python3-cffi
define Host/Compile/python3-cffi
	$(call Build/Compile/HostPy3Mod,,install --prefix="" --root="$(STAGING_DIR_HOSTPKG)")
endef
endif

define Host/Compile
$(call Host/Compile/python-cffi)
$(call Host/Compile/python3-cffi)
endef

define Host/Install
endef

$(eval $(call HostBuild))

$(eval $(call PyPackage,python-cffi))
$(eval $(call BuildPackage,python-cffi))

$(eval $(call Py3Package,python3-cffi))
$(eval $(call BuildPackage,python3-cffi))

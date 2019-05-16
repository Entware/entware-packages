#
# Copyright (C) 2007-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=django
PKG_VERSION:=1.11.17
PKG_RELEASE=3

PKG_SOURCE:=Django-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/D/Django
PKG_HASH:=a787ee66f4b4cf8ed753661cabcec603989677fa3a107fcb7f15511a44bdb483
PKG_BUILD_DIR=$(BUILD_DIR)/Django-$(PKG_VERSION)

PKG_MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE LICENSE.python
PKG_CPE_ID:=cpe:/a:djangoproject:django

include $(INCLUDE_DIR)/package.mk
include ../python-package.mk

define Package/django
    SUBMENU:=Python
    SECTION:=lang
    CATEGORY:=Languages
    TITLE:=The web framework for perfectionists with deadlines.
    URL:=https://www.djangoproject.com/
    DEPENDS:=+python +python-pytz
endef

define Package/django/description
    The web framework for perfectionists with deadlines.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/opt --root=$(PKG_INSTALL_DIR))
endef

define Build/InstallDev
	### fix exec path
	$(SED) 's|/opt/bin|$(STAGING_DIR_HOSTPKG)/bin|' $(PKG_INSTALL_DIR)/opt/bin/django-admin.py \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/django/bin/django-admin.py
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) \
	    $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
	    $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/django-admin.py \
	    $(1)/opt/bin
endef

define Package/django/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) \
	    $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
	    $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/django-admin.py \
	    $(1)/opt/bin
	# fix python exec path
	sed -i 's/#!.*/#!\/opt\/bin\/python/g' $(1)/opt/bin/django-admin.py
	$(FIND) $(PKG_BUILD_DIR) -name '*.py' | $(XARGS) $(SED) 's,^#!.*,#!/opt/bin/python,'
endef

$(eval $(call BuildPackage,django))

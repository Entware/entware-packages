#
# Copyright (C) 2007-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=seafile-seahub
PKG_VERSION:=5.0.6
PKG_RELEASE:=1a
PKG_LICENSE:=Apache-2.0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/haiwen/seahub.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=5fd16dfdbcafdca27337ddc79810e148d57c2f50
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/seafile-seahub
    SECTION:=net
    CATEGORY:=Network
    DEPENDS:=+python +simplejson +pillow +python-setuptools
    TITLE:=Seafile server - seahub component
    MAINTAINER:=Gergely Kiss <mail.gery@gmail.com>
    URL:=http://seafile.com/

endef

define Package/seafile-seahub/description
   The web end of seafile server.
endef

PKG_BUILD_DEPENDS:=python-setuptools
PYTHONPATH:=$(PYTHONPATH):$(PKG_BUILD_DIR)/thirdpart

define Download/django
   FILE=Django-1.5.12.tar.gz
   URL=https://www.djangoproject.com/m/releases/1.5/
   MD5SUM:=0e0b48cd0bb59cbc5499dcbb4fe1fb90
endef

define Download/django_appconf
   FILE=django-appconf-1.0.1.tar.gz
   URL=https://pypi.python.org/packages/source/d/django-appconf/
   MD5SUM:=29c87a00f0d098b90f3ac6113ae6e52d
endef

define Download/django_compressor
   FILE=django_compressor-1.5.tar.gz
   URL=https://pypi.python.org/packages/source/d/django_compressor/
   MD5SUM:=274dd82a45ddd13e111852dd101a5924
endef

define Download/django-picklefield
   FILE=django-picklefield-0.3.2.tar.gz
   URL=https://pypi.python.org/packages/source/d/django-picklefield/
   MD5SUM:=b2c17ca9e03704ce33890e6aefc7b2e5
endef

define Download/django-statici18n
   FILE=django-statici18n-1.1.3.tar.gz
   URL=https://pypi.python.org/packages/source/d/django-statici18n/
   MD5SUM:=1639cfb2bbd6e43aa4ceedd60319795e
endef

define Download/django-constance
    PROTO=git
    URL=https://github.com/haiwen/django-constance.git
    SUBDIR=django-constance-1.0.1
    FILE=django-constance-1.0.1.tar.gz
    VERSION=bde7f7cdfd0ed1631a6817fd4cd76f37bf54fe35
endef

define Download/djblets
   PROTO=git
   URL=https://github.com/djblets/djblets.git
   SUBDIR=djblets-0.6.14
   FILE=djblets-0.6.14.tar.gz
   VERSION=58c09bae9b71ac164f78c76746fd2e545aae6c68
endef

define Download/gunicorn
   FILE=gunicorn-0.16.1.tar.gz
   URL=https://pypi.python.org/packages/source/g/gunicorn/
   MD5SUM:=d53d5d04d941f2a3089e814e753a218f
endef

define Download/jdcal
   FILE=jdcal-1.2.tar.gz
   URL=https://pypi.python.org/packages/source/j/jdcal/
   MD5SUM:=ab8d5ba300fd1eb01514f363d19b1eb9
endef

define Download/et_xmlfile
   FILE=et_xmlfile-1.0.1.tar.gz
   URL=https://pypi.python.org/packages/source/e/et_xmlfile/
   MD5SUM:=f47940fd9d556375420b2e276476cfaf
endef

define Download/six
   FILE=six-1.9.0.tar.gz
   URL=https://pypi.python.org/packages/source/s/six/
   MD5SUM:=476881ef4012262dfc8adc645ee786c4
endef

define Download/chardet
   FILE=chardet-2.1.1.tar.gz
   URL=https://pypi.python.org/packages/source/c/chardet/
   MD5SUM:=295367fd210d20f3febda615a88e1ef0
endef

define Download/flup
   FILE=flup-1.0.2.tar.gz
   URL=https://pypi.python.org/packages/source/f/flup/
   MD5SUM:=24dad7edc5ada31dddd49456ee8d5254
endef

define Download/openpyxl
   FILE=openpyxl-2.3.1.tar.gz
   URL=https://pypi.python.org/packages/source/o/openpyxl/
   MD5SUM:=7fa43e8946fe230788bae0aae1dfded7
endef

define Download/python-dateutil
   FILE=python-dateutil-1.5.tar.gz
   URL=https://pypi.python.org/packages/source/p/python-dateutil/
   MD5SUM:=0dcb1de5e5cad69490a3b6ab63f0cfa5
endef

define Build/Configure
	# fix python and bash exec path in scripts
	find $(PKG_BUILD_DIR) -name *.py | xargs $(SED) 's|/usr/bin/env python|/opt/bin/python|'
	find $(PKG_BUILD_DIR) -name *.sh | xargs $(SED) 's|/bin/bash|/opt/bin/bash|'
endef

define Build/Compile
	# Download python dependencies
	$(eval $(call Download,django))
	$(eval $(call Download,django_appconf))
	$(eval $(call Download,django_compressor))
	$(eval $(call Download,django-picklefield))
	$(eval $(call Download,django-statici18n))
	$(eval $(call Download,django-constance))
	$(eval $(call Download,djblets))
	$(eval $(call Download,gunicorn))
	$(eval $(call Download,jdcal))
	$(eval $(call Download,et_xmlfile))
	$(eval $(call Download,six))
	$(eval $(call Download,chardet))
	$(eval $(call Download,flup))
	$(eval $(call Download,openpyxl))
	$(eval $(call Download,python-dateutil))
	# Install python dependencies
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/Django-1.5.12.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/django-appconf-1.0.1.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/django_compressor-1.5.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/django-picklefield-0.3.2.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/django-statici18n-1.1.3.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/django-constance-1.0.1.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/djblets-0.6.14.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/gunicorn-0.16.1.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/jdcal-1.2.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/et_xmlfile-1.0.1.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/six-1.9.0.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/chardet-2.1.1.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/flup-1.0.2.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/openpyxl-2.3.1.tar.gz)
	$(call HostPython,, \
		$(STAGING_DIR_ROOT)/opt/bin/easy_install -d $(PKG_BUILD_DIR)/thirdpart -Z -N \
		$(DL_DIR)/python-dateutil-1.5.tar.gz)
endef

define Package/seafile-seahub/install
	$(INSTALL_DIR) $(1)/opt/share/seafile/seafile-server/seahub
	$(CP) $(PKG_BUILD_DIR)/{locale,media,fabfile,seahub,sql,static,tests,thirdpart,tools} $(1)/opt/share/seafile/seafile-server/seahub
	$(CP) $(PKG_BUILD_DIR)/*.{sh,template,py,txt} $(1)/opt/share/seafile/seafile-server/seahub
	$(CP) $(PKG_BUILD_DIR)/{CONTRIBUTORS,HACKING,README.markdown} $(1)/opt/share/seafile/seafile-server/seahub
	$(CP) $(PKG_BUILD_DIR)/pylintrc* $(1)/opt/share/seafile/seafile-server/seahub
	find $(1) -name "*\.pyc" -o -name "*\.pyo" | xargs rm -f
endef

$(eval $(call BuildPackage,seafile-seahub))

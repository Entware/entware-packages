#
# Copyright (C) 2019 Jakub Piotr Cłapa <jpc@loee.pl>
# Copyright (C) 2020 Alexandru Ardelean <ardeleanalex@gmail.com>
#

include $(TOPDIR)/rules.mk

PKG_NAME:=numpy
PKG_VERSION:=2.2.5
PKG_RELEASE:=1

PYPI_NAME:=$(PKG_NAME)
PKG_HASH:=a9c0d994680cd991b1cb772e8b297340085466a6fe964bc9d4e80f5e2f43c291

PKG_MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE.txt
PKG_CPE_ID:=cpe:/a:numpy:numpy

PKG_CONFIG_DEPENDS:= \
        CONFIG_NUMPY_OPENBLAS_SUPPORT

PKG_BUILD_DEPENDS:=python-cython/host pyproject-metadata/host meson-python/host

# Ensure numpy does not find openblas if openblas support is not enabled
PYTHON3_PKG_BUILD_VARS:= \
        $(if $(CONFIG_NUMPY_OPENBLAS_SUPPORT),,NPY_BLAS_ORDER= NPY_LAPACK_ORDER= )

PYTHON3_PKG_BUILD_ARGS += \
	-Csetup-args=--cross-file=$(PKG_BUILD_DIR)/openwrt-cross.txt \
	-Csetup-args=-Dallow-noblas=$(if $(CONFIG_NUMPY_OPENBLAS_SUPPORT),false,true) \
	-Csetup-args=-Duse-ilp64=$(if $(CONFIG_ARCH_64BIT),true,false) \
	-Csetup-args=-Ddisable-svml=true \
	-Csetup-args=-Ddisable-highway=true \
	-Csetup-args=-Ddisable-intel-sort=true \
	-Csetup-args=-Ddisable-optimization=true \
	-Csetup-args=-Dcpu-baseline='min' \
	-Csetup-args=-Dcpu-dispatch='none' \
	-Csetup-args=-Dtest-simd='' \
	-Csetup-args=-Dtest-simd-args='' \
	-Csetup-args=-Db_pch=false \
	-Csetup-args=-Db_lto=false \
	-Csetup-args=-Db_lto_threads=1 \
	-Csetup-args=-Dpkg_config_path=$(STAGING_DIR)/opt/lib/pkgconfig

#	-Ccompile-args=-v

include ../pypi.mk
include $(INCLUDE_DIR)/package.mk
include ../python3-package.mk

define Package/python3-numpy
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=The fundamental package for scientific computing with Python
  URL:=https://www.numpy.org/
  DEPENDS:=+INSTALL_GFORTRAN:libgfortran +python3 +libstdcpp \
	   +NUMPY_OPENBLAS_SUPPORT:openblas
endef

# We need to duplicate the omitted arhitectures same as openblas
define Package/python3-numpy/config
menu "Configuration"
depends on !powerpc
depends on !arc

config NUMPY_OPENBLAS_SUPPORT
        bool "Enable OpenBLAS support"
        default n

endmenu
endef

MESON_ARCH:=$(subst mipsel,mips,$(ARCH))

TARGET_CFLAGS += -fno-strict-aliasing

define Meson/CreateCrossFile
	$(STAGING_DIR_HOST)/bin/sed \
		-e "s|@CC@|$(foreach BIN,$(TARGET_CC),'$(BIN)',)|" \
		-e "s|@CXX@|$(foreach BIN,$(TARGET_CXX),'$(BIN)',)|" \
		-e "s|@LD@|$(foreach FLAG,$(TARGET_LINKER),'$(FLAG)',)|" \
		-e "s|@AR@|$(TARGET_AR)|" \
		-e "s|@STRIP@|$(TARGET_CROSS)strip|" \
		-e "s|@NM@|$(TARGET_NM)|" \
		-e "s|@PKGCONFIG@|$(PKG_CONFIG)|" \
		-e "s|@CMAKE@|$(STAGING_DIR_HOST)/bin/cmake|" \
		-e "s|@PYTHON@|$(STAGING_DIR_HOSTPKG)/bin/$(PYTHON)|" \
		-e "s|@CFLAGS@|$(foreach FLAG,$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS),'$(FLAG)',)|" \
		-e "s|@CXXFLAGS@|$(foreach FLAG,$(TARGET_CXXFLAGS) $(EXTRA_CXXFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS),'$(FLAG)',)|" \
		-e "s|@LDFLAGS@|$(foreach FLAG,$(TARGET_LDFLAGS) $(EXTRA_LDFLAGS),'$(FLAG)',)|" \
		-e "s|@ARCH@|$(MESON_ARCH)|" \
		-e "s|@CPU@|$(MESON_ARCH)|" \
		-e "s|@ENDIAN@|$(if $(CONFIG_BIG_ENDIAN),big,little)|" \
		< files/openwrt-cross.txt.in \
		> $(PKG_BUILD_DIR)/openwrt-cross.txt
	echo "longdouble_format = '$(if $(CONFIG_BIG_ENDIAN),IEEE_DOUBLE_BE,IEEE_DOUBLE_LE)'" >> $(PKG_BUILD_DIR)/openwrt-cross.txt
endef

define Build/Prepare/numpy-sitecfg
	echo "[DEFAULT]"                                 >  $(PKG_BUILD_DIR)/site.cfg
	echo "library_dirs = $(STAGING_DIR)/opt/lib"     >> $(PKG_BUILD_DIR)/site.cfg
	echo "include_dirs = $(STAGING_DIR)/opt/include" >> $(PKG_BUILD_DIR)/site.cfg

  ifdef CONFIG_NUMPY_OPENBLAS_SUPPORT
	echo                                             >> $(PKG_BUILD_DIR)/site.cfg
	echo "[openblas]"                                >> $(PKG_BUILD_DIR)/site.cfg
	echo "libraries = openblas"                      >> $(PKG_BUILD_DIR)/site.cfg
	echo "runtime_library_dirs = /opt/lib"           >> $(PKG_BUILD_DIR)/site.cfg
  endif
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(call Build/Prepare/numpy-sitecfg)
	$(call Meson/CreateCrossFile)
endef

define Package/python3-numpy/description
NumPy is the fundamental package for array computing with Python.

By default, this package is built without some modules.
For some modules to be available, the INSTALL_GFORTRAN symbol needs
to be enabled in the OpenWrt core/toolchain.
endef

$(eval $(call Py3Package,python3-numpy))
$(eval $(call BuildPackage,python3-numpy))
$(eval $(call BuildPackage,python3-numpy-src))

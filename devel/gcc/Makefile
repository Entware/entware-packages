#
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
#

include $(TOPDIR)/rules.mk

#glibc changed (patched) --> increase PKG_RELEASE of gcc since libs are taken from toolchain

PKG_NAME:=gcc
PKG_VERSION:=4.8.5
PKG_RELEASE:=1a
PKG_SOURCE_URL:=ftp://ftp.fu-berlin.de/unix/languages/gcc/releases/gcc-$(PKG_VERSION) \
     http://mirrors.rcn.net/pub/sourceware/gcc/releases/gcc-$(PKG_VERSION) \
    ftp://ftp.gnu.org/gnu/gcc/releases/gcc-$(PKG_VERSION)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_MD5SUM:=80d2c2982a3392bb0b89673ff136e223
PATCH_DIR:=$(TOPDIR)/toolchain/gcc/patches/4.8.5
PKG_INSTALL:=1
PKG_FIXUP:=libtool
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

TARGET_LANGUAGES:="c,c++"
BUGURL=https://dev.openwrt.org/
PKGVERSION=OpenWrt GCC $(PKG_VERSION)

# not using sstrip here as this fucks up the .so's somehow
STRIP:=$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)strip
RSTRIP:= \
       NM="$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)nm" \
       STRIP="$(STRIP)" \
       STRIP_KMOD="$(STRIP) --strip-debug" \
       $(SCRIPT_DIR)/rstrip.sh


define Package/gcc
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=gcc
  MAINTAINER:=Christian Beier <cb@shoutrlabs.com>
  DEPENDS:= +binutils +libstdcpp
endef

define Package/gcc/description
	build a native toolchain for compiling on target
endef


define Build/Prepare
	$(PKG_UNPACK)
# 	we have to download additional stuff before patching
	(cd $(PKG_BUILD_DIR) && ./contrib/download_prerequisites)
	$(Build/Patch)
	patch -p1 -d "$(PKG_BUILD_DIR)" < ./patches/002-dont-choke-when-building-32bit-on-64bit.patch
#	poor man's fix for `none-openwrt-linux' not recognized when building with musl
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/mpfr/
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/gmp/
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/mpc/
endef


define Build/Configure
	(cd $(PKG_BUILD_DIR); rm -f config.cache; \
		SHELL="$(BASH)" \
		$(TARGET_CONFIGURE_OPTS) \
		$(PKG_BUILD_DIR)/configure \
			$(CONFIGURE_ARGS) \
			--build=$(GNU_HOST_NAME) \
			--host=$(REAL_GNU_TARGET_NAME) \
			--target=$(REAL_GNU_TARGET_NAME) \
			--enable-languages=$(TARGET_LANGUAGES) \
			--with-bugurl=$(BUGURL) \
			--with-pkgversion="$(PKGVERSION)" \
			--enable-shared \
			$(if $(CONFIG_GLIBC_USE_VERSION_2_22),--enable,--disable)-__cxa_atexit \
			--enable-target-optspace \
			--with-gnu-ld \
			--with-stage1-ldflags="-Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
			--with-boot-ldflags="static-libstdc++ -static-libgcc -Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
			--disable-nls \
			--disable-libmudflap \
			--disable-multilib \
			--disable-libgomp \
			--disable-libquadmath \
			--disable-libssp \
			--disable-decimal-float \
			--disable-libstdcxx-pch \
			--with-host-libstdcxx=-lstdc++ \
			--prefix=/opt \
			--libexecdir=/opt/lib \
			--with-local-prefix=/opt \
			$(SOFT_FLOAT_CONFIG_OPTION) \
			$(call qstrip,$(CONFIG_EXTRA_GCC_CONFIG_OPTIONS)) \
			$(if $(CONFIG_mips64)$(CONFIG_mips64el),--with-arch=mips64 \
			--with-abi=$(subst ",,$(CONFIG_MIPS64_ABI))) \
	);
endef

define Build/Compile
	export SHELL="$(BASH)"; $(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) \
			DESTDIR="$(PKG_INSTALL_DIR)" $(MAKE_ARGS) all install
endef

ENVCFLAGS:="$(TARGET_OPTIMIZATION) $(EXTRA_OPTIMIZATION)
ifeq ($(CONFIG_SOFT_FLOAT),y)
    ifeq ($(CONFIG_arm),y)
	ENVCFLAGS+= -mfloat-abi=soft
    else
	ENVCFLAGS+= -msoft-float
    endif
endif
ENVCFLAGS+="

ENVLDFLAGS:="-Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER) -L/opt/lib"

define Package/gcc/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/lib $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -ar $(PKG_INSTALL_DIR)/opt/include $(1)/opt
	cp -a $(PKG_INSTALL_DIR)/opt/bin/{$(REAL_GNU_TARGET_NAME)-{g++,gcc},cpp,gcov} $(1)/opt/bin
	ln -s $(REAL_GNU_TARGET_NAME)-g++ $(1)/opt/bin/c++
	ln -s $(REAL_GNU_TARGET_NAME)-g++ $(1)/opt/bin/g++
	ln -s $(REAL_GNU_TARGET_NAME)-g++ $(1)/opt/bin/$(REAL_GNU_TARGET_NAME)-c++
	ln -s $(REAL_GNU_TARGET_NAME)-gcc $(1)/opt/bin/gcc
	ln -s $(REAL_GNU_TARGET_NAME)-gcc $(1)/opt/bin/$(REAL_GNU_TARGET_NAME)-gcc-$(PKG_VERSION)
	cp -ar $(PKG_INSTALL_DIR)/opt/lib/gcc $(1)/opt/lib
	$(RM) $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/*.a
	cp -ar $(TOOLCHAIN_DIR)/include $(1)/opt
	cp -a $(TOOLCHAIN_DIR)/lib/*.{o,so*} $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -a $(TOOLCHAIN_DIR)/lib/*nonshared*.a  $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	grep "GROUP.*-lgcc" $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libgcc_s.so && cp -a $(PKG_INSTALL_DIR)/opt/lib/gcc/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libgcc.a $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/ ; true
	echo '#!/bin/sh' > $(1)/opt/bin/gcc_env.sh
	echo 'export LDFLAGS=$(ENVLDFLAGS)' >> $(1)/opt/bin/gcc_env.sh
	echo 'export CFLAGS=$(ENVCFLAGS)' >> $(1)/opt/bin/gcc_env.sh
	chmod +x $(1)/opt/bin/gcc_env.sh
endef

$(eval $(call BuildPackage,gcc))

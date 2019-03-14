#
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: Our own patch set here.

include $(TOPDIR)/rules.mk

PKG_NAME:=gcc
PKG_VERSION:=6.3.0
PKG_RELEASE:=1b
PKG_SOURCE_URL:=@GNU/gcc/gcc-$(PKG_VERSION)
PKG_HASH:=f06ae7f3f790fbf0f018f6d40e844451e6bc3b7bc96e128e63b09825c1f8b29f

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PATCH_DIR:=$(TOPDIR)/toolchain/gcc/patches/$(PKG_VERSION)
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

ifneq ($(CONFIG_SOFT_FLOAT),y)
	ifeq ($(CONFIG_arm),y)
		ARM_FLOAT_OPTION:= --with-float=hard
	endif
endif

define Package/gcc
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=gcc
  MAINTAINER:=Noble Pepper <gccmaintain@noblepepper.com>
  DEPENDS:= +binutils +libstdcpp
endef

define Package/gcc/description
	build a native toolchain for compiling on target
endef

GMPSRC=gmp-4.3.2

define Download/gmp
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(GMPSRC).tar.bz2
  HASH:=936162c0312886c21581002b79932829aa048cfaf9937c6265aeaa14f1cd1775
endef
$(eval $(call Download,gmp))

MPCSRC=mpc-0.8.1

define Download/mpc
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(MPCSRC).tar.gz
  HASH:=e664603757251fd8a352848276497a4c79b7f8b21fd8aedd5cc0598a38fee3e4
endef
$(eval $(call Download,mpc))

MPFRSRC=mpfr-2.4.2

define Download/mpfr
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(MPFRSRC).tar.bz2
  HASH:=c7e75a08a8d49d2082e4caee1591a05d11b9d5627514e678f02d66a124bcf2ba
endef
$(eval $(call Download,mpfr))

define Build/Prepare
	$(PKG_UNPACK)
# 	we have to download and unpack additional stuff before patching
	tar -C $(PKG_BUILD_DIR) -xvjf $(DL_DIR)/$(GMPSRC).tar.bz2
	ln -sf $(PKG_BUILD_DIR)/$(GMPSRC) $(PKG_BUILD_DIR)/gmp
	tar -C $(PKG_BUILD_DIR) -xvzf $(DL_DIR)/$(MPCSRC).tar.gz
	ln -sf $(PKG_BUILD_DIR)/$(MPCSRC) $(PKG_BUILD_DIR)/mpc
	tar -C $(PKG_BUILD_DIR) -xvjf $(DL_DIR)/$(MPFRSRC).tar.bz2
	ln -sf $(PKG_BUILD_DIR)/$(MPFRSRC) $(PKG_BUILD_DIR)/mpfr
	$(Build/Patch)
	patch -p1 -d "$(PKG_BUILD_DIR)" < ./patches/002-dont-choke-when-building-32bit-on-64bit.patch
	patch -p1 -d "$(PKG_BUILD_DIR)" < ./patches/003-mpfr-longlong-mips.patch
#uclibc needs -lm to build libcc1
ifdef CONFIG_USE_UCLIBC
	patch -p1 -d "$(PKG_BUILD_DIR)" < ./patches/004-libcc1_uclibc_lm.patch
endif
	patch -p1 -d "$(PKG_BUILD_DIR)" < ./patches/005-ucontext.patch
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
			$(if $(CONFIG_LIBC_USE_GLIBC),--enable,--disable)-__cxa_atexit \
			--with-default-libstdcxx-abi=gcc4-compatible \
			--enable-target-optspace \
			--with-gnu-ld \
			--with-stage1-ldflags="-Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
			--with-specs="-Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
			--with-boot-ldflags="static-libstdc++ -static-libgcc -Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
			--disable-nls \
			--disable-libsanitizer \
			--disable-libvtv \
			--disable-libcilkrts \
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
			$(ARM_FLOAT_OPTION) \
			$(SOFT_FLOAT_CONFIG_OPTION) \
			$(call qstrip,$(CONFIG_EXTRA_GCC_CONFIG_OPTIONS)) \
	);
endef

define Build/Compile
	export SHELL="$(BASH)"; $(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) \
			DESTDIR="$(PKG_INSTALL_DIR)" $(MAKE_ARGS) all install
endef

ENVCFLAGS:="$(TARGET_OPTIMIZATION) $(call qstrip,$(CONFIG_EXTRA_OPTIMIZATION))
ifeq ($(CONFIG_SOFT_FLOAT),y)
    ifeq ($(CONFIG_arm),y)
	ENVCFLAGS+= -mfloat-abi=soft
    else
	ENVCFLAGS+= -msoft-float
    endif
endif
ENVCFLAGS+="

ENVLDFLAGS:="-Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER) -L/opt/lib"

define Package/gcc/postinst
#!/bin/sh
echo "There are no *-dev packages in Entware(with few exceptions)!"
echo "Please install headers as described in the wiki:"
echo "https://github.com/Entware/Entware/wiki"
endef

define Package/gcc/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/lib $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -ar $(PKG_INSTALL_DIR)/opt/include $(1)/opt
	cp -a $(PKG_INSTALL_DIR)/opt/bin/{$(REAL_GNU_TARGET_NAME)-{g++,gcc,gcc-ar},cpp,gcov} $(1)/opt/bin
	ln -s $(REAL_GNU_TARGET_NAME)-g++ $(1)/opt/bin/c++
	ln -s $(REAL_GNU_TARGET_NAME)-g++ $(1)/opt/bin/g++
	ln -s $(REAL_GNU_TARGET_NAME)-g++ $(1)/opt/bin/$(REAL_GNU_TARGET_NAME)-c++
	ln -s $(REAL_GNU_TARGET_NAME)-gcc $(1)/opt/bin/gcc
	ln -s $(REAL_GNU_TARGET_NAME)-gcc $(1)/opt/bin/$(REAL_GNU_TARGET_NAME)-gcc-$(PKG_VERSION)
	ln -s $(REAL_GNU_TARGET_NAME)-gcc-ar $(1)/opt/bin/gcc-ar
	cp -ar $(PKG_INSTALL_DIR)/opt/lib/gcc $(1)/opt/lib
	cp -ar $(TOOLCHAIN_DIR)/include $(1)/opt
	cp -a $(TOOLCHAIN_DIR)/lib/*.{o,so*} $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -a $(TOOLCHAIN_DIR)/lib/*nonshared*.a  $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -a $(TOOLCHAIN_DIR)/lib/libm.a  $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	rm -f $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libgo*
	rm -f $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libcc1*
	echo '#!/bin/sh' > $(1)/opt/bin/gcc_env.sh
	echo 'export LDFLAGS=$(ENVLDFLAGS)' >> $(1)/opt/bin/gcc_env.sh
	echo 'export CFLAGS=$(ENVCFLAGS)' >> $(1)/opt/bin/gcc_env.sh
	chmod +x $(1)/opt/bin/gcc_env.sh
endef

$(eval $(call BuildPackage,gcc))

#
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Entware specific: Our own patch set here.

include $(TOPDIR)/rules.mk
define Package/gcc/description
	Build a native toolchain for compiling on target
	device.
endef


define Package/gcc
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=gcc
  MAINTAINER:=Noble Pepper <gccmaintain@noblepepper.com>
  DEPENDS:= +binutils +libstdcpp @!arc
  MENU:=1
endef

PKG_NAME:=gcc
# PKG_VERSION=7.3.0
PKG_VERSION=7.4.0
PKG_RELEASE:=5
PKG_SOURCE_URL:=@GNU/gcc/gcc-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PATCH_DIR:=$(TOPDIR)/toolchain/gcc/patches/$(PKG_VERSION)
PKG_INSTALL:=1
PKG_FIXUP:=libtool
PKG_BUILD_PARALLEL:=1

PKG_CPE_ID:=cpe:/a:gnu:gcc

ifeq ($(PKG_VERSION),7.3.0)
	PKG_HASH:=832ca6ae04636adbb430e865a1451adf6979ab44ca1c8374f61fba65645ce15c
endif
ifeq ($(PKG_VERSION),7.4.0)
	PKG_HASH:=eddde28d04f334aec1604456e536416549e9b1aa137fc69204e65eb0c009fe51
endif


define Package/gcc/config
  source "$(SOURCE)/Config.in"
endef

ifeq ($(CONFIG_INCLUDE_STATIC_LIBC),y)
	COPY_STATIC_LIBC=cp -a $(TOOLCHAIN_DIR)/lib/libc.a $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
endif

ifeq ($(CONFIG_INCLUDE_STATIC_LIBPTHREAD),y)
	COPY_STATIC_LIBPTHREAD=cp -a $(TOOLCHAIN_DIR)/lib/libpthread.a $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
endif

ifeq ($(CONFIG_INCLUDE_STATIC_LIBSTDC),y)
	COPY_STATIC_LIBSTDC=cp -a $(TOOLCHAIN_DIR)/lib/libstdc++.a $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
endif

ifeq ($(CONFIG_INCLUDE_STATIC_LINK_SPEC),y)
	INSTALL_STATIC_SPEC=g++ -dumpspecs |sed s/--start-group}\ %G\ %L\ /--start-group}\ %G\ %L\ -lstdc++\ -lgcc_pic\ / >/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/specs
	REMOVE_STATIC_SPEC=rm /opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/specs
endif

include $(INCLUDE_DIR)/package.mk
TARGET_LANGUAGES:="c,c++"
BUGURL=https://dev.openwrt.org/
PKGVERSION=OpenWrt GCC $(PKG_VERSION)
TARGET_CPPFLAGS += -D_GLIBCXX_INCLUDE_NEXT_C_HEADERS

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
GMPSRC=gmp-6.1.0

define Download/gmp
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(GMPSRC).tar.bz2
  HASH:=498449a994efeba527885c10405993427995d3f86b8768d8cdf8d9dd7c6b73e8
endef
$(eval $(call Download,gmp))

MPCSRC=mpc-1.0.3

define Download/mpc
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(MPCSRC).tar.gz
  HASH:=617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3
endef
$(eval $(call Download,mpc))

MPFRSRC=mpfr-3.1.4

define Download/mpfr
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(MPFRSRC).tar.bz2
  HASH:=d3103a80cdad2407ed581f3618c4bed04e0c92d1cf771a65ead662cc397f7775
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
#uclibc needs -lm to build libcc1
ifdef CONFIG_USE_UCLIBC
	patch -p1 -d "$(PKG_BUILD_DIR)" < ./patches/004-libcc1_uclibc_lm.patch
endif
#	poor man's fix for `none-openwrt-linux' not recognized when building with musl
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/mpfr/
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/gmp/
	chmod u+w $(PKG_BUILD_DIR)/mpc/config.sub
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/mpc/
endef

CONFIGURE_ARGS +=  CXXFLAGS_FOR_TARGET="-g -O2 -D_GLIBCXX_INCLUDE_NEXT_C_HEADERS"

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
			--with-specs="-Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
			--with-boot-ldflags="static-libstdc++ -static-libgcc -Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
			--disable-nls \
			--disable-libsanitizer \
			--disable-libvtv \
			--disable-libcilkrts \
			--disable-libmudflap \
			--disable-libmpx \
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
			--with-stage1-ldflags="-lstdc++ -Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER)" \
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

ENVLDFLAGS:="-Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/$(DYNLINKER) -L/opt/lib, -lstdc++"

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
	$(COPY_STATIC_LIBC)
	$(COPY_STATIC_LIBPTHREAD)
	$(COPY_STATIC_LIBSTDC)
	rm -f $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libgo*
	rm -f $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libcc1*
	rm -f $(1)/opt/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libQt5* || true
	echo '#!/bin/sh' > $(1)/opt/bin/gcc_env.sh
	echo 'export LDFLAGS=$(ENVLDFLAGS)' >> $(1)/opt/bin/gcc_env.sh
	echo 'export CFLAGS=$(ENVCFLAGS)' >> $(1)/opt/bin/gcc_env.sh
	chmod +x $(1)/opt/bin/gcc_env.sh
endef

define Package/gcc/postinst
#!/bin/sh
$(INSTALL_STATIC_SPEC)
echo "There are no *-dev packages in Entware(with few exceptions)!"
echo "Please install headers as described in the wiki:"
echo "https://github.com/Entware/Entware/wiki"
endef

define Package/gcc/postrm
#!/bin/sh

$(REMOVE_STATIC_SPEC)
endef

$(eval $(call BuildPackage,gcc))

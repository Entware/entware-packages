#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=subversion
PKG_RELEASE:=2
PKG_VERSION:=1.12.2
PKG_SOURCE_URL:=@APACHE/subversion
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_HASH:=3bd0b5c8e4c5175263dc9a92fd9aef94ce917e80af034f26fe5c45fde7e0f771
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Val Kulkov <val.kulkov@gmail.com>
PKG_CPE_ID:=cpe:/a:apache:subversion

PKG_FIXUP:=autoreconf
PKG_MACRO_PATHS:=build/ac-macros
PKG_BUILD_DEPENDS:=apr-util
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk


define Package/subversion/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Version Control Systems
  TITLE:=A compelling replacement for CVS
  DEPENDS:=+PACKAGE_unixodbc:unixodbc +libaprutil +libmagic $(ICONV_DEPENDS) $(INTL_DEPENDS) +libserf
  URL:=https://subversion.apache.org/
endef

define Package/subversion/Default/description
  Subversion is a free/open-source version control system. That is,
  Subversion manages files and directories, and the changes made to them,
  over time. This allows you to recover older versions of your data, or
  examine the history of how your data changed. In this regard, many
  people think of a version control system as a sort of time machine.
endef

define Package/subversion-libs
  $(call Package/subversion/Default)
  TITLE:=subversion libs
endef

define Package/subversion-libs/description
  $(call Package/subversion/Default/description)
  This package contains the Subversion libraries.
endef

define Package/subversion-client
  $(call Package/subversion/Default)
  DEPENDS:=+subversion-libs
  TITLE:=subversion client tools
endef

define Package/subversion-client/description
  $(call Package/subversion/Default/description)
  This package contains the Subversion client tools.
endef

define Package/subversion-server
  $(call Package/subversion/Default)
  DEPENDS:=+subversion-libs
  TITLE:=subversion server
endef

define Package/subversion-server/description
  $(call Package/subversion/Default/description)
  This package contains the Subversion server.
endef

define Package/subversion-server/conffiles
/opt/etc/config/subversion
endef

TARGET_CFLAGS += $(FPIC) -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
APU_LIBS=$(shell $(STAGING_DIR)/opt/bin/apu-1-config --link-libtool --libs)
TARGET_LDFLAGS += $(APU_LIBS)

CONFIGURE_ARGS += \
	--with-apr="$(STAGING_DIR)/opt/bin/apr-1-config" \
	--with-apr-util="$(STAGING_DIR)/opt/bin/apu-1-config" \
	--with-libmagic="$(STAGING_DIR)/opt" \
	--with-serf="$(STAGING_DIR)/opt" \
	--disable-mod-activation \
	--without-ruby-sitedir \
	--without-swig \
	--without-jikes \
	--without-junit \
	--without-berkeley-db \
	--without-apxs \
	--without-sasl \
	--with-lz4=internal \
	--with-utf8proc=internal

ifdef $(INTL_FULL)
	CONFIGURE_ARGS += --enable-nls
else
	CONFIGURE_ARGS += --disable-nls
endif

define Package/subversion-libs/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsvn_*.so.* $(1)/opt/lib/
endef

define Package/subversion-client/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{svn,svnversion,svnsync,svnmucc,svnbench,svnfsfs} $(1)/opt/bin/
endef

define Package/subversion-server/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/svn{look,admin,dumpfilter,rdump,serve} $(1)/opt/bin/
endef

$(eval $(call BuildPackage,subversion-libs))
$(eval $(call BuildPackage,subversion-client))
$(eval $(call BuildPackage,subversion-server))

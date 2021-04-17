#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=subversion
PKG_VERSION:=1.14.1
PKG_RELEASE:=1

PKG_SOURCE_URL:=@APACHE/subversion
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_HASH:=2c5da93c255d2e5569fa91d92457fdb65396b0666fad4fd59b22e154d986e1a9

PKG_MAINTAINER:=Val Kulkov <val.kulkov@gmail.com>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:apache:subversion

PKG_FIXUP:=autoreconf
PKG_MACRO_PATHS:=build/ac-macros
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/subversion/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Version Control Systems
  TITLE:=A compelling replacement for CVS
  DEPENDS:=+PACKAGE_unixodbc:unixodbc +libaprutil +libmagic +libsqlite3 $(ICONV_DEPENDS) $(INTL_DEPENDS) +libserf
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

TARGET_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE

CONFIGURE_ARGS += \
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
	--with-utf8proc=internal \
	$(call autoconf_bool,INTL_FULL,nls)

TARGET_LDFLAGS += $(if $(INTL_FULL),-lintl)

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

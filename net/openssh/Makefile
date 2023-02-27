#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openssh
PKG_VERSION:=9.2p1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/ \
		https://ftp.spline.de/pub/OpenBSD/OpenSSH/portable/
PKG_HASH:=3f66dbf1655fb45f50e1c56da62ab01218c228807b21338d634ebcdf9d71cf46

PKG_LICENSE:=BSD ISC
PKG_LICENSE_FILES:=LICENCE
PKG_CPE_ID:=cpe:/a:openssh:openssh

PKG_REMOVE_FILES:=
PKG_CONFIG_DEPENDS := \
	CONFIG_OPENSSH_LIBFIDO2

PKG_BUILD_DEPENDS += OPENSSH_LIBFIDO2:libfido2

include $(INCLUDE_DIR)/package.mk

define Package/openssh/Default
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libopenssl +zlib
	TITLE:=OpenSSH
	MAINTAINER:=Peter Wagner <tripolar@gmx.at>
	URL:=http://www.openssh.com/
	SUBMENU:=SSH
endef

define Package/openssh-moduli
	$(call Package/openssh/Default)
	DEPENDS+= +openssh-keygen
	TITLE+= moduli file
endef

define Package/openssh-moduli/description
OpenSSH server moduli file.
endef

define Package/openssh-client
	$(call Package/openssh/Default)
	TITLE+= client
	ALTERNATIVES:=\
		200:/opt/bin/ssh:/opt/libexec/ssh-openssh \
		200:/opt/bin/scp:/opt/libexec/scp-openssh
endef

define Package/openssh-client/description
OpenSSH client.
endef

define Package/openssh-client/conffiles
/opt/etc/ssh/ssh_config
endef

define Package/openssh-client-utils
	$(call Package/openssh/Default)
	DEPENDS+= +openssh-client +openssh-keygen
	TITLE+= client utilities
endef

define Package/openssh-client-utils/description
OpenSSH client utilities.
endef

define Package/openssh-keygen
	$(call Package/openssh/Default)
	TITLE+= keygen
endef

define Package/openssh-keygen/description
OpenSSH keygen.
endef

define Package/openssh-server
	$(call Package/openssh/Default)
	DEPENDS+= +openssh-keygen +OPENSSH_LIBFIDO2:libfido2
	TITLE+= server
	USERID:=sshd=22:sshd=22
	VARIANT:=without-pam
endef

define Package/openssh-server/config
	source "$(SOURCE)/Config.in"
endef

define Package/openssh-server/description
OpenSSH server.
endef

define Package/openssh-server/conffiles
/opt/etc/ssh/sshd_config
/opt/etc/ssh/ssh_host_ed25519_key
/opt/etc/ssh/ssh_host_ed25519_key.pub
/opt/etc/ssh/ssh_host_rsa_key
/opt/etc/ssh/ssh_host_rsa_key.pub
endef

define Package/openssh-server-pam
	$(call Package/openssh/Default)
	DEPENDS+= +libpthread +openssh-keygen +libpam
	TITLE+= server (with PAM support)
	VARIANT:=with-pam
	USERID:=sshd=22:sshd=22
endef

define Package/openssh-server-pam/description
OpenSSH server (with PAM support).
endef

define Package/openssh-server-pam/conffiles
/opt/etc/pam.d/sshd
/opt/etc/security/access-sshd-local.conf
$(Package/openssh-server/conffiles)
endef

define Package/openssh-sftp-client
	$(call Package/openssh/Default)
	TITLE+= SFTP client
endef

define Package/openssh-sftp-client/description
OpenSSH SFTP client.
endef

define Package/openssh-sftp-server
	$(call Package/openssh/Default)
	TITLE+= SFTP server
endef

define Package/openssh-sftp-server/description
OpenSSH SFTP server.
endef

define Package/openssh-sftp-avahi-service
	$(call Package/openssh/Default)
	TITLE+= (SFTP Avahi service)
	DEPENDS:=+openssh-sftp-server +avahi-daemon
endef

define Package/openssh-sftp-avahi-service/description
 This package contains the service definition for announcing
 SFTP support via mDNS/DNS-SD.
endef

define Package/openssh-sftp-avahi-service/conffiles
/opt/etc/avahi/services/sftp-ssh.service
endef

CONFIGURE_ARGS += \
	--sysconfdir=/opt/etc/ssh \
	--with-pid-dir=/opt/var/run \
	--with-privsep-user=sshd \
	--with-privsep-path=/opt/var/empty \
	--disable-strip \
	--disable-etc-default-login \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--without-bsd-auth \
	--without-kerberos5 \
	--with-stackprotect \
	--with$(if $(CONFIG_OPENSSL_ENGINE),,out)-ssl-engine \
	--with$(if $(CONFIG_OPENSSH_LIBFIDO2),,out)-security-key-builtin

ifeq ($(BUILD_VARIANT),with-pam)
CONFIGURE_ARGS += \
	--with-pam
else
CONFIGURE_ARGS += \
	--without-pam
endif

CONFIGURE_VARS += LD="$(TARGET_CC)" PATH_PASSWD_PROG="/bin/passwd"

CONFIGURE_VARS += \
	ac_cv_func_getentropy=no \
	ac_cv_func_getrandom=no

ifeq ($(BUILD_VARIANT),with-pam)
TARGET_LDFLAGS += -lpthread
endif

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		STRIP_OPT="" \
		all install
endef

define Package/openssh-moduli/install
	install -d -m0700 $(1)/opt/etc/ssh
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/ssh/moduli $(1)/opt/etc/ssh/
endef

define Package/openssh-client/install
	install -d -m0700 $(1)/opt/etc/ssh
	$(CP) $(PKG_INSTALL_DIR)/opt/etc/ssh/ssh_config $(1)/opt/etc/ssh/
	$(INSTALL_DIR) $(1)/opt/libexec
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ssh $(1)/opt/libexec/ssh-openssh
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/scp $(1)/opt/libexec/scp-openssh
endef

define Package/openssh-client-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(foreach bin,add agent keyscan keysign,$(PKG_BUILD_DIR)/ssh-$(bin)) $(1)/opt/bin/
endef

define Package/openssh-keygen/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ssh-keygen $(1)/opt/bin/
endef

define Package/openssh-server/install
	install -d -m0700 $(1)/opt/etc/ssh
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/ssh/sshd_config $(1)/opt/etc/ssh/
	sed -r -i 's,^#(HostKey /opt/etc/ssh/ssh_host_(rsa|ed25519)_key)$$$$,\1,' $(1)/opt/etc/ssh/sshd_config
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S40sshd $(1)/opt/etc/init.d/
#	$(INSTALL_DIR) $(1)/lib/preinit
#	$(INSTALL_BIN) ./files/sshd.failsafe $(1)/lib/preinit/99_10_failsafe_sshd
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/sshd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/var/empty
endef

define Package/openssh-server-pam/install
	$(call Package/openssh-server/install,$(1))
	sed -i 's,#PasswordAuthentication yes,PasswordAuthentication no,g' $(1)/opt/etc/ssh/sshd_config
	sed -i 's,#UsePAM no,UsePAM yes,g' $(1)/opt/etc/ssh/sshd_config
	$(INSTALL_DIR) $(1)/opt/etc/pam.d
	$(INSTALL_DATA) ./files/sshd.pam $(1)/opt/etc/pam.d/sshd
	$(INSTALL_DIR) $(1)/opt/etc/security
	$(INSTALL_DATA) ./files/sshd.pam-access $(1)/opt/etc/security/access-sshd-local.conf
endef

define Package/openssh-sftp-client/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/sftp $(1)/opt/bin/
endef

define Package/openssh-sftp-server/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/sftp-server $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/libexec
	ln -sf ../lib/sftp-server $(1)/opt/libexec/sftp-server
endef

define Package/openssh-sftp-avahi-service/install
	$(INSTALL_DIR) $(1)/opt/etc/avahi/services
	$(INSTALL_DATA) ./files/sftp-ssh.service $(1)/opt/etc/avahi/services/
endef

$(eval $(call BuildPackage,openssh-client))
$(eval $(call BuildPackage,openssh-moduli))
$(eval $(call BuildPackage,openssh-client-utils))
$(eval $(call BuildPackage,openssh-keygen))
$(eval $(call BuildPackage,openssh-server))
$(eval $(call BuildPackage,openssh-server-pam))
$(eval $(call BuildPackage,openssh-sftp-client))
$(eval $(call BuildPackage,openssh-sftp-server))
$(eval $(call BuildPackage,openssh-sftp-avahi-service))

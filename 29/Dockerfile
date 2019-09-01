FROM fedora:29

# Force a rebuild for rpmdb, seems broken currently as of 2019-05-02
# sha256:8ee55e140e8751492ab2cfa4513c82093cd2716df9311ea6f442f1f1259cbb3e
RUN rpm --rebuilddb; \
 rm -rf /var/lib/rpm \
 && mv /var/lib/rpmrebuilddb.* /var/lib/rpm

RUN dnf update -y --setopt=install_weak_deps=False # 20190502

RUN dnf install -y --allowerasing \
  sudo wget curl which tar expect git \
  patch rpm-build redhat-rpm-config rpmlint \
  patch ccache make util-linux \
  dnf-utils rpmdevtools createrepo \
  php \
 && dnf clean all \
 && rm -rf /var/lib/dnf/* \
 && rm -f /var/lib/rpm/.*.lock

RUN wget -O /etc/yum.repos.d/ICINGA-release.repo \
 https://packages.icinga.com/fedora/ICINGA-release.repo

RUN groupadd -g 1000 build \
 && useradd -u 1000 -g 1000 -m build \
 && echo 'Defaults:build !requiretty' | tee -a /etc/sudoers \
 && echo 'build ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers \
 && chown build.build /usr/local/bin

USER build
RUN git clone https://git.icinga.com/build-docker/scripts.git /usr/local/bin
ENTRYPOINT ["/usr/local/bin/icinga-build-entrypoint"]
CMD ["icinga-build-package"]

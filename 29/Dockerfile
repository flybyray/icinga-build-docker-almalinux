FROM fedora:29

# Force a rebuild for rpmdb, seems broken currently as of 2019-05-02
# sha256:8ee55e140e8751492ab2cfa4513c82093cd2716df9311ea6f442f1f1259cbb3e
RUN rpm --rebuilddb; \
 rm -rf /var/lib/rpm \
 && mv /var/lib/rpmrebuilddb.* /var/lib/rpm

RUN dnf update -y --setopt=install_weak_deps=False # 20190502

# TODO: Remove this once the build deps for boost have been cleaned up...
RUN echo '%build_icinga_org 1' >/etc/rpm/macros.icinga_build

RUN dnf install -y --allowerasing \
  sudo wget curl which tar expect git \
  patch rpm-build redhat-rpm-config rpmlint \
  patch ccache make util-linux \
  dnf-utils rpmdevtools createrepo \
 && dnf clean all

RUN groupadd -g 1000 jenkins \
 && useradd -u 1000 -g 1000 -m jenkins \
 && echo 'Defaults:jenkins !requiretty' | tee -a /etc/sudoers \
 && echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers

RUN wget -O /etc/yum.repos.d/ICINGA-release.repo \
 https://packages.icinga.com/fedora/ICINGA-release.repo

RUN git clone https://git.icinga.com/build-docker/scripts.git /usr/local/bin
ENTRYPOINT ["/usr/local/bin/icinga-build-entrypoint"]
CMD ["icinga-build-package"]

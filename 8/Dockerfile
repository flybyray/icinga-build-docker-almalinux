FROM almalinux:8

RUN dnf update -y --setopt=install_weak_deps=False

RUN dnf install -y epel-release; \
  dnf install -y --allowerasing \
  sudo wget curl which tar expect git \
  patch rpm-build redhat-rpm-config rpmlint \
  patch ccache make util-linux \
  dnf-utils rpmdevtools createrepo gcc \
 && dnf clean all

RUN wget -O /etc/yum.repos.d/ICINGA-release.repo \
 https://packages.icinga.com/fedora/ICINGA-release.repo

RUN groupadd -g 1000 build \
 && useradd -u 1000 -g 1000 -m build \
 && echo 'Defaults:build !requiretty' | tee -a /etc/sudoers \
 && echo 'build ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers

RUN git clone https://git.icinga.com/build-docker/scripts.git /usr/local/bin
RUN icinga-provide-go
USER build
ENTRYPOINT ["/usr/local/bin/icinga-build-entrypoint"]
CMD ["icinga-build-package"]

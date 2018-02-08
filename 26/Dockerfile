FROM fedora:26

RUN dnf update -y

# TODO: Remove this once the build deps for boost have been cleaned up...
RUN echo '%build_icinga_org 1' >/etc/rpm/macros.icinga_build

RUN dnf install -y \
  sudo wget curl which tar expect git \
  patch rpm-build redhat-rpm-config rpmlint \
  patch ccache make util-linux \
  dnf-utils yum-plugin-ovl \
 && yum clean all

RUN groupadd -g 1000 jenkins \
 && useradd -u 1000 -g 1000 -m jenkins \
 && echo 'Defaults:jenkins !requiretty' | tee -a /etc/sudoers \
 && echo 'jenkins ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers

RUN wget -O /etc/yum.repos.d/ICINGA-release.repo \
 https://packages.icinga.com/fedora/ICINGA-release.repo

Docker package build environment for Fedora
===========================================

These images are our build environment for package builds with Jenkins.

Please note:
* This is for an internal build environment
* Image names are not best practice

## Building

```
#export DOCKER_REGISTRY=registry.example.com/
#export DOCKER_IMAGE_PREFIX=icinga/
make all
make push
```

## License

Icinga, all tools and documentation are licensed under the terms of the GNU
General Public License Version 2, you will find a copy of this license in the
COPYING file included in the source package.

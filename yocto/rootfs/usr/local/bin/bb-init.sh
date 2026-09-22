#!/bin/bash
set -e
set -o pipefail

mkdir -p /workspace/yocto
cd /workspace/yocto

git clone https://git.openembedded.org/bitbake -b yocto-6.0.3
git clone https://git.openembedded.org/openembedded-core -b wrynose
git clone https://git.yoctoproject.org/meta-yocto -b wrynose
git clone https://git.yoctoproject.org/meta-arm -b wrynose
git clone https://git.yoctoproject.org/meta-ti -b wrynose

#TODO make & source venv (needed?)
# . ../.venv/bin/activate
#install bitbake and toaster dependencies
# . openembedded-core/oe-init-build-env
# edit bblayers and conf
# bitbake core-image-minimal

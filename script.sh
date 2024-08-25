#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/sigmadroid-project/manifest.git -b sigma-14.3 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Trijal08/local_manifests -b SigmaDroid-14 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Private keys
git clone https://github.com/Trijal08/vendor_lineage-priv_keys.git vendor/lineage-priv/keys

# Export
export BUILD_USERNAME=GamerBoy1234•BecomingTooSigma
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch sigma_Mi439_4_19-ap2a-userdebug
make installclean
echo "============="

# Build ROM
make bacon

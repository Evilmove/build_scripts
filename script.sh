#!/bin/bash

# Remove existing local_manifests
rm -rf .repo/local_manifests/

# Initialize git lfs
git lfs install

# repo init manifest
repo init -u https://github.com/OrionOS-prjkt/android -b 14.0 --git-lfs --depth=1
echo "====================="
echo "= Repo init success ="
echo "====================="

# Clone DTs
rm -rf device/realme/spartan
git clone https://github.com/Evilmove/android_realme_spartan.git -b OrionOS device/realme/spartan
rm -rf hardware/oplus
git clone https://github.com/Evilmove/hardware_oplus.git -b 14 hardware/oplus
rm -rf vendor/realme/spartan
git clone https://github.com/Evilmove/proprietary_vendor_realme_spartan.git -b 14 vendor/realme/spartan
rm -rf kernel/realme/sm8250
git clone https://github.com/Evilmove/android_kernel_realme_spartan_A15.git -b lineage-22 kernel/realme/sm8250
echo "========================"
echo "= Clone DTs successful ="
echo "========================"

# Sync
/opt/crave/resync.sh || curl -s https://raw.githubusercontent.com/Trijal08/build_scripts/refs/heads/sync_script/resync.sh | bash
echo "================"
echo "= Sync success ="
echo "================"

# Auto-sign build
rm -rf vendor/lineage-priv/keys
wget https://raw.githubusercontent.com/Trijal08/crDroid-build-signed-script-auto/main/create-signed-env.sh
chmod a+x create-signed-env.sh
./create-signed-env.sh

# Export
export BUILD_USERNAME="Rahul • OrionStarsInTheSky"
export BUILD_HOSTNAME="crave"
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
breakfast spartan
make installclean -j$(nproc --all)
echo "============="

# Build ROM
croot
brunch spartan

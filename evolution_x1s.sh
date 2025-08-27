#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
rm -rf prebuilts/clang/host/linux-x86
rm -rf universal9830-common

# Init Rom Manifest
repo init -u https://github.com/LineageOS/android.git -b lineage-22.2 --git-lfs

# Clone local_manifests repository
git clone https://github.com/friendlycatt/local_manifests.git --depth 1 -b x1s .repo/local_manifests


# Sync the repositories  
/opt/crave/resync.sh 
# /opt/crave/resynctest.sh


# Set up build environment
export BUILD_USERNAME=cat 
export BUILD_HOSTNAME=crave

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi


# lunch lineage_x1s-bp1a-userdebug && make installclean && mka bacon
lunch lineage_x1s-bp1a-eng && make installclean && mka bacon

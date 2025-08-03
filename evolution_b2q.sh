#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
rm -rf prebuilts/clang/host/linux-x86


# Init Rom Manifest
repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs

# Clone local_manifests repository
git clone https://github.com/friendlycatt/local_manifests.git --depth 1 -b main .repo/local_manifests

# Sync the repositories  
/opt/crave/resync.sh 
# /opt/crave/resynctest.sh

# Set up build environment
export BUILD_USERNAME=friendlycatt 
export BUILD_HOSTNAME=crave

source build/envsetup.sh

if [ ! -e "vendor/evolution-priv" ]; then
    git clone https://github.com/Evolution-X/vendor_evolution-priv_keys-template vendor/evolution-priv/keys
    cd vendor/evolution-priv/keys
    chmod +x ./keys.sh
    cd ../../../
fi


export WITH_GMS=false
export TARGET_USES_MINI_GAPPS=false

# lunch lineage_b2q-bp2a-userdebug && make installclean && m evolution
lunch lineage_b2q-bp2a-eng && make installclean && m evolution

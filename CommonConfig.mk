# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fixes
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Common path
COMMON_PATH := device/motorola/common

# Do not build proprietary capability
TARGET_USES_AOSP := true

TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY ?= false
TARGET_NO_KERNEL := false

# common cmdline parameters
ifneq ($(BOARD_USE_ENFORCING_SELINUX),true)
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
endif
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += androidboot.memcg=1
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=0
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem,nosocket

BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --header_version $(BOARD_BOOT_HEADER_VERSION)

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb

# CPU ARCH
TARGET_ARCH := arm64
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

# Use mke2fs to create ext4/f2fs images
TARGET_USES_MKE2FS := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist

# Filesystem
TARGET_FS_CONFIG_GEN += $(COMMON_PATH)/mot_aids.fs

# Media
TARGET_USES_ION := true

# Audio
AUDIO_USE_DEEP_AS_PRIMARY_OUTPUT := false
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := false
AUDIO_FEATURE_ENABLED_SPKR_PROTECTION := false
AUDIO_FEATURE_ENABLED_SSR := false

# Camera
USE_CAMERA_STUB := true

# Charger
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BOARD_CHARGER_ENABLE_SUSPEND := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Wi-Fi Concurrent STA/AP
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY ?= true

# SELinux
include device/qcom/sepolicy_vndr/SEPolicy.mk
include device/sony/sepolicy/sepolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

# Device manifest: What HALs the device provides
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/vintf/manifest.xml
# Framework compatibility matrix: What the device(=vendor) expects of the framework(=system)
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(COMMON_PATH)/vintf/framework_compatibility_matrix.xml
DEVICE_MATRIX_FILE += $(COMMON_PATH)/vintf/compatibility_matrix.xml

# New vendor security patch level: https://r.android.com/660840/
# Used by newer keymaster binaries
VENDOR_SECURITY_PATCH=$(PLATFORM_SECURITY_PATCH)

# Memory
MALLOC_SVELTE := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# QCOM
BOARD_USES_QCOM_HARDWARE := true

# TEMP - Please Fix
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

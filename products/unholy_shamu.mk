#
# Copyright 2016 Nitrogen Project
# Copyright 2017 Unholy Developers
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
#

# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit some common Unholy stuff.
$(call inherit-product, vendor/unholy/configs/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/motorola/shamu/aosp_shamu.mk)

# Include Magisk by default
DEFAULT_ROOT_METHOD := magisk

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := shamu
PRODUCT_NAME := unholy_shamu
PRODUCT_BRAND := MOTOROLA
PRODUCT_MODEL := Nexus 6
PRODUCT_MANUFACTURER := MOTOROLA
PRODUCT_RESTRICT_VENDOR_FILES := false

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=shamu \
    BUILD_FINGERPRINT=google/shamu/shamu:7.1.1/N6F27H/4072753:user/release-keys \
    PRIVATE_BUILD_DESC="shamu-user 7.1.1 N6F27H 4072753 release-keys"
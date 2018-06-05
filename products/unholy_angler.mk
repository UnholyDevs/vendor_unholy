# Copyright (C) 2017 Unholy Development
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

# Inherit common unholiness
$(call inherit-product, vendor/unholy/configs/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/huawei/angler/aosp_angler.mk)

# Include Boot Animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Override AOSP build properties
PRODUCT_NAME := unholy_angler
PRODUCT_DEVICE := angler
PRODUCT_BRAND := Android
PRODUCT_MODEL := Nexus 6P
PRODUCT_MANUFACTURER := Huawei

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=angler \
	PRIVATE_BUILD_DESC="angler-user 8.1.0 OPM6.171019.030.B1 4768815 release-keys" \
	BUILD_FINGERPRINT="google/angler/angler:8.1.0/OPM6.171019.030.B1/4768815:user/release-keys"
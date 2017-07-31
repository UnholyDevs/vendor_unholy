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
$(call inherit-product, device/lge/bullhead/aosp_bullhead.mk)

# Include Magisk by default
DEFAULT_ROOT_METHOD := magisk

# Override AOSP build properties
PRODUCT_NAME := unholy_bullhead
PRODUCT_DEVICE := bullhead
PRODUCT_BRAND := Android
PRODUCT_MODEL := Nexus 5X
PRODUCT_MANUFACTURER := LG

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=bullhead \
	PRIVATE_BUILD_DESC="bullhead-user 7.1.2 N2G47Z 4045513 release-keys" \
	BUILD_FINGERPRINT="google/bullhead/bullhead:7.1.2/N2G47Z/4045513:user/release-keys"
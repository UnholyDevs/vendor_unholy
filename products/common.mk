# Generic product
PRODUCT_NAME := unholy
PRODUCT_BRAND := unholy
PRODUCT_DEVICE := generic

PRODUCT_BUILD_PROP_OVERRIDES := BUILD_DISPLAY_ID=$(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(BUILD_ID)

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.com.android.dataroaming=false \
    drm.service.enabled=true \
    net.tethering.noprovisioning=true \
    persist.sys.dun.override=0 \
    ro.build.selinux=1 \
    ro.adb.secure=0

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/unholy/overlay/common

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib - gesture typing
PRODUCT_COPY_FILES += \
    vendor/unholy/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# Extra packages
PRODUCT_PACKAGES += \
    LockClock \
    Stk \
    Terminal

# Init.d script support
PRODUCT_COPY_FILES += \
    vendor/unholy/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/unholy/prebuilt/common/etc/init.d.rc:root/init.d.rc

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/unholy/prebuilt/common/addon.d/50-unholy.sh:system/addon.d/50-unholy.sh \
    vendor/unholy/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/unholy/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions

# Versioning System
ANDROID_VERSION = 7.1.1
UD_VERSION = v1.0
ifndef UD_BUILD_TYPE
    UD_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
endif

# Set all versions
UD_VERSION := UD_$(UD_BUILD)_$(ANDROID_VERSION)_$(shell date -u +%Y%m%d-%H%M).$(UD_VERSION)-$(UD_BUILD_TYPE)
UD_MOD_VERSION := UD_$(UD_BUILD)_$(ANDROID_VERSION)_$(shell date -u +%Y%m%d-%H%M).$(UD_VERSION)-$(UD_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.du.version=$(DU_VERSION) \
    ro.mod.version=$(DU_BUILD_TYPE)-v11.0

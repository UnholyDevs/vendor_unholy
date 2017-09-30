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
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    drm.service.enabled=true \
    persist.sys.dun.override=0 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    persist.service.adb.enable=1 \
    ro.com.google.ime.theme_id=5

$(call inherit-product, vendor/unholy/configs/main.mk)

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# Allow tethering without provisioning app
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/unholy/overlay/common

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib - gesture typing
PRODUCT_COPY_FILES += \
    vendor/unholy/prebuilt/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# Extra packages
PRODUCT_PACKAGES += \
    LockClock \
    Terminal \
    Turbo \
    PixelLauncherPrebuilt
    #ThemeInterfacer
    #OmniStyle

# DU Utils Library
#PRODUCT_PACKAGES += \
    #org.dirtyunicorns.utils

#PRODUCT_BOOT_JARS += \
    #org.dirtyunicorns.utils

# Init.d script support
PRODUCT_COPY_FILES += \
    vendor/unholy/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/unholy/prebuilt/etc/init.d.rc:root/init.d.rc

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/unholy/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/unholy/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/unholy/prebuilt/bin/50-unholy.sh:system/addon.d/50-unholy.sh

#Only build Magisk if defined in device config
ifeq ($(DEFAULT_ROOT_METHOD),magisk)
# Magisk Manager
PRODUCT_PACKAGES += \
    MagiskManager

# Copy Magisk zip
PRODUCT_COPY_FILES += \
    vendor/unholy/prebuilt/zip/magisk.zip:system/addon.d/magisk.zip
endif

# Pull in Prebuilt applications 
$(call inherit-product-if-exists, vendor/prebuilt/prebuilt.mk)
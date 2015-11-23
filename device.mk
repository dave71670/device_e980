#
# Copyright (C) 2011 The Android Open-Source Project
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

# This file includes all definitions that apply to ALL geefhd devices, and
# are also specific to geefhd devices
#
# Everything in this directory will become public

$(call inherit-product, device/lge/gproj-common/gproj.mk)

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

PRODUCT_PACKAGES += \
	lights.geefhd \
	camera.geefhd

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/mixer_paths.xml:system/etc/mixer_paths.xml

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/thermald-geefhd.conf:system/etc/thermald.conf

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/initlogo.rle:root/initlogo.rle888 \
	$(LOCAL_PATH)/init.geefhd.rc:root/init.geefhd.rc \
	$(LOCAL_PATH)/fstab.geefhd:root/fstab.geefhd \
	$(LOCAL_PATH)/ueventd.geefhd.rc:root/ueventd.geefhd.rc

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

PRODUCT_COPY_FILES += \
       $(LOCAL_PATH)/keypad_8064.kl:system/usr/keylayout/gk-keypad-8064.kl

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bcmdhd.cal:system/etc/wifi/bcmdhd.cal

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=480

PRODUCT_PACKAGES += \
	hwaddrs

PRODUCT_PROPERTY_OVERRIDES += \
	ro.bt.bdaddr_path=/data/misc/bdaddr

# This hw ships locked, work around it with loki
PRODUCT_PACKAGES += \
	loki.sh \
	loki_tool_static_gproj \
	recovery-transform.sh

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml
# START SOME TWEAKS FROM NERDY DEVICE 	

PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.default_network=9 \
	telephony.lteOnGsmDevice=1

PRODUCT_PROPERTY_OVERRIDES += \
	pm.sleep.mode=1 \
	persist.sys.language=en-US \
	persist.sys.country=US \

# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true

# Do not power down SIM card when modem is sent to Low Power Mode.
PRODUCT_PROPERTY_OVERRIDES += \
	persist.radio.apm_sim_not_pwdn=1

# RIL
	PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.ril_class=LgeLteRIL \
	ro.telephony.ril.config=qcomdsds \
	rild.libpath=/system/lib/libril-qc-qmi-1.so \
	ro.telephony.call_ring.multiple=0
	
# Wifi Configs
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15 \
	ro.wifi.channels=13[SPACE]13

# Up to 3 layers can go through overlays
PRODUCT_PROPERTY_OVERRIDES += \
	persist.hwc.mdpcomp.enable=true

# More overrides from stock build.prop
PRODUCT_PROPERTY_OVERRIDES += \
	debug.sf.hw=1 \
	debug.egl.hw=1 \
	debug.composition.type=cpu \
	video.accelerate.hw=1 \
	wlan.chip.vendor=brcm \
	wlan.chip.version=bcm4334 \
	af.resampler.quality=255
	
# Better internet browsing & download speed
PRODUCT_PROPERTY_OVERRIDES += \
	net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.hspa=6144,87380,524288,6144,16384,262144 \
	net.tcp.buffersize.lte=524288,1048576,2097152,524288,1048576,2097152 \
	net.tcp.buffersize.hsdpa=6144,87380,1048576,6144,87380,1048576 \
	net.tcp.buffersize.evdo_b=6144,87380,1048576,6144,87380,1048576
	
# Random overrides
PRODUCT_PROPERTY_OVERRIDES += \
	debug.performance.tuning=1

$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)
$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)

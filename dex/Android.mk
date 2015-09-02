
LOCAL_PATH := $(call my-dir)
RELATIVE_AOC := $(LOCAL_PATH)/../..

X_INCLUDE_FILES := \
    ${aoc_path} \
    ${aoc_path}/vm \
    ${aoc_path}/vm/utils \
    ${aoc_path}/vm/dex \
    ${aoc_path}/compiler \
    ${aoc_path}/compiler/middleend \
    bionic \
    external/stlport/stlport \
    bionic/libstdc++/include \
    external/zlib \
    external/safe-iop/include \
    external/llvm/include \
    external/llvm/device/include \
    $(AOC_C_INCLUDES) \
    $(LLVM_ROOT_PATH)/include \
    ${LOCAL_PATH}/clibs/basic/include \
    ${LOCAL_PATH}/clibs/basic/arch/common \
    ${LOCAL_PATH}/dex2dex/include \
    ${LOCAL_PATH}/include \
    ${LOCAL_PATH}/lir/include \
    ${LOCAL_PATH}/linealloc/include \
    ${LOCAL_PATH}/analyse/include \
    ${LOCAL_PATH}/../com \
    ${LOCAL_PATH}/../opt \
    ${LOCAL_PATH} \
    dalvik

#X_LOCAL_CFLAGS := \
	-DLOG_TAG=\"DEX2DEX\" \
	-D_GNU_SOURCE=1\
	-D_ENABLE_LOG_\
	-O3 -DFOR_DEX\
	-Wno-empty-body\
	-Wno-write-strings -Wsign-promo -Werror=pointer-to-int-cast -Wparentheses\
	-Wformat -Wsign-compare -Wpointer-arith -Wno-multichar -Winit-self\
	-Wuninitialized -Wmaybe-uninitialized -Wtype-limits\
	-Wstrict-overflow -Wstrict-aliasing=3 -finline-limit=10000000 -Wswitch

X_LOCAL_CFLAGS := \
	-DLOG_TAG=\"DEX2DEX\" \
	-D_GNU_SOURCE=1\
	-D_VMWARE_DEBUG_\
	-D_ENABLE_LOG_\
	-ggdb -O0 -D_DEBUG_ -DFOR_DEX\
	-Wno-empty-body\
	-Wno-write-strings -Wsign-promo -Werror=pointer-to-int-cast -Wparentheses\
	-Wformat -Wsign-compare -Wpointer-arith -Wno-multichar -Winit-self\
	-Wuninitialized -Wmaybe-uninitialized -Wtype-limits\
	-Wstrict-overflow -Wstrict-aliasing=3 -finline-limit=10000000 -Wswitch \
	-Werror=overloaded-virtual

	#-DANDROID_SMP=1 -std=gnu++11 -DAOC_COMPAT -fpermissive

########################################################
#
# host version dex2dex share lib for LEMUR_PROJECT
#
########################################################
include $(CLEAR_VARS)
#must include vmkid/config.mk after CLEAR_VARS
#include $(RELATIVE_VMKID)/config.mk
include $(RELATIVE_AOC)/xoc/dex/config.mk

X_SRC_FILES:= \
    *.cpp\
    dex2dex/src/cpp/*.cpp\
    linealloc/src/cpp/*.cpp\
    lir/src/cpp/*.cpp\
    analyse/src/*.cpp\
    analyse/src/*.c\
    ../opt/*.cpp\
    ../com/*.cpp

LOCAL_CFLAGS += $(X_LOCAL_CFLAGS)

LOCAL_C_INCLUDES := $(X_INCLUDE_FILES)
LOCAL_SRC_FILES := $(foreach F, $(X_SRC_FILES), $(addprefix $(dir $(F)),$(notdir $(wildcard $(LOCAL_PATH)/$(F)))))

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libaoc_xoc

LOCAL_STATIC_LIBRARIES := libdex libz libcutils liblog

LOCAL_SHARED_LIBRARIES := libaoc_clibs  ##libaoc-compiler

LOCAL_MULTILIB := both
include $(BUILD_HOST_SHARED_LIBRARY)

########################################################
#
# target version dex2dex static lib for LEMUR_PROJECT
#
########################################################
include $(CLEAR_VARS)
#must include vmkid/config.mk after CLEAR_VARS
include $(RELATIVE_AOC)/xoc/dex/config.mk

X_SRC_FILES:= \
    dex2dex/src/cpp/*.cpp\
    linealloc/src/cpp/*.cpp\
    lir/src/cpp/*.cpp\
    ../opt/*.cpp\
    ../com/*.cpp\
    *.cpp\
    analyse/src/*.cpp\
    analyse/src/*.c

LOCAL_CFLAGS += $(X_LOCAL_CFLAGS)

LOCAL_C_INCLUDES := $(X_INCLUDE_FILES)

LOCAL_SRC_FILES := $(foreach F, $(X_SRC_FILES), $(addprefix $(dir $(F)),$(notdir $(wildcard $(LOCAL_PATH)/$(F)))))

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libaoc_xoc

LOCAL_STATIC_LIBRARIES := libdex libz libcutils liblog

LOCAL_SHARED_LIBRARIES := libaoc_clibs ##libaoc-compiler

include $(BUILD_SHARED_LIBRARY)

########################################################
#
# host version dex2dex executable for LEMUR_PROJECT
#
########################################################
include $(CLEAR_VARS)
#must include vmkid/config.mk after CLEAR_VARS
include $(RELATIVE_AOC)/xoc/dex/config.mk

X_SRC_FILES:= \
    dex2dex/src/cpp/*.cpp\
    linealloc/src/cpp/*.cpp\
    lir/src/cpp/*.cpp\
    analyse/src/*.cpp\
    analyse/src/*.c\
    *.cpp\
    ../com/*.cpp\
    ../opt/*.cpp

X_SRC_FILES:= dex2dex/src/test/main.cpp

LOCAL_C_INCLUDES := $(X_INCLUDE_FILES)
LOCAL_SRC_FILES := $(foreach F, $(X_SRC_FILES), $(addprefix $(dir $(F)),$(notdir $(wildcard $(LOCAL_PATH)/$(F)))))

LOCAL_CFLAGS += $(X_LOCAL_CFLAGS)
LOCAL_CFLAGS += -DHOST_LEMUR

LOCAL_STATIC_LIBRARIES := libdex libz liblog libcutils

LOCAL_SHARED_LIBRARIES := libaoc_clibs libaoc_xoc

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := aoc_hdex2dex

include $(BUILD_HOST_EXECUTABLE)

export ARCHS = arm64 arm64e
export TARGET = iphone::11.0:latest
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = libJCX
libJCX_FILES = $(wildcard JCXPreferences/*.m) $(wildcard Utilities/*.m)
libJCX_PUBLIC_HEADERS = libJCX.h $(wildcard JCXPreferences/*.h) $(wildcard Utilities/*.h)
libJCX_INSTALL_PATH = /Library/Frameworks
libJCX_PRIVATE_FRAMEWORKS = Preferences
libJCX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/framework.mk

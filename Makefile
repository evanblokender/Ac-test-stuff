TARGET = iphone:clang:latest:13.0
LIBRARY_NAME = CirclePopup
SOURCES = Sources/CirclePopup.m Sources/UIViewController+Hook.m
FRAMEWORKS = UIKit CoreGraphics
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

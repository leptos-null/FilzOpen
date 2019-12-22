include $(THEOS)/makefiles/common.mk

TOOL_NAME = open
open_FILES = filzopen/main.m
open_CFLAGS = -fobjc-arc
open_FRAMEWORKS = MobileCoreServices

include $(THEOS_MAKE_PATH)/tool.mk

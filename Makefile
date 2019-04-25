include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NiceCC
NiceCC_FILES = Tweak.xm
ARCHS = armv7 arm64 arm64e

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += niceccprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

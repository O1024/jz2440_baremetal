export Q = @
export JZ2440_ROOT_PATH = $(shell pwd)

TEXT_BASE = 0x00000000

export PATH := $(JZ2440_ROOT_PATH)/cross_compiler/gcc-arm-none-eabi-6_2-2016q4/bin:$(PATH)
export BUILD = $(JZ2440_ROOT_PATH)/build

export CROSS_COMPILE = arm-none-eabi-
export CC = $(CROSS_COMPILE)gcc
export OBJCOPY = $(CROSS_COMPILE)objcopy
export OBJDUMP = $(CROSS_COMPILE)objdump

CFLAGS = -mcpu=arm920t -O0 -Wall -I$(JZ2440_ROOT_PATH)/include 
export CFLAGS += -ffunction-sections -fdata-sections -DTEXT_BASE=$(TEXT_BASE) -Wl,--gc-sections,-Map=$(BUILD)/100ask_jz2440.map,-cref,-u,_start -nostartfiles 

all:
	$(Q)if test ! -d $(BUILD); then mkdir -p $(BUILD); fi
	$(Q)$(MAKE) -C $(JZ2440_ROOT_PATH)/src/$(T)

clean: 
	$(Q)rm -rf $(BUILD) doc/html
	$(Q)rm -f $(JZ2440_ROOT_PATH)/compile_commands.json

nor:
	$(Q)openocd -f openocd_jz2440v3.cfg -c "flash write_image erase build/100ask_jz2440.bin;exit"

openocd:
	$(Q)openocd -f openocd_jz2440v3_sdram.cfg

debug:
	$(Q)$(CROSS_COMPILE)gdb

doxygen:
	$(Q)rm -rf doc/html
	$(Q)doxygen doc/doxygen/Doxyfile
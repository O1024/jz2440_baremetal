include $(JZ2440_ROOT_PATH)/Makefile.build

led_on.bin: $(OBJS)
	$(Q)$(CC) $(CFLAGS) -Ttext 0x00000000 $(BUILD)/*.o -o $(BUILD)/100ask_jz2440.elf
	$(Q)$(OBJDUMP) -D -m arm $(BUILD)/100ask_jz2440.elf > $(BUILD)/100ask_jz2440.dis
	$(Q)$(OBJCOPY) -O binary -S $(BUILD)/100ask_jz2440.elf $(BUILD)/100ask_jz2440.bin

	$(Q)echo "\e[32m>>> compile success.\e[0m"

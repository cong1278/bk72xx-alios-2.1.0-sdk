NAME := board_bk7231

JTAG := jlink

$(NAME)_MBINS_TYPE := kernel
$(NAME)_VERSION    := 1.0.0
$(NAME)_SUMMARY    := configuration for board bk7231
MODULE             := BK7231
HOST_ARCH          := ARM968E-S
HOST_MCU_FAMILY    := mcu_bk7231
SUPPORT_MBINS      := no

$(NAME)_COMPONENTS += $(HOST_MCU_FAMILY) kernel_init

$(NAME)_SOURCES := board.c

GLOBAL_INCLUDES += .
#GLOBAL_DEFINES  += STDIO_UART=1
GLOBAL_DEFINES += CLI_CONFIG_SUPPORT_BOARD_CMD=1

CONFIG_SYSINFO_PRODUCT_MODEL := ALI_AOS_BK7231
CONFIG_SYSINFO_DEVICE_NAME   := BK7231

# OTA Board config
# 0:OTA_RECOVERY_TYPE_DIRECT 1:OTA_RECOVERY_TYPE_ABBACK 2:OTA_RECOVERY_TYPE_ABBOOT
#GLOBAL_CFLAGS += -DAOS_OTA_RECOVERY_TYPE=1
#GLOBAL_CFLAGS += -DAOS_OTA_2BOOT_CLI
#GLOBAL_CFLAGS += -DAOS_OTA_BANK_SINGLE

GLOBAL_CFLAGS += -DSYSINFO_PRODUCT_MODEL=\"$(CONFIG_SYSINFO_PRODUCT_MODEL)\"
GLOBAL_CFLAGS += -DSYSINFO_DEVICE_NAME=\"$(CONFIG_SYSINFO_DEVICE_NAME)\"

GLOBAL_LDS_INCLUDES += $($(NAME)_LOCATION)/bk7231devkitc.ld

# Extra build target include bootloader, and copy output file to eclipse debug file (copy_output_for_eclipse)
ifeq ($(PING_PONG_OTA),1)
EXTRA_TARGET_MAKEFILES +=  $($(HOST_MCU_FAMILY)_LOCATION)/gen_pingpong_bin.mk
else
EXTRA_TARGET_MAKEFILES +=  $($(HOST_MCU_FAMILY)_LOCATION)/gen_crc_bin.mk
endif

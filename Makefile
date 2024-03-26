ARCH_MX8MP:=arm64                                   # Architecture  Arm64 for MX8M Plus
CROSS_COMPILE_MX8MP:=aarch64-fslc-linux-         # Crosscompilation ToolChain Version and selection
KERNEL_DIR:=/home/fpga/WS_15_Voyancemed/01_Yocto/var_test/build_xwayland/tmp/work/imx8mp_var_dart-fslc-linux/linux-variscite/5.10.72+gitAUTOINC+e5feaddb65-r0/build/

MODULE_DIR  := $(shell pwd)                    # Module to be build's Directory

# SPDX-License-Identifier: GPL-2.0-only
obj-$(CONFIG_MT76_CORE) += mt76.o
#obj-m += mt76.o
#obj-$(CONFIG_MT76_USB) += mt76-usb.o
#obj-$(CONFIG_MT76_SDIO) += mt76-sdio.o
#obj-$(CONFIG_MT76x02_LIB) += mt76x02-lib.o
#obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o

mt76-y := \
	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
	tx.o agg-rx.o mcu.o

mt76-$(CONFIG_PCI) += pci.o
mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o

#mt76-usb-y := usb.o usb_trace.o
#$mt76-sdio-y := sdio.o

CFLAGS_trace.o := -I$(src)
#CFLAGS_usb_trace.o := -I$(src)
#CFLAGS_mt76x02_trace.o := -I$(src)

#mt76x02-lib-y := mt76x02_util.o mt76x02_mac.o mt76x02_mcu.o \
		 mt76x02_eeprom.o mt76x02_phy.o mt76x02_mmio.o \
		 mt76x02_txrx.o mt76x02_trace.o mt76x02_debugfs.o \
		 mt76x02_dfs.o mt76x02_beacon.o

#mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o

#obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
#obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
#obj-$(CONFIG_MT7603E) += mt7603/
#obj-$(CONFIG_MT7615_COMMON) += mt7615/
obj-$(CONFIG_MT7915E) += mt7915/


all:
	${MAKE} CROSS_COMPILE=${CROSS_COMPILE_MX8MP} ARCH=${ARCH_MX8MP} -C ${KERNEL_DIR} M=${MODULE_DIR} modules
 
clean:
	${MAKE} -C ${KERNEL_DIR} M=${MODULE_DIR} clean
# SPDX-License-Identifier: GPL-2.0-only
################################################################################
#
# Copyright (c) 2023 Motorcomm, Inc.
# Motorcomm Confidential and Proprietary.
#
# This is Motorcomm NIC driver relevant files. Please don't copy, modify,
# distribute without commercial permission.
#
################################################################################

BASEDIR := /lib/modules/$(shell uname -r)
KERNELDIR ?= $(BASEDIR)/build
PWD :=$(shell pwd)

KERNEL_GCC_VERSION := $(shell cat /proc/version | sed -n 's/.*gcc version \([[:digit:]]\.[[:digit:]]\.[[:digit:]]\).*/\1/p')
CCVERSION = $(shell $(CC) -dumpversion)

KVER = $(shell uname -r)

all: print_vars clean modules install

print_vars:
	@echo
	@echo "CC: " $(CC)
	@echo "CCVERSION: " $(CCVERSION)
	@echo "KERNEL_GCC_VERSION: " $(KERNEL_GCC_VERSION)
	@echo "KVER: " $(KVER)
	@echo

modules:
	@echo
	$(MAKE) -C src/ modules
	@echo

clean:
	@echo
	$(MAKE) -C src/ clean
	@echo

install:
	@echo
	$(MAKE) -C src/ install
	@echo

uninstall:
	@echo
	$(MAKE) -C src/ uninstall
	@echo
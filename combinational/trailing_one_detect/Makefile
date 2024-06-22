SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(LEAD), 1)
	top = leading_one_detect
	VERILOG_SOURCES = $(top).sv trailing_one_detect.sv
else
	top = trailing_one_detect
	VERILOG_SOURCES = $(top).sv 
endif

TOPLEVEL = $(top)
MODULE = test_$(top)
include $(shell cocotb-config --makefiles)/Makefile.sim

.PHONY: ${SIM_BUILD}/sim.vvp ${SIM_BUILD}/cocotb_iverilog_dump.v

SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(SOLN), 1)
	PREFIX = solution/
endif

VERILOG_SOURCES = $(PREFIX)divider.sv
TOPLEVEL = divider
MODULE = test_divider
WAVES = 1
include $(shell cocotb-config --makefiles)/Makefile.sim

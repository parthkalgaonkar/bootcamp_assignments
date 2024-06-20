SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(SOLN), 1)
	PREFIX = solution/
endif

VERILOG_SOURCES = $(PREFIX)mem.sv
TOPLEVEL = mem
MODULE = test_mem
WAVES = 1
include $(shell cocotb-config --makefiles)/Makefile.sim

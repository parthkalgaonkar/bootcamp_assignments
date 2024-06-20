SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(SOLN), 1)
	PREFIX = solution/
endif

VERILOG_SOURCES = $(PREFIX)mem.sv
TOPLEVEL = mem
MODULE = test_mem
include $(shell cocotb-config --makefiles)/Makefile.sim

SIM = icarus
TOPLEVEL_LANG = verilog
PREFIX=""
ifeq ($(SOLN),1)
	PREFIX = solution/
endif
VERILOG_SOURCES = $(PREFIX)sorting_box.sv
TOPLEVEL = sorting_box
MODULE = test_sorting_box
COMPILE_ARGS = -DDUMP_WAVES
include $(shell cocotb-config --makefiles)/Makefile.sim

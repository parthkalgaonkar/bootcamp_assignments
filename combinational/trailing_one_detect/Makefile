SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(SOLN), 1)
	PREFIX = solution/
endif

ifeq ($(LEAD), 1)
	top = leading_one_detect
	VERILOG_SOURCES = $(PREFIX)$(top).sv $(PREFIX)trailing_one_detect.sv
else
	top = trailing_one_detect
	VERILOG_SOURCES = $(PREFIX)$(top).sv
endif

TOPLEVEL = $(top)
MODULE = test_$(top)

COMPILE_ARGS = -DDUMP_WAVES
include $(shell cocotb-config --makefiles)/Makefile.sim

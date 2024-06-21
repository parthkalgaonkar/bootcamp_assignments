SIM = icarus
TOPLEVEL_LANG = verilog
top	=	prog_add_sub
PREFIX=""
ifeq ($(SOLN),1)
	PREFIX = solution/
endif
VERILOG_SOURCES = $(PREFIX)$(top).sv $(PREFIX)ripple_carry_adder.sv
TOPLEVEL = $(top)
MODULE = test_$(top)
WAVES  = 1
COMPILE_ARGS = -DDUMP_WAVES
include $(shell cocotb-config --makefiles)/Makefile.sim

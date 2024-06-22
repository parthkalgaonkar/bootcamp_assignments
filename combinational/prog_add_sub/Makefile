SIM = icarus
TOPLEVEL_LANG = verilog
top	=	prog_add_sub
VERILOG_SOURCES = $(top).sv ripple_carry_adder.sv
TOPLEVEL = $(top)
MODULE = test_$(top)
include $(shell cocotb-config --makefiles)/Makefile.sim

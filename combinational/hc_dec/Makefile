SIM = icarus
TOPLEVEL_LANG = verilog
top	=	hc_dec
PREFIX=""
ifeq ($(SOLN),1)
	PREFIX = solution/
endif
VERILOG_SOURCES = $(PREFIX)$(top).sv 
TOPLEVEL = $(top)
MODULE = test_$(top)
COMPILE_ARGS = -DDUMP_WAVES
include $(shell cocotb-config --makefiles)/Makefile.sim

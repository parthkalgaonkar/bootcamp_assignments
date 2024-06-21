SIM = icarus
TOPLEVEL_LANG = verilog
top	=	alu
PREFIX=""
ifeq ($(SOLN),1)
	PREFIX = solution/
endif
VERILOG_SOURCES = $(PREFIX)$(top).sv 
TOPLEVEL = $(top)
MODULE = test_$(top)
WAVES=1
COMPILE_ARGS = -DDUMP_WAVES -incdir solution/
include $(shell cocotb-config --makefiles)/Makefile.sim

SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(SOLN), 1)
	PREFIX = solution/
endif

VERILOG_SOURCES = ${PREFIX}nrzi_decode.sv
TOPLEVEL = nrzi_decode
MODULE = test_nrzi
WAVES = 1

include $(shell cocotb-config --makefiles)/Makefile.sim

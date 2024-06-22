import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer

# Function to generate the Reset Signal
async def reset(dut):
    dut.i_rstb.value = 1
    await Timer(1, units = "ns")
    dut.i_rstb.value = 0
    await Timer(1, units = "ns")
    dut.i_rstb.value = 1
    return
    
# Testbench
@cocotb.test()
async def test_counter(dut):
    # Clock Initialization
    cocotb.start_soon(Clock(dut.i_clk, 1, units = "ns").start())
    dut.i_tm_reset.value = 0
    dut.i_tm_direction.value = 0
    # Stimulus Generation
    await reset(dut)
    await Timer(1, units = "us")
    dut.i_tm_reset.value = 1
    dut.i_tm_direction.value = 1
    await Timer(1, units = "ns")
    dut.i_tm_reset.value = 0
    await Timer(1, units = "us")
    return

    

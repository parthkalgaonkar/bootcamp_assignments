import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer

async def reset(dut):
    dut.i_rstb.value = 1
    await Timer(1, units = "ns")
    dut.i_rstb.value = 0
    await Timer(1, units = "ns")
    dut.i_rstb.value = 1
    return

@cocotb.test()
async def test_fifo(dut):
    dut.i_data.value = 0
    dut.i_write.value = 0
    dut.i_read.value = 0
    cocotb.start_soon(Clock(dut.i_clk, 1, units = "ns").start())
    await reset(dut)
    # Test : Write SIZE. Readback should return first 15 values
    data_in = [n for n in range(100)]
    for n in range(dut.SIZE.value):
        await FallingEdge(dut.i_clk)
        dut.i_data.value = int(data_in[n])
        dut.i_write.value = 1
    assert (dut.o_full.value.integer == 1)
    dut.i_write.value = 0
    for n in range(dut.SIZE.value-1):
        await FallingEdge(dut.i_clk)
        dut.i_read.value = 1
        assert(dut.o_data.value.integer == data_in[n])

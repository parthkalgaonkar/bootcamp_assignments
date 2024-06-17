import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer

# Function for generating test vectors
def gen_test(BW):
    a = [0, 0, 2**(BW)-1, 2**(BW)-1]
    b = [0, 2**(BW)-1, 0, 2**(BW)-1]
    result = [a[n] + b[n] for n in range(len(a))]
    return a, b, result

@cocotb.test()
async def test_adder(dut):
    [a, b, result] = gen_test(dut.DATA_WD.value)
    for n in range(len(a)):
        dut.i_a.value = int(a[n])
        dut.i_b.value = int(b[n])
        await Timer(1, units = "ns")
        assert result[n] == dut.o_sum.value.integer

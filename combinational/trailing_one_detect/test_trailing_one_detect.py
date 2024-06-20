import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer
import random

# Function for generating test vectors
def gen_test(BW):
    a = [random.randint(0,2**(BW)-1), random.randint(0,2**(BW)-1), random.randint(0,2**(BW)-1), random.randint(0,2**(BW)-1)]
    result = []
    for  i in range(len(a)):
        bin_a = bin(a[i])
        result.append(0)
        for pos in range(len(bin_a)):
            if bin_a[len(bin_a)-1-pos] == '1':
                result[i] = pos
                break
    return a, result

@cocotb.test()
async def test_trailing_one_detect(dut):
    [a, result] = gen_test(dut.DATA_WD.value)
    for n in range(len(a)):
        dut.i_a.value = int(a[n])
        await Timer(1, units = "ns")
        cocotb.log.info(f"Input {a[n]}  : Expected_output: {result[n]} Actual output: {dut.o_index.value.integer}")
        assert result[n] == dut.o_index.value.integer


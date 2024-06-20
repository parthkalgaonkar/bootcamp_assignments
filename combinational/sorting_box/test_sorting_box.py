import cocotb
from cocotb.triggers import Timer
import random

def gen_test(BW,N,signed=0):
    a = []
    for i in range(N):
        if signed == 0:
            a.append(random.randint(0,2**BW-1))
        else:
            a.append(random.randint(-2**(BW-1)+1,2**(BW-1)-1))
    result = a
    result.sort()
    return a,result


@cocotb.test()
async def test_sorting_box(dut):
    signed = dut.SIGNED.value
    N      = 4
    for i in  range(4):
        act_res = []
        [a, result] = gen_test(dut.DATA_WD.value,N,signed)
        for j in range(N):
            dut.i_a[j].value    =   a[j]
        await Timer(1, units = "ns")
        for j in range(N):
            if signed == 1:
                act_res.append(dut.o_sorted_a[j].value.signed_integer)
            else:
                act_res.append(dut.o_sorted_a[j].value.integer)
        cocotb.log.info(f"Expected:{result} Actual:{act_res}")
        for j in range(N):
            if signed == 1:
                assert result[j] == dut.o_sorted_a[j].value.signed_integer
            else:
                assert result[j] == dut.o_sorted_a[j].value.integer

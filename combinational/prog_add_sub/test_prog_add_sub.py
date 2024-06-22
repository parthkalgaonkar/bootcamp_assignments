import cocotb
from random import randint
from cocotb.triggers import Timer

def gen_test(BW,N):
    a=[]
    b=[]
    mode = []
    res_ovr = []
    res     = []
    for i in range(N):
        a.append(randint(0,2**BW-1))
        b.append(randint(0,2**BW-1))
        mode.append(randint(0,1))
    for i in range(N):
        if mode[i] == 0:
            res.append(a[i] + b[i])
            res_ovr.append(0)
        else:
            res.append((a[i] - b[i])%2**BW)
            if (a[i] - b[i] > 0):
                res_ovr.append(0)
            else:
                res_ovr.append(1)
    return [a,b,mode,res_ovr,res]


@cocotb.test()
async def test_prog_add_sub(dut):
    N = 4
    [a,b,mode,res_ovr,res] = gen_test(dut.DATA_WD.value,N)
    for i in range(N):
        dut.i_mode.value    =   mode[i]
        dut.i_a.value       =   a[i]
        dut.i_b.value       =   b[i]
        await Timer(1,units="ns")
        assert res[i] == dut.o_arith_out.value.integer,f"MODE: {mode[i]} Expected res:{res[i]}, Actual res:{dut.o_arith_out.value.integer}"
        assert res_ovr[i] == dut.o_ovr.value.integer,f"MODE:{mode[i]} Expected ovr:{res_ovr[i]} Actual ovr:{dut.o_ovr.value.integer}"


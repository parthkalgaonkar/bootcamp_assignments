import cocotb
from cocotb.triggers import Timer
from random import randint

def posRedundantBits(data, r):
    j = 0
    k = 1
    m = len(data)
    res = ''
    for i in range(1, m + r+1):
        if(i == 2**j):
            res = res + '0'
            j += 1
        else:
            res = res + data[-1 * k]
            k += 1
    return res[::-1]


def calcParityBits(arr, r):
    n = len(arr)
    for i in range(r):
        val = 0
        for j in range(1, n + 1):
            if(j & (2**i) == (2**i)):
                val = val ^ int(arr[-1 * j])
        arr = arr[:n-(2**i)] + str(val) + arr[n-(2**i)+1:]
    return arr




def gen_test(BW,CW,N):
    a = []
    res = []
    if (2**CW < BW+CW+1) :
        raise(ValueError(f"Given Check bitwidth : {CW} not enough for datawidth : {BW}"))
    for i in range(N):
        a.append(randint(0,2**(BW)-1))

    for i in range(N):
# Enter the data to be transmitted
        bin_a = bin(a[i]).replace("0b","")
        bin_a = bin_a.zfill(BW+CW-len(bin_a))
# Determine the positions of Redundant Bits
        arr = posRedundantBits(bin_a, CW)
# Determine the parity bits
        arr = calcParityBits(arr, CW)
# Data to be transferred
        res.append(arr) 

    return a,res


@cocotb.test()
async def test_hc_enc(dut):
    N = 4
    [a, res] = gen_test(dut.DATA_WD.value, dut.CHK_WD.value,N)
    for i in range(N):
        dut.i_data.value    =    a[i]
        await Timer(1,units="ns")
        assert int(res[i],2)   ==  dut.o_enc_data.value.integer


import cocotb
from cocotb.triggers import Timer
from random import randint
from math import log


def gen_test(BW,CW,N):
    a = []
    res = []
    res_err = []
    if (2**CW < BW+CW+1) :
        raise(ValueError(f"Given Check bitwidth : {CW} not enough for datawidth : {BW}"))
    for i in range(N):
        a.append(randint(0,2**(BW+CW)-1))

    for i in range(N):
        bin_a = bin(a[i]).replace("0b","")
        bin_a = bin_a.zfill(BW+CW)
        bin_corr = ''
        err_pos = 0
        # Find the error pos
        for m in range(len(bin_a)):
            if (bin_a[-1*(m+1)] == '1'):
                err_pos = err_pos ^ (m+1) 
        #Correct the packet 
        if err_pos != 0:
            bin_update  = '1' if bin_a[-1*(err_pos)] == '0' else '0'
            if err_pos == 1:
                bin_a  = bin_a[:-1*(err_pos)] + bin_update
            else:
                bin_a  = bin_a[:-1*(err_pos)] + bin_update + bin_a[-1*(err_pos-1):]
        #Get the data bits
        k=1
        bin_res = [None]*BW
        for m in  range(len(bin_a)):
            if (log(m+1,2) != int(log(m+1,2)) ):
                bin_res[-1*k] = bin_a[-1*(m+1)]
                k = k + 1
        bin_res = ''.join(bin_res)
        bin_res = '0b' + bin_res
        res.append(int(bin_res,2))
        if (err_pos==0):
            res_err.append(0)
        else:
            res_err.append(1)
                    
    return a,res,res_err





@cocotb.test()
async def test_hc_dec(dut):
    N = 4
    [a, res, res_err] = gen_test(dut.DATA_WD.value, dut.CHK_WD.value,N)
    for i in range(N):
        dut.i_enc_data.value    =    a[i]
        await Timer(1,units="ns")
        assert res_err[i]   ==  dut.o_err_flag.value.integer
        assert res[i]   ==  dut.o_dec_data.value.integer



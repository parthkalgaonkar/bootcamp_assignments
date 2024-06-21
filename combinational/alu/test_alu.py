import cocotb
from random import randint
from cocotb.triggers import Timer


@cocotb.test()
async def test_alu(dut):
    pc    =   randint(0,2^8-1)
    imm   =   randint(0,2^8-1)
    rs1_val   =   randint(0,2^8-1)
    rs2_val   =   randint(0,2^8-1)
    alu_control   =   randint(0,2^3-1)

    dut.pc.value    =   pc
    dut.imm.value   =   imm
    dut.rs1_val.value   =   rs1_val
    dut.rs2_val.value   =   rs2_val
    dut.alu_control.value   =   alu_control
    res_valid = 0
    res = 0
    if (alu_control == 1):
        res_valid = 1
        res = rs1_val + rs2_val
    elif (alu_control == 2):
        res_valid = 1
        res = rs1_val - rs2_val
    elif (alu_control == 3):
        res_valid = 1
        res = rs1_val ^ rs2_val
    elif (alu_control == 4):
        res_valid = 1
        res = rs1_val | rs2_val
    elif (alu_control == 5):
        res_valid = 1
        res = rs1_val & rs2_val
    elif (alu_control == 6):
        res_valid = 1
        res = rs1_val << rs2_val
    elif (alu_control == 6):
        res_valid = 1
        res = rs1_val >> rs2_val
    elif (alu_control == 7):
        res_valid = 1
        res = int(rs1_val/2)

    await Timer(1,units="ns")
    assert res_valid == dut.rd_write_control.value
    assert res == dut.rd_write_val.value
    


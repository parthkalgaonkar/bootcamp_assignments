
module alu(
    input logic [31:0] pc,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [4:0] alu_control,
    output logic rd_write_control, //indicates whether the alu executes or not 1:EXECUTE 0:IDLE
    output logic [31:0] rd_write_val
);

endmodule


`include "processor_defines.sv"
module alu(
    input logic [31:0] pc,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [4:0] alu_control,
    output logic rd_write_control,
    output logic [31:0] rd_write_val
);

always @ (*) begin
    rd_write_control = 1'b0;
    rd_write_val = 32'h0;
    case (alu_control)
        `ADD: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val + rs2_val;
        end
        `SUB: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val - rs2_val;
        end
        `XOR: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val ^ rs2_val;
        end
        `OR: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val | rs2_val;
        end
        `AND: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val & rs2_val;
        end
        `SLL: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val << rs2_val;
        end
        `SRL: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val >> rs2_val;
        end
        `SRA: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val >>> rs2_val;
        end
        `SLT: begin
            rd_write_control = 1'b1;
            rd_write_val = $signed(rs1_val) < $signed(rs2_val);
        end
        `SLTU: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val < rs2_val;
        end

        `ADDI: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val + imm;
        end
        `XORI: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val ^ imm;
        end
        `ORI: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val | imm;
        end
        `ANDI: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val & imm;
        end
        `SLLI: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val << {imm[0], imm[1], imm[2], imm[3], imm[4]};
        end
        `SRLI: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val >> {imm[0], imm[1], imm[2], imm[3], imm[4]};
        end
        `SRAI: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val >>> {imm[0], imm[1], imm[2], imm[3], imm[4]};
        end
        `SLTI: begin
            rd_write_control = 1'b1;
            rd_write_val = $signed(rs1_val) < $signed(imm);
        end
        `SLTIU: begin
            rd_write_control = 1'b1;
            rd_write_val = rs1_val < imm;
        end

        `LUI: begin
            rd_write_control = 1'b1;
            rd_write_val = imm;
        end
        `AUIPC: begin
            rd_write_control = 1'b1;
            rd_write_val = pc + imm;
        end

    endcase
end

   /*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
    */

`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/alu.vcd");
        $dumpvars(0, alu);
     end
`endif


endmodule


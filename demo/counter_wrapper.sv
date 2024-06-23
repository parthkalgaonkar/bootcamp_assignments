`timescale 1ns/100ps

module counter_wrapper
  #(
    parameter COUNT_WD = 16
    )
   (
    input logic                 i_clk,
    input logic                 i_rstb,
    input logic                 i_tm_reset,
    input logic                 i_tm_direction,
    output logic [COUNT_WD-1:0] o_count
    );
   

   counter #(.COUNT_WD (COUNT_WD)) dut
     (
      // Outputs
      .o_count                          (o_count),
      // Inputs
      .i_clk                            (i_clk),
      .i_rstb                           (i_rstb),
      .i_tm_reset                       (i_tm_reset),
      .i_tm_direction                   (i_tm_direction)
      );

   initial
     begin
        $dumpfile("./counter_cocotb.vcd");
        $dumpvars(0, counter_wrapper);
     end

endmodule


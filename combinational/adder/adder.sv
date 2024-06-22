`timescale 1ns/100ps
module adder
  #(
    parameter DATA_WD = 16
    )
   (
    input logic [DATA_WD-1:0] i_a,
    input logic [DATA_WD-1:0] i_b,
    output logic [DATA_WD:0]  o_sum
    );

   always @(*) begin
      o_sum = {1'b0, i_a} + {1'b0, i_b};
   end

   /*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
    */

`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/adder.vcd");
        $dumpvars(0, adder);
     end
`endif
   
endmodule

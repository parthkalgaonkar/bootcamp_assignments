`timescale 1ns/100ps
module trailing_one_detect
  #(
    parameter DATA_WD = 8,
    parameter IND_WD  = $clog2(DATA_WD)
    )
   (
    input logic [DATA_WD-1:0] i_a,
    output logic [IND_WD-1:0]  o_index
    );

    logic [DATA_WD-1:0] one_hot_enc;

    always @(*)
     begin
         one_hot_enc = i_a & -(i_a);
         o_index = {(IND_WD){1'b0}};
         for (int j=0; j<IND_WD; j++) begin
             for (int i=2**j; i<DATA_WD; i+=2**(j+1)) begin
                 for (int k=0;k<2**j; k++) begin
                     o_index[j] = o_index[j] | one_hot_enc[i+k] ;
                 end
             end
         end
     end

   /*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
    */

`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/trailing_one_detect.vcd");
        $dumpvars(0, trailing_one_detect);
     end
`endif
   
endmodule

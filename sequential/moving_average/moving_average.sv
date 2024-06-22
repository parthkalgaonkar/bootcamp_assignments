
`timescale 1ns/100ps
module moving_average
  #(
    parameter DATA_WD = 16
    )
   (
    input logic                       i_clk,
    input logic                       i_rstb,
    input logic signed [DATA_WD-1:0]  i_data,
    output logic signed [DATA_WD-1:0] o_data
    );

   /*
    A 4 tap moving average filter using a delay chain
    */

   logic signed [DATA_WD-1:0]         r_data_dc [4];
   logic signed [DATA_WD+1:0]         r_sum;
   integer                            ii;

   always @(*) begin
      r_sum = r_data_dc[0] + r_data_dc[1] + r_data_dc[2] + r_data_dc[3];
   end
   
   always @(posedge i_clk or negedge i_rstb) begin
        if (~i_rstb) begin
           for (ii = 0; ii < 4; ii++)
             r_data_dc[ii] <= 'b0;
           o_data <= 'b0;
        end else begin
           r_data_dc[0] <= i_data;
           for (ii = 1; ii < 4; ii++)
             r_data_dc[ii] <= r_data_dc[ii-1];
           o_data <= r_sum[DATA_WD+1:2];
        end
   end
   
`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/moving_average.vcd");
        $dumpvars(0, moving_average);
     end
`endif
   
endmodule

     

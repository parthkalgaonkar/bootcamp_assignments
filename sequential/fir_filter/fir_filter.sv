`timescale 1ns/100ps
module fir_filter
  (
   input logic                i_clk,
   input logic                i_rstb,
   input logic signed [15:0]  i_data,
   input logic signed [15:0]  i_coeff0,
   input logic signed [15:0]  i_coeff1,
   input logic signed [15:0]  i_coeff2,
   input logic signed [15:0]  i_coeff3,
   output logic signed [15:0] o_data
   );

   logic signed [15:0]        r_data_dc [4];
   integer                    ii;
   logic signed [31:0]        r_mul_out0, r_mul_out1, r_mul_out2, r_mul_out3;
   logic signed [33:0]        r_filt_out;
   logic signed [17:0]        r_filt_out_shift;
   logic                      r_pos_ovr, r_neg_ovr;
   
   always @(*) begin
      r_mul_out0 = r_data_dc[0] * i_coeff0;
      r_mul_out1 = r_data_dc[1] * i_coeff1;
      r_mul_out2 = r_data_dc[2] * i_coeff2;
      r_mul_out3 = r_data_dc[3] * i_coeff3;
      r_filt_out = r_mul_out0 + r_mul_out1 + r_mul_out2 + r_mul_out3;
      // Scaling and saturation
      r_filt_out_shift = r_filt_out[33:16];
      r_pos_ovr  = (r_filt_out_shift[17] == 1'b0) & (r_filt_out_shift[16:15] != 2'b00);
      r_neg_ovr  = (r_filt_out_shift[17] == 1'b1) & (r_filt_out_shift[16:15] != 2'b11);
      case({r_pos_ovr, r_neg_ovr})
        2'b00 : o_data = r_filt_out_shift[15:0];
        2'b01 : o_data = {1'b1, {15{1'b0}}};
        2'b10 : o_data = {1'b0, {15{1'b1}}};
        2'b11 : o_data = r_filt_out_shift[15:0]; // This condition can never occur
      endcase
   end

   always @(posedge i_clk or negedge i_rstb) begin
      if (~i_rstb) begin
         for (ii = 0; ii < 4; ii++)
           r_data_dc[ii] <= 'b0;
      end else begin
         r_data_dc[0] <= i_data;
         r_data_dc[1] <= r_data_dc[0];
         r_data_dc[2] <= r_data_dc[1];
         r_data_dc[3] <= r_data_dc[2];
      end
   end
   

`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/fir_filter.vcd");
        $dumpvars(0, fir_filter);
     end
`endif

endmodule
   

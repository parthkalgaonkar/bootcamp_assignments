`timescale 1ns/100ps

module counter
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


   logic [COUNT_WD-1:0]         r_count, r_count_inc, r_count_next;

   always @(*)
     begin
        r_count_inc  = i_tm_direction ? {COUNT_WD{1'b1}} : {{(COUNT_WD-1){1'b0}}, 1'b1};
        r_count_next = i_tm_reset ? 'b0 : r_count + r_count_inc;
        //
        o_count      = r_count;
     end
   
   always @(posedge i_clk or negedge i_rstb)
     begin
        if (~i_rstb)
          begin
             r_count <= 'b0;
          end
        else
          begin
             r_count <= r_count_next;
          end
     end

endmodule

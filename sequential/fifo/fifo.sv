`timescale 1ns/100ps
module fifo
  #(
    parameter D_WD = 16,
    parameter SIZE = 16
    )
   (
    input logic             i_clk,
    input logic             i_rstb,
    input logic [D_WD-1:0]  i_data,
    input logic             i_write,
    input logic             i_read,
    output logic [D_WD-1:0] o_data,
    output logic            o_full
    );

   localparam IDX_WD = $clog2(SIZE);
   logic [IDX_WD-1:0]       r_rd_ptr, r_wr_ptr, r_wr_ptr_plus_one;
   logic [D_WD-1:0]         r_mem [SIZE];
   logic                    r_fifo_empty, r_fifo_full;
   integer                  ii;

   always @(*)
     begin
        r_fifo_empty      = (r_rd_ptr == r_wr_ptr);
        r_wr_ptr_plus_one = (r_wr_ptr == SIZE-1) ? 0 : (r_wr_ptr + 1);
        r_fifo_full       = (r_rd_ptr == r_wr_ptr_plus_one);
        o_full            = r_fifo_full;
        o_data            = r_fifo_empty ? 'b0 : r_mem[r_rd_ptr];
     end

   always @(posedge i_clk or negedge i_rstb) begin
      if (~i_rstb) begin
         for (ii = 0; ii < SIZE; ii++)
           r_mem[ii] <= 'b0;
         r_wr_ptr <= 'b0;
         r_rd_ptr <= 'b0;
         o_data   <= 'b0;
      end else begin
         if (i_write & (~r_fifo_full)) begin
            r_mem[r_wr_ptr] <= i_data;
            r_wr_ptr        <= (r_wr_ptr == SIZE-1) ? 0 : (r_wr_ptr + 1);
         end
         if (i_read) begin
            if (~r_fifo_empty) begin
               r_rd_ptr     <= (r_rd_ptr == SIZE-1) ? 0 : (r_rd_ptr + 1);
               o_data       <= r_mem[r_rd_ptr];
            end else begin
               r_rd_ptr     <= r_rd_ptr;
               o_data       <= 'b0;
            end
         end
      end
   end

`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/fifo.vcd");
        $dumpvars(0, fifo);
     end
`endif
   
endmodule

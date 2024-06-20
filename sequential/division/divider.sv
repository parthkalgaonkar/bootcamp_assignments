module divider (
    input   logic                   i_clk,
    input   logic                   i_rstn,
    input   logic   [3:0]           i_dividend,
    input   logic   [3:0]           i_divisor,
    input   logic                   i_start,
    output  logic                   o_done,
    output  logic   [3:0]           o_quotient,
    output  logic   [3:0]           o_remainder
);

    assign  o_done                  = 1'b0;
    assign  o_quotient              = 4'd0;
    assign  o_remainder             = 4'd0;

endmodule

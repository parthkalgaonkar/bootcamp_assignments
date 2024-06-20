module prog_add_sub#(
    parameter DATA_WD=4
)(
    input   logic   [DATA_WD-1:0]   i_a;
    input   logic   [DATA_WD-1:0]   i_b,
    input   logic                   i_mode,
    output  logic                   o_ovr,
    output  logic   [DATA_WD:0]     o_arith_out
);

endmodule

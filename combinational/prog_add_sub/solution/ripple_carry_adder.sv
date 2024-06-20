module ripple_carry_adder#(
    parameter   DATA_WD=4
)(
    input   logic   [DATA_WD-1:0]   i_a,
    input   logic   [DATA_WD-1:0]   i_b,
    input   logic                   i_c,
    output  logic   [DATA_WD:0]     o_arith_out
);

    logic   [DATA_WD:0] int_c;

    assign int_c[0] =   i_c;
    assign o_arith_out[DATA_WD] = int_c[DATA_WD];

    generate 
        for (genvar i_gen=0; i_gen<DATA_WD; i_gen++) begin: FA_STG
            fa inst_fa(
                .i_a(i_a[i_gen]),
                .i_b(i_b[i_gen]),
                .i_c(int_c[i_gen]),
                .o_sum(o_arith_out[i_gen]),
                .o_carry(int_c[i_gen+1])
            );
        end
    endgenerate

endmodule
    
module fa(
    input   logic   i_a,
    input   logic   i_b,
    input   logic   i_c,
    output  logic   o_sum,
    output  logic   o_carry 
);
    logic P,G;
    assign  P = i_a ^ i_b ;
    assign  G = i_a & i_b ;
    assign  o_carry = G | P&i_c;
    assign  o_sum   = P ^ i_c;

endmodule

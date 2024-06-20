`timescale 1ns/100ps
module leading_one_detect#(
    parameter DATA_WD = 8,
    parameter IND_WD  = $clog2(DATA_WD)
)(
    input   logic   [DATA_WD-1:0] i_a,
    output  logic   [IND_WD-1:0]  o_index
);
    logic [DATA_WD-1:0] t1_a;
    logic [IND_WD-1:0] t1_index;

    trailing_one_detect#(
        .DATA_WD(DATA_WD)
    )inst_t1_detect(
        .i_a(t1_a),
        .o_index(t1_index)
    );

    always_comb begin
        for (int i =0; i<DATA_WD; i++) 
            t1_a[i] = i_a[DATA_WD-1-i];
        o_index = ~t1_index;
    end


endmodule

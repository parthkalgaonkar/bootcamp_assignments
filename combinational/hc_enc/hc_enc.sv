module hc_enc#(
    parameter DATA_WD=4,
    parameter CHK_WD=3
)(
    input   logic   [DATA_WD-1:0]   i_data,
    output  logic   [DATA_WD+CHK_WD-1:0] o_enc_data
);

endmodule

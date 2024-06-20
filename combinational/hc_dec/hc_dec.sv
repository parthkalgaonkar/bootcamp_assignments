module hc_dec#(
    parameter DATA_WD = 4,
    parameter CHK_WD  = 3
)(
    input   logic   [DATA_WD+CHK_WD-1:0]  i_enc_data,
    output  logic                         o_err_flag,
    output  logic   [DATA_WD-1:0]         o_dec_data
);

endmodule

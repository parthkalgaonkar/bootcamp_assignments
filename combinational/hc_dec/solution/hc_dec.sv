module hc_dec#(
    parameter DATA_WD = 4,
    parameter CHK_WD  = 3
)(
    input   logic   [DATA_WD+CHK_WD-1:0]  i_enc_data,
    output  logic                         o_err_flag,
    output  logic   [DATA_WD-1:0]         o_dec_data
);
    logic [CHK_WD-1:0]  chk_bits_cmp;
    logic [DATA_WD+CHK_WD-1:0] corr_packet;
    logic [CHK_WD-1:0]  err_pos;
    int k;

    always_comb begin
        chk_bits_cmp = {(CHK_WD){1'b0}};
        for (int i =0; i<CHK_WD; i++) begin
            for (int j=1; j<=DATA_WD+CHK_WD; j++) begin
                if (j[i] == 1) begin
                    chk_bits_cmp[i] = chk_bits_cmp[i] ^ i_enc_data[j-1];
                end
            end
        end
        err_pos = chk_bits_cmp;
        corr_packet = o_err_flag ? (i_enc_data ^ (1 << err_pos)) : i_enc_data;
        k=0;
        o_dec_data = {(DATA_WD){1'b0}};
        for (int i=1;i<=DATA_WD+CHK_WD;i++) begin
            if ((i & (i-1)) != 0) begin
                o_dec_data[k] = corr_packet[i-1];
                k++;
            end
        end
    end

    assign o_err_flag = ~(err_pos == {(CHK_WD-1){1'b0}});

endmodule

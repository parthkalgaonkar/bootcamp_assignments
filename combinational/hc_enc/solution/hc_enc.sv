module hc_enc#(
    parameter DATA_WD=4,
    parameter CHK_WD=3
)(
    input   logic   [DATA_WD-1:0]   i_data,
    output  logic   [DATA_WD+CHK_WD-1:0] o_enc_data
);
    logic   [CHK_WD-1:0]    chk_bits;
    logic   [DATA_WD+CHK_WD-1:0]    map_data;
    int j,k;

    always_comb begin
        o_enc_data  =   {(DATA_WD+CHK_WD){1'b0}};
        map_data  =   {(DATA_WD+CHK_WD){1'b0}};
        chk_bits    =   {(CHK_WD){1'b0}};
        j           =   0;
        for (int i =1; i<=DATA_WD+CHK_WD; i++) begin
            if ((i & (i-1)) != 0) begin
                map_data[i-1] =  i_data[j];
                j++;
            end
        end
        for (int i =0; i<CHK_WD; i++) begin
            for (int j=1; j<=DATA_WD+CHK_WD; j++) begin
                if (j[i] == 1) begin
                    chk_bits[i] = chk_bits[i] ^ map_data[j-1];
                end
            end
        end
        j           =   0;
        k           =   0;
        for (int i =1; i<=DATA_WD+CHK_WD; i++) begin
            if ((i & (i-1)) != 0) begin
                o_enc_data[i-1] =  i_data[j];
                j++;
            end else begin
                o_enc_data[i-1] =  chk_bits[k];
                k++;
            end
        end
    end

endmodule

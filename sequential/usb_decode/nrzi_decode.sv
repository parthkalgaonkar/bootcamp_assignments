module nrzi_decode (
    input   logic           i_clk,
    input   logic           i_rstn,

    input   logic           i_nrzi,
    input   logic           i_valid,

    output  logic           o_data,
    output  logic           o_valid,
    output  logic           o_error
);

    // Add your logic here.
    assign  o_data          = 1'b0;
    assign  o_valid         = 1'b1;
    assign  o_error         = 1'b0;

endmodule

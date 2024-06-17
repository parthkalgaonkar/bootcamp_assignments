module nrzi_decode (
    input   logic           i_clk,
    input   logic           i_rstn,

    input   logic           i_nrzi,
    input   logic           i_valid,

    output  logic           o_data,
    output  logic           o_valid,
    output  logic           o_error
);

    logic                   r_prev;
    logic                   r_data;     // Without bit-stuffing removed
    logic                   r_valid;
    logic   [2:0]           r_count;

    always @(posedge i_clk or negedge i_rstn) begin
        if (~i_rstn) begin
            r_prev          <= 1'b1;
            r_data          <= 1'b1;
            r_valid         <= 1'b0;
        end else if (i_valid) begin
            r_prev          <= i_nrzi;
            r_data          <= (i_nrzi == r_prev)? 1'b1 : 1'b0;
            r_valid         <= 1'b1;
        end else begin
            r_prev          <= 1'b1;
            r_data          <= 1'b1;
            r_valid         <= 1'b0;
        end
    end

    always @(posedge i_clk or negedge i_rstn) begin
        if (~i_rstn) begin
            r_count         <= 3'd0;
            o_data          <= 1'b1;
            o_valid         <= 1'b0;
            o_error         <= 1'b0;
        end else if (r_valid) begin
            r_count         <= (r_data == 1'b1)? (r_count + 1) : 3'd0;
            o_data          <= r_data;
            o_valid         <= (r_count == 3'd6)? 1'b0 : 1'b1;
            o_error         <= (r_count > 3'd6)? 1'b1 : 1'b0;
        end else begin
            r_count         <= 3'd0;
            o_data          <= 1'b1;
            o_valid         <= 1'b0;
            o_error         <= 1'b0;
        end
    end

endmodule

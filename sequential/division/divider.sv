module divider #(
    parameter   int     D_WIDTH     = 4
)(
    input   logic                   i_clk,
    input   logic                   i_rstn,
    input   logic   [D_WIDTH-1:0]   i_dividend,
    input   logic   [D_WIDTH-1:0]   i_divisor,
    input   logic                   i_start,
    output  logic                   o_done,
    output  logic   [D_WIDTH-1:0]   o_quotient,
    output  logic   [D_WIDTH-1:0]   o_remainder
);

    localparam  int CountWidth      = $clog2(D_WIDTH) + 1;
    logic   [D_WIDTH-1:0]           r_acc, w_acc_next;
    logic   [D_WIDTH-1:0]           r_div, w_div_next;
    logic   [D_WIDTH-1:0]           w_quo_next;
    logic                           w_add_quo;
    logic   [CountWidth:0]          r_count;

    always_comb begin
        w_add_quo                   = 1'b0;
        {w_acc_next, w_div_next}    = {r_acc[D_WIDTH-1:0], r_div, 1'b0};
        if (w_acc_next >= i_divisor) begin
            w_acc_next              = w_acc_next - i_divisor;
            w_add_quo               = 1'b1;
        end
        w_quo_next                  = (o_quotient << 1) | w_add_quo;
        o_remainder                 = r_acc;
    end

    always @(posedge i_clk or negedge i_rstn) begin
        if (~i_rstn) begin
            o_quotient              <= {D_WIDTH{1'b0}};
            r_count                 <= {CountWidth{1'b0}};
            r_acc                   <= {D_WIDTH{1'b0}};
            r_div                   <= {D_WIDTH{1'b0}};
            o_done                  <= 1'b0;
        end else if (i_start) begin
            r_count                 <= D_WIDTH - 1;
            o_quotient              <= {D_WIDTH{1'b0}};
            r_acc                   <= {D_WIDTH{1'b0}};
            r_div                   <= i_dividend;
            o_done                  <= 1'b0;
        end else begin
            r_count                 <= (r_count == 0)? r_count : (r_count - 1);
            o_quotient              <= w_quo_next;
            r_acc                   <= w_acc_next;
            r_div                   <= w_div_next;
            o_done                  <= (r_count == 0)? 1'b1 : 1'b0;
        end
    end

`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/divider.vcd");
        $dumpvars(0, divider);
     end
`endif

endmodule

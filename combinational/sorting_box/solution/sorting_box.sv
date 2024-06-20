module sorting_box#(
    parameter DATA_WD = 8,
    parameter SIGNED=0
)(
    input   logic   [DATA_WD-1:0]   i_a[4],
    output  logic   [DATA_WD-1:0]   o_sorted_a[4]
);
    logic   [DATA_WD-1:0]   int_max[2+1][2];
    logic   [DATA_WD-1:0]   int_min[2+1][2];

    generate 
        for(genvar i_gen=0; i_gen<4/2; i_gen++) begin : STAGE_0
            max_min#(.DATA_WD(DATA_WD),.SIGNED(SIGNED))inst_max_min_s0(
                .i_a(i_a[2*i_gen]),
                .i_b(i_a[2*i_gen+1]),
                .o_max(int_max[0][i_gen]),
                .o_min(int_min[0][i_gen])
            );
        end

        for(genvar i_gen=0; i_gen<4/4; i_gen++) begin : STAGE_1
            max_min #(.DATA_WD(DATA_WD),.SIGNED(SIGNED))inst_mx_max_min_s1(
                .i_a(int_max[0][2*i_gen]),
                .i_b(int_max[0][2*i_gen+1]),
                .o_max(int_max[1][2*i_gen]),
                .o_min(int_min[1][2*i_gen])
            );
            max_min #(.DATA_WD(DATA_WD),.SIGNED(SIGNED))inst_mn_max_min_s1(
                .i_a(int_min[0][2*i_gen]),
                .i_b(int_min[0][2*i_gen+1]),
                .o_max(int_max[1][2*i_gen+1]),
                .o_min(int_min[1][2*i_gen+1])
            );
        end
        for(genvar i_gen=0; i_gen<4/4; i_gen++) begin : STAGE_2
            max_min #(.DATA_WD(DATA_WD),.SIGNED(SIGNED))inst_int_max_min_s2(
                .i_a(int_min[1][2*i_gen]),
                .i_b(int_max[1][2*i_gen+1]),
                .o_max(int_max[2][2*i_gen]),
                .o_min(int_min[2][2*i_gen])
            );
        end

    endgenerate

    always_comb begin
        o_sorted_a[0] = int_min[1][1];
        o_sorted_a[1] = int_min[2][0];
        o_sorted_a[2] = int_max[2][0];
        o_sorted_a[3] = int_max[1][0];
    end

endmodule

module max_min#(
    parameter DATA_WD=8,
    parameter SIGNED=1
)(
    input   logic [DATA_WD-1:0]   i_a,
    input   logic [DATA_WD-1:0]   i_b,
    output  logic [DATA_WD-1:0]   o_max,
    output  logic [DATA_WD-1:0]   o_min
);
    logic signed [DATA_WD-1:0]  a,b;
    always_comb begin
        if (SIGNED == 1) begin
            a = $signed(i_a);
            b = $signed(i_b);
            if (a < b) begin
                o_max = i_b;
                o_min = i_a;
            end else begin 
                o_max = i_a;
                o_min = i_b;
            end
        end else begin
            if (i_a < i_b) begin
                o_max = i_b;
                o_min = i_a;
            end else begin 
                o_max = i_a;
                o_min = i_b;
            end
        end
    end
endmodule

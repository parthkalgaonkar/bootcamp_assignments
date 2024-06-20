`timescale 1ns/100ps
module trailing_one_detect
#(
    parameter DATA_WD = 8,
    parameter IND_WD  = $clog2(DATA_WD)
)
(
    input logic [DATA_WD-1:0] i_a,
    output logic [IND_WD-1:0]  o_index
);

endmodule

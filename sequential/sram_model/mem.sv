module mem (
    input   logic           clock,
    input   logic   [9:0]   in_mem_addr,
    input   logic           in_mem_re_web,
    input   logic   [31:0]  in_mem_write_data,
    input   logic   [3:0]   in_mem_byte_en,
    output  logic   [31:0]  out_mem_data
);

    logic   [31:0]          memory_reg [1024];
    logic   [7:0]           write_bytes [4];
    logic   [31:0]          write_data_muxed;

    always_comb begin
        for (int i=0; i<4; i++) begin
            write_bytes[i]  = in_mem_byte_en[i] ? in_mem_write_data[8*i+:8] : memory_reg[in_mem_addr][8*i+:8];
        end
        write_data_muxed    = {
                                write_bytes[3],
                                write_bytes[2],
                                write_bytes[1],
                                write_bytes[0]
                            };
    end

    always @ (posedge clock) begin
        if (!in_mem_re_web)
            memory_reg[in_mem_addr] <= write_data_muxed;
    end

    always @ (posedge clock) begin
        if (in_mem_re_web)
            out_mem_data <= memory_reg[in_mem_addr];
    end

`ifndef DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/mem.vcd");
        $dumpvars(0, mem);
     end
`endif

endmodule

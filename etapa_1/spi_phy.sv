module spi_phy (
    input        rst_ni    ,
    input        clk_i     ,  // max 5MHz for ADXL345 sensor
    input        spi_clk_i ,  // same frequency as clk_i, 220 deg phase offset

    // Parallel request-acknowledge interface (sampled with clk_i)
    input        req_i     ,
    input        rw_ni     ,  // 1=read, 0=write
    input  [5:0] addr_i    ,
    input  [7:0] wr_data_i ,
    output logic ack_o     ,
    output [7:0] rd_data_o ,

    // SPI interface
    output       spi_cs_no ,
    output       spi_clk_o ,
    output       spi_data_o,
    input        spi_data_i,
    output       spi_oe_o     // control 3-state buffer for 3-wire SPI mode 
    // spi oe output enable
);

localparam SHREG_WIDTH = 16;

logic [SHREG_WIDTH-1 : 0] shift_reg;
logic [SHREG_WIDTH-1 : 0] shift_cnt;

always @ (posedge clk_i or negedge rst_ni) begin
    if (!rst_ni)
        shift_cnt <= 'b0;
    else if (req_i && spi_cs_no)
        shift_cnt <= {SHREG_WIDTH{1'b1}};
    else
        shift_cnt <= shift_cnt >> 1;
end

assign spi_cs_no = !shift_cnt[0];
assign spi_clk_o = spi_cs_no ? 1'b1 : spi_clk_i;
assign spi_oe_o  = shift_cnt[8];

always @ (posedge clk_i or negedge rst_ni) begin
    if (!rst_ni)
        shift_reg <= 'b0;
    else if (!spi_cs_no)
        shift_reg <= (shift_reg << 1) | spi_data_i;
    else if (req_i)
        shift_reg <= {rw_ni, 1'b0, addr_i, wr_data_i};
end

assign spi_data_o = shift_reg[SHREG_WIDTH-1];

assign rd_data_o = shift_reg[7:0];

always @ (posedge clk_i or negedge rst_ni) begin
    if (!rst_ni)
        ack_o <= 1'b0;
    else
        ack_o <= shift_cnt[1:0] == 2'b01;
end

endmodule

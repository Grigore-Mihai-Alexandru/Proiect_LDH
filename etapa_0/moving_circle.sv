module moving_circle #(
    CLK_FREQ = 50_000_000, //50 Mhz  50000000
    STEPS_PER_SEC = 1,
    NO_DISPLAYS = 6
)(
    input clk_i,
    input rst_ni,
    input [2:0] speed_i,

    output logic row_o,
    output logic [3-1:0] col_o

);

// clog2(x) = y returns the smallest integer y such that 2^y >= x
// ex: clog2(8) = 3, clog2(9) = 4

localparam int CLK_PERIODS_PER_STEP = CLK_FREQ / STEPS_PER_SEC;
localparam CLK_DIV_WIDTH = $clog2(CLK_PERIODS_PER_STEP);

localparam DISPLAYS_COUNT_WIDTH = $clog2(NO_DISPLAYS);

logic step;
logic [CLK_DIV_WIDTH-1:0] clk_periods_per_step;

logic [DISPLAYS_COUNT_WIDTH-1:0] display_count;
logic display_count_direction, display_count_overflow, display_count_underflow;

logic skip_step, count_en;


always @ (posedge clk_i or negedge rst_ni)
    if(~rst_ni)
        clk_periods_per_step <= CLK_PERIODS_PER_STEP;
    else
        clk_periods_per_step <= CLK_PERIODS_PER_STEP >> speed_i; 
		  // de precizat clk_periods_per_step = CLK_PERIODS_PER_STEP/ 2^speed_i
        // 101  >> 010 = 001
        // 50 shiftat cu 3 pozitii
        // 50 = baza2 => 110010 >> 011 = 000110

counter #(
    .WIDTH(CLK_DIV_WIDTH)
) clock_period_counter (
    .clk_i          (clk_i),
    .rst_ni         (rst_ni),
    .direction_i    (1'b1),
    .en_i           (1'b1),
    .low_limit_i    (1),
    .high_limit_i   (clk_periods_per_step),
    .count_o        (),
    .overflow_o     (step),
    .underflow_o    ()
);

counter #(
    .WIDTH(DISPLAYS_COUNT_WIDTH)
) display_counter (
    .clk_i          (clk_i),
    .rst_ni         (rst_ni),
    .direction_i    (display_count_direction), // row
    .en_i           (count_en),
    .low_limit_i    (0),
    .high_limit_i   (NO_DISPLAYS-1),
    .count_o        (display_count),  //col
    .overflow_o     (display_count_overflow),
    .underflow_o    (display_count_underflow)
);

assign count_en = step && !skip_step;
assign row_o = display_count_direction;
assign col_o = display_count;


//schimbam directia/randul la ovf sau underflow
always @ (posedge clk_i or negedge rst_ni)
    if(~rst_ni)
        display_count_direction <= 1'b1;
    else if(step && (display_count_overflow || display_count_underflow))
        display_count_direction <= ~display_count_direction;


// folosim skip step pentru a astepta sa se schimbe directia 
// altfel se va schimba directia de 2 ori la fiecare overflow/underflow
// si va ramane blocat (se interschimba intre limitele sale) 0 sau 5

always @ (posedge clk_i or negedge rst_ni)
    if(~rst_ni)
        skip_step <= 1'b0;
    else if(display_count_overflow || display_count_underflow)
        skip_step <= 1'b1;
    else
        skip_step <= 1'b0;

endmodule
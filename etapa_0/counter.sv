module counter #(
    WIDTH = 3
)(
    input clk_i,
    input rst_ni,
    input direction_i,
    input en_i,
    input [WIDTH-1:0] low_limit_i,
    input [WIDTH-1:0] high_limit_i,
    output reg [WIDTH-1:0] count_o,
    output reg overflow_o,
    output reg underflow_o
);

always @ (posedge clk_i or negedge rst_ni) begin
    if(~rst_ni)
        count_o <= {WIDTH{1'b0}};
    else if(en_i) begin
        if(overflow_o)
            count_o <= low_limit_i;
        else if(underflow_o)
            count_o <= high_limit_i;
        else
            count_o <= (direction_i) ? count_o + 1'd1 : count_o - 1'd1;
    end
end

assign overflow_o = direction_i && (count_o >= high_limit_i);
assign underflow_o = !direction_i && (count_o <= low_limit_i);

endmodule

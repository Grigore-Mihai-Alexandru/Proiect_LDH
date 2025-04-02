module driver_7seg_displays(
    input [2:0] col_i,
    input       row_i,
    output reg [7:0] Hex0_o, Hex1_o, Hex2_o, Hex3_o, Hex4_o, Hex5_o
);
//                          76543210
localparam up_circle =   8'b10011100;
localparam down_circle = 8'b10100011;
localparam empty =       8'b11111111;

reg [7:0] selected_symbol;

always_comb begin
    Hex0_o = empty;
    Hex1_o = empty;
    Hex2_o = empty;
    Hex3_o = empty;
    Hex4_o = empty;
    Hex5_o = empty;

    selected_symbol = (row_i) ? up_circle : down_circle;

    case (col_i)
        3'b000: Hex0_o = selected_symbol;
        3'b001: Hex1_o = selected_symbol;
        3'b010: Hex2_o = selected_symbol;
        3'b011: Hex3_o = selected_symbol;
        3'b100: Hex4_o = selected_symbol;
        3'b101: Hex5_o = selected_symbol;
        default: begin
            Hex0_o = empty;
            Hex1_o = empty;
            Hex2_o = empty;
            Hex3_o = empty;
            Hex4_o = empty;
            Hex5_o = empty;
        end
    endcase
end


endmodule
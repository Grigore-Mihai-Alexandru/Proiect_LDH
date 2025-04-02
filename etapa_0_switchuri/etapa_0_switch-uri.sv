module etapa_0_switch(
// input-uri de tipul sw2, sw1, sw0 (3 biti) 
    input sw0_i,
    input sw1_i,
    input sw2_i,
    input sw3_i, // switch ce determina pozitia verticala
    output reg [7:0] Hex0_o,
    output reg [7:0] Hex1_o,
    output reg [7:0] Hex2_o,
    output reg [7:0] Hex3_o,
    output reg [7:0] Hex4_o,
    output reg [7:0] Hex5_o
);


localparam up_circle = 8'b01100011;
localparam down_circle = 8'b01011100;
localparam empty = 8'b00000000;

reg [7:0] selected_symbol;

always_comb begin
    Hex0_o = empty;
    Hex1_o = empty;
    Hex2_o = empty;
    Hex3_o = empty;
    Hex4_o = empty;
    Hex5_o = empty;
    
    selected_symbol = (sw3_i) ? up_circle : down_circle;

    case ({sw2_i, sw1_i, sw0_i})
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
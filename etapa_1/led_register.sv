module led_register(
    input   logic           clk_i,
    input   logic           rst_ni,
    input   logic  [7:0]    data_i,  
    input   logic           ack_i,   
    output  logic  [7:0]    led_o  
);


//registru intern pentru a retine datele de la SPI
logic [7:0] reg_data;

always @( posedge clk_i or negedge rst_ni ) begin
    if(~rst_ni) begin
        reg_data <= 8'b0;
    end else if(ack_i) begin
        reg_data <= data_i;
    end
end

assign led_o = reg_data; // iesirea registrului este conectata la LED-uri



endmodule
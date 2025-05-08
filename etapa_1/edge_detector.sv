module edge_detector(
    input wire clk_i,         // ceasul sistemului
    input wire rst_ni,        // reset
    input wire button_ni,     // semnalul de la buton
    output reg pressed_o      // iese 1 DOAR 1 ciclu la apasare
);

    reg button_prev;

    always @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            button_prev <= 1'b1;
        end else begin
            button_prev <= button_ni;
        end   
    end

    always @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            pressed_o <= 1'b0;
        end else begin
            // detectam front de coborare: 1 -> 0
            if (button_prev == 1'b1 && button_ni == 1'b0)
                pressed_o <= 1'b1;
            else
                pressed_o <= 1'b0;
        end
    end
    

endmodule

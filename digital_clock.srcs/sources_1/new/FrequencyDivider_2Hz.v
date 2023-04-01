`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luo Chang
// 
// Create Date: 2023/03/17 18:38:55
// Design Name: 
// Module Name: FrequencyDivider_2Hz
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module FrequencyDivider_2hz(
    input CLK_1k,
    input CR,
    input EN,
    output reg CLK_2Hz = 0
);
    reg [7:0] state;
    always @(posedge CLK_1k)
        begin
            if (~CR)
                begin
                    CLK_2Hz <= 0;
                    state <= 0;
                end
            else if (~EN)
                begin 
                    CLK_2Hz <= CLK_2Hz;
                    state <= 0;
                end
        else if (state < 249) state <= state + 1'b1;
        else
            begin
                state <= 0;
                CLK_2Hz <= ~CLK_2Hz;
            end
    end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luo Chang
// 
// Create Date: 2023/03/17 18:38:55
// Design Name: 
// Module Name: FrequencyDivider_1Hz
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


module FrequencyDivider_1hz(
    input CLK_1k,
    input CR,
    input EN,
    output reg CLK_1Hz = 0
    );
    reg [8:0] state;
    always @(posedge CLK_1k or negedge CR)
        begin
            if (~CR)
                begin
                    CLK_1Hz <= 0;
                    state <= 0;
                end
            else if (~EN)
                begin
                    CLK_1Hz <= CLK_1Hz;
                    state <= state;
                end
//              for real use, here should be 499,but for test, we can change it into 49 or 4
            else if (state < 499) state <= state + 1'b1;
//              else if (state < 49) state <= state + 1'b1;
//              else if (state < 4) state <= state +1'b1;
            else 
                begin
                    state <= 0;
                    CLK_1Hz <= ~CLK_1Hz;
                end
        end
endmodule

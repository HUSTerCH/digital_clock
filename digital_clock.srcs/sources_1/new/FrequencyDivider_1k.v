`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 18:38:55
// Design Name: 
// Module Name: FrequencyDivider_1k
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


module FrequencyDivider_1k(
    input CP,
    output reg CLK_1k = 0
    );
    reg [15:0] state;
    always @(posedge CP)
        begin
//        for real use
            if (state < 49999) state <= state + 1'b1;
// //         for sim
//          if (state < 4) state <= state +1'b1;
            else 
                begin
                    state <= 0;
                    CLK_1k <= ~CLK_1k;
                end
        end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luo Chang
// 
// Create Date: 2023/03/17 18:38:55
// Design Name: 
// Module Name: Counter_10
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


module Counter_10(
    input CP,
    input CR,
    input EN,
    output reg [3:0] Q = 4'b0000,
    output reg carryBit
    );
    always @(posedge CP or negedge CR)
        begin
            if (~CR) Q <= 4'b0000;
            else if(~EN) Q <= Q;
            else if (Q == 4'b1001)
                begin
                    Q <= 4'b0000;
                    carryBit = 1'b1;
                end
            else
                begin
                    Q <= Q + 1'b1;
                    carryBit = 1'b0;
                end
        end
endmodule

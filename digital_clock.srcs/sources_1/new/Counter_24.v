`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 18:38:55
// Design Name: 
// Module Name: Counter_24
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


module Counter_24(
    CP,
    CR,
    EN,
    Q_ones,
    Q_tens
    );
    input CP;
    input CR;
    input EN;
    output reg [3:0] Q_ones = 4'b0000;
    output reg [3:0] Q_tens = 4'b0000;
    
    always @(posedge CP or negedge CR)
        begin
            if (~CR)
                begin
                    Q_ones <= 4'b0000;
                    Q_tens <= 4'b0000;
                end
            else if(~EN)
                begin
                    Q_ones <= Q_ones;
                    Q_tens <= Q_tens;
                end
            else if (Q_ones == 4'b1001 && Q_tens < 4'b0010)
                begin
                    Q_ones <= 4'b0000;
                    Q_tens <= Q_tens +1'b1;
                end
            else if (Q_ones == 4'b0011 && Q_tens == 4'b0010)
                begin
                    Q_tens <= 4'b0000;
                    Q_ones <= 4'b0000;
                end
            else
                begin
                    Q_ones <= Q_ones + 1'b1;
                end
        end
endmodule

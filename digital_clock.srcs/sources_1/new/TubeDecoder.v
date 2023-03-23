`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luo Chang
// 
// Create Date: 2023/03/17 20:29:11
// Design Name: 
// Module Name: TubeDecoder
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


module TubeDecoder(
    input [3:0] number,
    output reg [6:0] code
    );
    always @(number)
        begin
            case(number)
                4'd0: code <= 7'b100_0000;
                4'd1: code <= 7'b111_1001;
                4'd2: code <= 7'b010_0100;
                4'd3: code <= 7'b011_0000;
                4'd4: code <= 7'b001_1001;
                4'd5: code <= 7'b001_0010;
                4'd6: code <= 7'b000_0010;
                4'd7: code <= 7'b111_1000;
                4'd8: code <= 7'b000_0000;
                4'd9: code <= 7'b001_0000;
                
                4'ha: code <= 7'b000_1000;//show A
                4'hb: code <= 7'b000_1100;//show P
                default: code <= 7'b111_1111;
             endcase
        end
endmodule

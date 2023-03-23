`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 14:43:27
// Design Name: 
// Module Name: TwoToOneSelector
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


module TwoToOneSelector(
    input inputA,
    input inputB,
    input selectSignal,
    output reg outputSignal
    );
    always @(*)
        begin
            if(selectSignal == 1'b0)
                outputSignal <= inputA;
            else
                outputSignal <= inputB;
        end
endmodule

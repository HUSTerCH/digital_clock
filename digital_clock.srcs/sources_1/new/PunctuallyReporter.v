`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 08:27:25
// Design Name: 
// Module Name: PunctuallyReporter
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


module PunctuallyReporter(
    input [7:0] minute,
    input [4:0] hour,
    input EN,
    input CLK_1Hz,
    output reg reportSignal
    );
    reg [3:0] flashingTime = 0;
    always @(posedge CLK_1Hz)
        begin
            if (EN == 0) reportSignal = 1'b0;
            else if (minute[7:0] == 0 && flashingTime < (hour[4:0]+1'b1))
                begin
                    reportSignal <= ~reportSignal;
                    flashingTime <= flashingTime + 1'b1;
                end
        end      
endmodule

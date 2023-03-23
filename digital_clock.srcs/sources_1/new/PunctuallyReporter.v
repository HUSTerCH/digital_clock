`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luo Chang
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
    output reg reportSignal = 0
    );
    reg [5:0] flashingTime = 0;
    reg hasReport = 0;
    always @(posedge CLK_1Hz)
        begin
            if (EN == 0) reportSignal = 1'b0;
            else if (minute[7:0] == 0 && flashingTime < 2 * (hour[4:0]) && hasReport == 1'b0)
                begin
                    reportSignal <= ~reportSignal;
                    flashingTime <= flashingTime + 1'b1;
                end
            else
                begin
                    reportSignal <= 1'b0;
                    flashingTime <= 1'b0;
                    hasReport <= 1'b1;
                end
            if (minute[7:0] > 0)
                hasReport <= 1'b0;
        end      
endmodule

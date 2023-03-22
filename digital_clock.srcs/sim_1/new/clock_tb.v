`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 10:15:23
// Design Name: 
// Module Name: clock_tb
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


module clock_tb;
    reg clock_en,CP,adjust_minute_en,adjust_hour_en,punctually_report_en,show_mode,CR;
    wire [7:0]tubePosSignal;
    wire [6:0]tubeShowSignal;
    wire punctuallyReportSignal;
    Clock clock(clock_en,CP,adjust_minute_en,adjust_hour_en,punctually_report_en,show_mode,CR,
    tubePosSignal,tubeShowSignal,punctuallyReportSignal);
    always #1 CP = ~CP;
    initial
        begin
            clock_en = 1'b1;
            CP = 1'b1;
            adjust_minute_en = 1'b1;
            adjust_hour_en = 1'b1;
            punctually_report_en = 1'b1;
            show_mode = 1'b0;
            CR = 1'b1;
            #400000
            $stop;
         end
         
endmodule

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
    reg clock_en;
    reg CR;
    reg CP;
    reg adjust_hour_en;
    reg adjust_minute_en;
    reg second_stop;
    reg show_mode;
    reg punctually_report_en;
    reg alarm_switch;
    reg set_alarm_time;
    wire [7:0]tubePosSignal;
    wire [6:0]tubeShowSignal;
    wire punctuallyReportSignal;
    wire alarmReportSignal;
Clock clock(
     clock_en,
     CR,
     CP,
     adjust_hour_en,
     adjust_minute_en,
     second_stop,
     show_mode,
     punctually_report_en,
     alarm_switch,
     set_alarm_time,
     tubePosSignal,
     tubeShowSignal,
     punctuallyReportSignal,
     alarmReportSignal
    );
    always #1 CP = ~CP;
    initial
        begin
            clock_en = 1'b1;
            CP = 1'b1;
            CR = 1'b1;
            adjust_hour_en = 1'b1;
            adjust_minute_en = 1'b1;
            show_mode = 1'b0;
            punctually_report_en = 1'b1;
            #400000
            $stop;
         end
         
endmodule

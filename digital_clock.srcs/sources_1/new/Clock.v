`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 18:40:51
// Design Name: 
// Module Name: Clock
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


module Clock(
    input clock_en,
    input CP,
    input adjust_minute_en,
    input adjust_hour_en,
    input punctually_report_en,
    input show_mode,
    input CR,
    output [7:0] tubePosSignal,
    output [6:0] tubeShowSignal,
    output punctuallyReportSignal
    );
    wire [7:0] second;
    wire [7:0] minute;
    wire [7:0] hour;
    wire [6:0] secondOnesShowCode,secondTensShowCode,minuteOnesShowCode,minuteTensShowCode,hourOnesShowCode,hourTensShowCode;
//    wire [7:0] tubePosCode;
//    wire [6:0] tubeShowCode;
    wire secondInnerCarryBit,minuteInnerCarryBit,secondToMinuteCarryBit,minuteToHourCarryBit;
    wire CLK_1k,CLK_1Hz;
//    wire punctuallyReport;
    wire [4:0] hour_real_num;
    assign hour_real_num = hour[3:0] +hour[7:4];
    
    FrequencyDivider_1k divider_1k(CP,CLK_1k);
    FrequencyDivider_1hz divider_1Hz(CLK_1k,CR,clock_en,CLK_1Hz);
    
    Counter_60 secondCounter(CLK_1Hz,1'b1,(~adjust_minute_en || CR),second,secondToMinuteCarryBit);
    Counter_60 minuteCounter(secondToMinuteCarryBit,adjust_minute_en,CR,minute,minuteToHourCarryBit);
    Counter_24 hourCounter(minuteToHourCarryBit,CR,adjust_hour_en,hour[3:0],hour[7:4]);
    
    PunctuallyReporter PunctuallyReporter(minute,hour_real_num,punctually_report_en,CLK_1Hz,punctuallyReportSignal);
    
    TubeDecoder secondOnesDecoder(second[3:0],secondOnesShowCode);
    TubeDecoder secondTensDecoder(second[7:4],secondTensShowCode);
    
    TubeDecoder minuteOnesDecoder(minute[3:0],minuteOnesShowCode);
    TubeDecoder minuteTensDecoder(minute[7:4],minuteTensShowCode);
    
    TubeDecoder HourOnesDecoder(hour[3:0],hourOnesShowCode);
    TubeDecoder hourTensDecoder(hour[7:4],hourTensShowCode);
    
    TubeShower shower(
        CLK_1k,show_mode,
        hour,
        secondOnesShowCode,
        secondTensShowCode,
        minuteOnesShowCode,
        minuteTensShowCode,
        hourOnesShowCode,
        hourTensShowCode,
        tubePosSignal,
        tubeShowSignal);
        
endmodule

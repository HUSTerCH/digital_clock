`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luo Chang
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
    input CR,
    input CP,
    input adjust_hour_en,
    input adjust_minute_en,
    input second_continue,
    input show_mode,
    input punctually_report_en,
    input alarm_switch,
    input set_alarm_time,
    output [7:0] tubePosSignal,
    output [6:0] tubeShowSignal,
    output punctuallyReportSignal,
    output alarmReportSignal
    );
    wire CLK_1k,CLK_1Hz;
    wire secondInputSignal,minuteInputSignal,hourInputSignal;
// below 3 wire net,lower 3 bits is for ones bit,and upper 3bits is for tens bit
    wire [7:0] second;
    wire [7:0] minute;
    wire [7:0] hour;
    wire [6:0] secondOnesShowCode,secondTensShowCode,minuteOnesShowCode,minuteTensShowCode,hourOnesShowCode,hourTensShowCode;
    
    wire secondToMinuteCarryBit,minuteToHourCarryBit;
    
    wire [4:0] hour_real_num;
    assign hour_real_num = hour[3:0] + 10 * hour[7:4];
    
    FrequencyDivider_1k divider_1k(
        CP, 
        CLK_1k
        );
    FrequencyDivider_1hz divider_1Hz(
        CLK_1k, 
        CR,
        clock_en, 
        CLK_1Hz
        );
    
    TwoToOneSelector minuteInput(
        secondToMinuteCarryBit, 
        CLK_1Hz,
        ~adjust_minute_en, 
        minuteInputSignal
        );
        
    TwoToOneSelector hourInput(
        minuteToHourCarryBit, 
        CLK_1Hz, 
        ~adjust_hour_en, 
        hourInputSignal
    );
    
    TwoToOneSelector secondInput(
        CLK_1Hz,
        1'b0, 
        ~adjust_hour_en && ~adjust_minute_en,
        secondInputSignal
    );
    
// Counter_60(input CP, input EN, input CR, output reg [7:0] Q, output reg carryBit)
    Counter_60 secondCounter (
        secondInputSignal,
        second_continue,
        CR,
        second,
        secondToMinuteCarryBit
        );
    Counter_60 minuteCounter (
        minuteInputSignal,
        clock_en,
        CR,
        minute,
        minuteToHourCarryBit
        );
    Counter_24 hourCounter(
        hourInputSignal,
        CR,
        clock_en,
        hour[3:0],
        hour[7:4]
        );
    
    PunctuallyReporter PunctuallyReporter (
        minute,
        hour_real_num,
        punctually_report_en,
        CLK_1Hz,
        punctuallyReportSignal
        );
    
    TubeDecoder secondOnesDecoder(second[3:0],secondOnesShowCode);
    TubeDecoder secondTensDecoder(second[7:4],secondTensShowCode);
    
    TubeDecoder minuteOnesDecoder(minute[3:0],minuteOnesShowCode);
    TubeDecoder minuteTensDecoder(minute[7:4],minuteTensShowCode);
    
    TubeDecoder HourOnesDecoder(hour[3:0],hourOnesShowCode);
    TubeDecoder hourTensDecoder(hour[7:4],hourTensShowCode);
    
    TubeShower shower(
        CLK_1k,
        show_mode,
        hour_real_num,
        hour,
        secondOnesShowCode,
        secondTensShowCode,
        minuteOnesShowCode,
        minuteTensShowCode,
        hourOnesShowCode,
        hourTensShowCode,
        tubePosSignal,
        tubeShowSignal
        );
        
endmodule

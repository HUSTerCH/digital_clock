`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 18:43:25
// Design Name: 
// Module Name: AlarmReporter
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


module AlarmReporter(
    input EN,
    input [7:0] hour_set_num,
    input [7:0] minute_set_num,
    input [7:0] hour_current_num,
    input [7:0] minute_current,
    input CLK_1Hz,
    output reg reportSignal = 0
    );
    always @(posedge CLK_1Hz)
        begin
            if (EN == 0)
                reportSignal <= 1'b0;
            else if (hour_current_num == hour_set_num && minute_current == minute_set_num)
                reportSignal <= ~reportSignal;
            else
                reportSignal <= 1'b0;
        end
endmodule

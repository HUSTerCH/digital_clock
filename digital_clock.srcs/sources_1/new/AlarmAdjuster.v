`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 18:52:24
// Design Name: 
// Module Name: AlarmAdjuster
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


module AlarmSetter(
    input set_hour_en,
    input set_minute_en,
    input CLK_1Hz,
    output reg [7:0] hour_set = 8'b0000_0000,
    output reg [7:0] minute_set = 8'b0000_0000
    );
    reg onesToTensCarryBit;
    always @(posedge CLK_1Hz) begin
        if (~set_minute_en) minute_set[3:0] <= minute_set[3:0];
        else if (minute_set[3:0] == 4'b1001)
            begin
                minute_set[3:0] <= 4'b0000;
                onesToTensCarryBit = 1'b1;
            end
        else
            begin
                minute_set[3:0] <= minute_set[3:0] + 1'b1;
                onesToTensCarryBit = 1'b0;
            end
    end

    always @(posedge onesToTensCarryBit) begin
        if (~set_minute_en) minute_set[7:4] <= minute_set[7:4];
        else if (minute_set[7:4] == 4'b0101)
            minute_set[7:4] <= 4'b0000;
        else
            minute_set[7:4] <= minute_set[7:4] + 1'b1;
    end

    always @(posedge CLK_1Hz) begin
        if (~set_hour_en) hour_set <= hour_set;
        else if (hour_set[3:0] == 4'b1001 && hour_set[7:4] < 4'b0010)
            begin
                hour_set[3:0] <= 4'b0000;
                hour_set[7:4] <= hour_set[7:4]+1'b1;
            end
        else if (hour_set[3:0] == 4'b0011 && hour_set[7:4] == 4'b0010)
            hour_set = 8'b0000_0000;
        else
            hour_set[3:0] <= hour_set[3:0] + 1'b1;
    end
endmodule

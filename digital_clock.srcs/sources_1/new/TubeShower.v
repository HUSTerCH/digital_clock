`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luo Chang
// 
// Create Date: 2023/03/17 20:49:59
// Design Name: 
// Module Name: TubeShower
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


module TubeShower(
    input CLK_1k,
    input CLK_2Hz,
    input showMode,//for show mode 0, 24h mode clock;mode 1, 12h mode clock
    input isSettingAlarm,
    input isPunctuallyReporting,// when is punctually reporting HH:mm flashs per 0.5 Sec,last two bit show flash time
    input [4:0] hour_real_num,//lower 4 bits are for hour ones bit,upper 4 bits are for hour tens bit
    input [7:0] hour,
    input [6:0] second_ones,
    input [6:0] second_tens,
    input [6:0] minute_ones,
    input [6:0] minute_tens,
    input [6:0] hour_ones,
    input [6:0] hour_tens,
    input [6:0] alarm_hour_setting_tens,
    input [6:0] alarm_hour_setting_ones,
    input [6:0] alarm_minute_setting_tens,
    input [6:0] alarm_minute_setting_ones,
    output reg [7:0] tubePos,
    output reg [6:0] showCode
    );
    integer k = 0;
    wire [6:0] convert0;
    wire [7:0] hour_12;
    reg [3:0] convert_ones,convert_tens;
    always@ (*)
        begin
            if (hour_real_num == 5'd20 || hour_real_num == 5'd21)
                convert_ones <= hour[3:0] + 8;
            else
                convert_ones <= hour[3:0] - 2;
        end
    TubeDecoder decoder0(convert_ones,convert0);
    always @(posedge CLK_1k)
        begin
            case(k)
                0:
//                show A or P or none for 12/24 hour switch or noting when set alarm
                    begin
                        tubePos <= 8'b1111_1110;
                        // when is setting alarm, show nothing
                        if (isSettingAlarm) showCode <= 7'b111_1111;
                        // when is punctually reporting,show hour ones bit
                        else if (isPunctuallyReporting) showCode <= hour_ones;
                        else if (showMode == 0) showCode <= 7'b111_1111;
                        else if (showMode == 1)
                            begin
                                if (hour_real_num >= 5'd12) showCode <= 7'b000_1100;
                                else showCode <= 7'b000_1000;
                            end
                        k <= k + 1;
                    end
                1:
//                show nothing
                    begin
                        tubePos <= 8'b1111_1101;
                        // when is punctually reporting,show hour tens bit
                        if (isPunctuallyReporting) showCode <= hour_tens;
                        else showCode <= 7'b111_1111;
                        k <= k + 1;
                    end
                2:
//                show second ones bit or noting when set alarm
                    begin
                        tubePos <= 8'b1111_1011;
                        if (isSettingAlarm) showCode <= 7'b111_1111;
                        else
                            begin
                                showCode <= second_ones;
                            end
                        k <= k + 1;
                    end
                3:
//                show second tens bit or noting when set alarm
                    begin
                        tubePos <= 8'b1111_0111;
                        if (isSettingAlarm) showCode <= 7'b111_1111;
                        else
                            begin
                                showCode <= second_tens;
                            end
                        k <= k + 1;
                    end
                4:
//                show minute ones bit
                    begin
                        tubePos <= 8'b1110_1111;
                        if (isSettingAlarm) showCode <= alarm_minute_setting_ones;
                        else if (isPunctuallyReporting)
                            begin
                                if (CLK_2Hz == 1'b1) showCode <= minute_ones;
                                else showCode <= 7'b111_1111;
                            end
                        else showCode <= minute_ones;
                        k <= k + 1;
                    end
                5:
//                show mintue tens bit
                    begin
                        tubePos <= 8'b1101_1111;
                        if (isSettingAlarm) showCode <= alarm_minute_setting_tens;
                        else if (isPunctuallyReporting)
                            begin
                                if (CLK_2Hz == 1'b1) showCode <= minute_tens;
                                else showCode <= 7'b111_1111;
                            end
                        else showCode <= minute_tens;
                        k <= k + 1;
                    end
                6:
//                show hour ones bit
                    begin
                        tubePos <= 8'b1011_1111;
                        if (isSettingAlarm) showCode <= alarm_hour_setting_ones;
                        else if (isPunctuallyReporting)
                            begin
                                if (CLK_2Hz == 1'b0) showCode <= 7'b111_1111;
                                else
                                    begin
                                        if (showMode == 0 || hour_real_num <= 5'd12) 
                                            showCode <= hour_ones;
                                        else if (showMode == 1 && hour_real_num > 5'd12)
                                            showCode <= convert0;
                                    end
                            end
                        else
                            begin
                                if (showMode == 0 || hour_real_num <= 5'd12) 
                                    showCode <= hour_ones;
                            else if (showMode == 1 && hour_real_num > 5'd12)
                                    showCode <= convert0;
                            end
                        k <= k + 1;
                    end
                7:
//                show hour tens bit
                    begin
                        tubePos <= 8'b0111_1111;
                        if (isSettingAlarm) showCode <= alarm_hour_setting_tens;
                        else if (isPunctuallyReporting)
                            begin
                                if (CLK_2Hz == 1'b0) showCode <= 7'b111_1111;
                                else
                                    if (showMode == 0 || hour_real_num <= 5'd12) showCode <= hour_tens;
                                    else if (showMode == 1)
                                        begin
                                            if (hour_real_num < 5'd22 && hour_real_num > 5'd12)
                                                showCode <= 7'b100_0000;
                                            else
                                                showCode <= 7'b111_1001;
                                        end
                            end
                        else
                            begin
                                if (showMode == 0 || hour_real_num <= 5'd12) showCode <= hour_tens;
                                else if (showMode == 1)
                                    begin
                                        if (hour_real_num < 5'd22 && hour_real_num > 5'd12)
                                            showCode <= 7'b100_0000;
                                        else 
                                            showCode <= 7'b111_1001;
                                    end
                            end
                        k <= k + 1;
                    end
                8: k <= 0;
            endcase
        end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    input showMode,//for show mode 0, 24h mode clock;mode 1, 12h mode clock
    input [4:0] hour_real_num,//lower 4 bits are for hour ones bit,upper 4 bits are for hour tens bit
    input [7:0] hour,
    input [6:0] second_ones,
    input [6:0] second_tens,
    input [6:0] minute_ones,
    input [6:0] minute_tens,
    input [6:0] hour_ones,
    input [6:0] hour_tens,
    output reg [7:0] tubePos,
    output reg [6:0] showCode
    );
    integer k = 0;
    wire [6:0] convert0,convert1;
    wire [7:0] hour_12;
    reg [3:0] convert_ones;
    always@ (*)
        begin
            if (hour_real_num >= 5'd22 || (hour_real_num >= 5'd12 && hour_real_num < 5'd20))
                convert_ones = hour[3:0] - 2;
            else if (hour_real_num < 5'd22 && hour_real_num >= 5'd20)
                convert_ones = hour[3:0] + 8;
        end
    TubeDecoder decoder0(convert_ones,convert0);
    always @(posedge CLK_1k)
        begin
            case(k)
                0:
//                show A or P or none for 12/24 hour switch
                    begin
                        tubePos <= 8'b1111_1110;
                        if (showMode == 0) showCode <= 7'b111_1111;
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
                        showCode <= 7'b111_1111;
                        k <= k + 1;
                    end
                2:
//                show second ones bit
                    begin
                        tubePos <= 8'b1111_1011;
                        showCode <= second_ones;
                        k <= k + 1;
                    end
                3:
//                show second tens bit
                    begin
                        tubePos <= 8'b1111_0111;
                        showCode <= second_tens;
                        k <= k + 1;
                    end
                4:
//                show minute ones bit
                    begin
                        tubePos <= 8'b1110_1111;
                        showCode <= minute_ones;
                        k <= k + 1;
                    end
                5:
//                show mintue tens bit
                    begin
                        tubePos <= 8'b1101_1111;
                        showCode <= minute_tens;
                        k <= k + 1;
                    end
                6:
                // still some problem please correct in Friday
//                show hour ones bit
                    begin
                        tubePos <= 8'b1011_1111;
                        if (showMode == 0) showCode <= hour_ones;
                        else if (showMode == 1)
                            showCode <= convert0;
//                            begin
//                                if (hour_real_num >= 5'd12)
//                                    begin
//                                        showCode <= convert0;
//                                    end
//                                else if (hour_num[7:4] == 5'd2)
//                                    begin
                                        
//                                        showCode <= convert1;
//                                    end
//                             end
                        k <= k + 1;
                    end
                7:
//                show hour tens bit
                    begin
                        tubePos <= 8'b0111_1111;
                        if (showMode == 0) showCode <= hour_tens;
                        else if (showMode == 1)
                            begin
                                if ((hour_real_num > 5'd12 && hour_real_num < 5'd22) || (hour_real_num < 5'd10))
                                    showCode <= 7'b100_0000;
                                else 
                                    showCode <= 7'b111_1001;
                            end
                        k <= k + 1;
                    end
                8: k <= 0;
            endcase
        end
endmodule

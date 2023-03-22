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
    input showMode,//for show mode 1, 24h mode clock;mode 2, 12h mode clock
    input [7:0] hour_num,//lower 4 bits are for hour ones bit,upper 4 bits are for hour tens bit
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
    TubeDecoder decoder0(hour_num[3:0] - 4'd2,convert0);
    TubeDecoder decoder1(hour_num[3:0] + 4'd8,convert1);
    always @(posedge CLK_1k)
        begin
            case(k)
                0:
//                show A or P or none for 12/24 hour switch
                    begin
                        tubePos <= 8'b1111_1110;
                        if (showMode == 1) showCode <= 7'b111_1111;
                        else if (showMode == 2)
                            begin
//                            wrong,please correct.hour_ones and hour_tens are 7 bit code not number.
                                if ((hour_num[3:0] > 4'd2 && hour_num[7:4] == 4'd1)||hour_num[7:4] >= 4'd2) showCode <= 7'b000_1100;
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
//                show hour ones bit
                    begin
                        tubePos <= 8'b1011_1111;
                        if (showMode == 1) showCode <= hour_ones;
                        else if (showMode == 2)
                            begin
                                if (hour_num[3:0] > 4'd2 && hour_num[7:4] == 4'd1)
                                    begin
                                        showCode <= convert0;
                                    end
                                else if (hour_num[7:4] == 4'd2)
                                    begin
                                        
                                        showCode <= convert1;
                                    end
                             end
                        k <= k + 1;
                    end
                7:
//                show hour tens bit
                    begin
                        tubePos <= 8'b0111_1111;
                        if (showMode == 1) showCode <= hour_tens;
                        else if (showMode == 2)
                            begin
                                if ((hour_num[3:0] > 4'd2 && hour_num[7:4] == 4'd1)||(hour_num[3:0] < 4'd2 && hour_num[7:4] == 4'd2))
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 18:53:12
// Design Name: 
// Module Name: Counter_60
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


module Counter_60(
    input CP,
    input EN,
    input CR,
    output reg [7:0] Q,
    output reg carryBit
    );
    wire onesToTensCarryBit;
    wire tensToUpperCarryBit;
    wire [3:0] ones,tens;
    Counter_10 OnesPlace(CP,CR,EN,ones,onesToTensCarryBit);
    Counter_6 TensPlace(onesToTensCarryBit,CR,EN,tens,tensToUpperCarryBit);
    always @(ones,tens) Q = {tens[3:0],ones[3:0]};
    always @(tensToUpperCarryBit) carryBit = tensToUpperCarryBit;
endmodule

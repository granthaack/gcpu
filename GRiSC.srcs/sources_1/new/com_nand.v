`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2018 11:58:44 PM
// Design Name: 
// Module Name: com_and
// Project Name: Grant Haack
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


module com_nand#(parameter WIDTH=16)(
    input   [WIDTH-1:0] a,
    input   [WIDTH-1:0] b,
    output  [WIDTH-1:0] c
    );
    assign c = ~(a & b);
endmodule

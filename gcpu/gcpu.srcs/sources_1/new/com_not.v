`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2018 12:00:55 AM
// Design Name: Grant Haack
// Module Name: com_not
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


module com_not#(parameter WIDTH=11)(
    input [WIDTH-1:0] a,
    output [WIDTH-1:0] c
    );
    assign c = ~a;
endmodule
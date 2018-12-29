`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2018 12:35:42 AM
// Design Name: 
// Module Name: mux2
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


module mux2#(parameter WIDTH=16)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    
    input sel,
    
    output [WIDTH-1:0] out
);

assign out = sel ? b : a;

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/22/2018 06:31:02 PM
// Design Name: 
// Module Name: mux8
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


module mux8 #(parameter WIDTH=16)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [WIDTH-1:0] c,
    input [WIDTH-1:0] d,
    input [WIDTH-1:0] e,
    input [WIDTH-1:0] f,
    input [WIDTH-1:0] g,
    input [WIDTH-1:0] h,
    
    input [2:0]s,
    
    output [WIDTH-1:0] out
    
    );
    
    assign out = s[2] ? (s[1] ? (s[0] ? (h):(g) ):(s[0] ? (f):(e) ) ) : (s[1] ? (s[0] ? (d):(c) ) : (s[0] ? (b):(a) ));
    
endmodule

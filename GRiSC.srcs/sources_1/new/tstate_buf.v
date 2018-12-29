`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Grant Haack
// 
// Create Date: 12/27/2018 04:04:50 PM
// Design Name: 
// Module Name: tstate_buf
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

//Basic parameterized tristate buffer
//Active high output enable
module tstate_buf #(parameter WIDTH=16)(
    input [WIDTH-1:0]in,
    input oe,
    output [WIDTH-1:0]out
    );
    
    assign out = oe ? in : 11'bz;
    
endmodule

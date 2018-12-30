`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2018 09:54:38 PM
// Design Name: 
// Module Name: incrementer
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


module incrementer(
    input [15:0]in,
    output [15:0]out
    );
    
    cla_adder add(
        .a(in),
        .b(15'b1),
        .c_in(15'b0),
        .s(out)
    );
    
endmodule

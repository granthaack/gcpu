`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2018 12:16:03 AM
// Design Name: 
// Module Name: cla_sub
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


// Carry lookahead subtractor
// Performs a - b
module cla_sub(
    //A input
    input [10:0]a,
    //B input
    input [10:0]b,
    input c_in,
    
    output [10:0]d,
    output c_out
    );
    
    wire [10:0] twos_s_w;
    wire twos_c_out_w;
    
    // Compute the two's compliment of b to get negative b
    cla_adder twos(
        .a(~b), 
        .b(11'b1),
        .s(twos_s_w),
        .c_out(twos_c_out_w)
    );
    
    // Add a and negative b to perform subtraction
    cla_adder sub(
        .a(a),
        .b(twos_c_out_w),
        .s(d)
    );
    
endmodule

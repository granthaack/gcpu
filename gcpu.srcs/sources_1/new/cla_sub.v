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
    
    //Difference output
    output [10:0]d,
    //Overflow flag output
    output o_flag
    );
    
    wire [10:0] twos_s_w;
    wire twos_c_out_w;
    wire twos_c_in_w;
    
    // Compute the two's compliment of b to get negative b
    // Invert and add one
    cla_adder twos(
        .c_in(11'd0),
        .a(~b), 
        .b(11'd1),
        .s(twos_s_w)
    );
    
    // Add a and negative b to perform subtraction
    cla_adder sub(
        .c_in(11'd0),
        .a(a),
        .b(twos_s_w),
        .s(d),
        .t_c_out(twos_c_in_w),
        .c_out(twos_c_out_w)
    );
    
    //Determine if an overflow has occured by xor
    com_xor #(1)c_xor(
        .a(twos_c_in_w),
        .b(twos_c_out_w),
        .c(o_flag)
    );
    
endmodule
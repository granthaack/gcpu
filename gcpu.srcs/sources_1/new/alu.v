`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2018 10:29:40 PM
// Design Name: 
// Module Name: alu
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

//Sequential ALU

//Add
//Subtract
//AND
//OR
//XOR
//NOT
//Two ops left blank for future use
module alu #(parameter WIDTH=11)(
    //Input A
    input [WIDTH-1:0]a,
    //Input B
    input [WIDTH-1:0]b,
    //Opcode
    input [2:0]op,
    //Output C
    output [WIDTH-1:0]c,
    //Overflow flag
    output o_flag,
    //Zero flag
    output z_flag
    );
    
    wire adder_o_w;
    wire sub_o_w;
    
    //If C is zero, set the zero flag
    assign z_flag = !c ? 1'b1 : 1'b0;
    //If any overflow happen, set the overflow flag
    assign o_flag = adder_o_w | sub_o_w;
    
    wire [WIDTH-1:0] add_w;
    wire [WIDTH-1:0] sub_w;
    wire [WIDTH-1:0] and_w;
    wire [WIDTH-1:0] or_w;
    wire [WIDTH-1:0] xor_w;
    wire [WIDTH-1:0] not_w;

    //Instantiate the CLA adder for the add opcode
    cla_adder cla(
        .c_in(1'b0),
        .a(a),
        .b(b),
        .s(add_w),
        .c_out(adder_o_w)
    );
    
    //Instantiate the CLA subtractor for the sub opcode
    cla_sub sub(
        .a(a),
        .b(b),
        .o_flag(sub_o_w),
        .d(sub_w)
    );
    
    //Instantiate the combinational AND for the and opcode
    com_and #(11)c_and(
        .a(a),
        .b(b),
        .c(and_w)
    );
    
    //Instantiate the combinational OR for the or opcode
    com_or #(11)c_or(
        .a(a),
        .b(b),
        .c(or_w)
    );
    
    //Instantiate the combinational XOR for the xor opcode
    com_xor #(11)c_xor(
        .a(a),
        .b(b),
        .c(xor_w)
    );
    
    //Instantiate the combinational NOT for the not opcode
    com_not #(11)c_not(
         .a(a),
        .c(not_w)
    );
    
    //Intantiate the 8 mux to multiplex out the result
    mux8 #(11)mux(
        .a(add_w),
        .b(sub_w),
        .c(and_w),
        .d(or_w),
        .e(xor_w),
        .f(not_w),
        
        .s(op),
        
        .out(c)
    );

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2018 11:54:25 PM
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


module alu(
        //16 bit inputs to the ALU
        input [15:0] a,
        input [15:0] b,
        //1 bit opcode, add or NAND
        input opcode,
        output [15:0]c,
        output not_eq
    );
    
    assign not_eq = (a ^ b) ? 1'b1 : 1'b0; 
    
    wire [15:0] nand_out_w;
    wire [15:0] add_out_w;
        
    com_nand nander(
        .a(a),
        .b(b),
        .c(nand_out_w)
    );
    
    cla_adder adder(
        .c_in(1'b0),
        .a(a),
        .b(b),
        .s(add_out_w)
    );
    
    mux2 out_mux(
        .a(add_out_w),
        .b(nand_out_w),
        .sel(opcode),
        .out(c)
    );
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/02/2018 10:16:44 PM
// Design Name:
// Module Name: half_adder
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


module half_adder(
    //Input bits
    input A_in,
    input B_in,

    //Sum propogate output
    output P_out,
    //Carry output
    output G_out
    );

    //XOR A and B to get the propogated sum
    assign P_out = A_in ^ B_in;
    //AND A and B to get the carry output
    assign G_out = A_in & B_in;

endmodule

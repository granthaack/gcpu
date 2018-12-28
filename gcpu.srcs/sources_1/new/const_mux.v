`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2018 05:23:55 PM
// Design Name: 
// Module Name: const_mux
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

//Put a constant 1 or 0 on the data bus
module const_mux(
    input sel,
    input cs,
    output out
    );
    assign out = cs ? (sel ? 11'b1 : 11'b0) : (11'bZ);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Grant Haack
// 
// Create Date: 12/13/2018 11:10:08 PM
// Design Name: 
// Module Name: dreg
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

//Parameterized d register
module dreg #(parameter WIDTH=16, NAME="DREG")(
    //D input, default width of 16 bits
    input [WIDTH-1:0] d,
    //Write enable
    input wr,
    //Clock input
    input clk,
    //Reset input, asynchronous
    input rst,
    //Q output, default width of 11 bits
    output reg [WIDTH-1:0] q
    );
    
    always @(posedge clk, posedge rst) begin
        //Async reset
        if(rst) begin
            $display("DREG %s: Resetting %s...", NAME, NAME);
            q = 0;
        end
        //Sync write and read
        else if(wr) begin
            $display("DREG %s: Writing %h, replacing %h", NAME, d, q,);
            q <= d;
        end
    end
endmodule

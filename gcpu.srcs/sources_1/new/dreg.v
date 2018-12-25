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

//Parameterized tristate d register
module dreg #(parameter WIDTH=11)(
    //D input, default width of 8 bit
    input [WIDTH-1:0] d,
    //Write signal
    input wr,
    //Read signal
    input rd,
    //Clock input
    input clk,
    //Reset input, asynchronous
    input rst,
    //Q output, default width of 8 bit
    output reg [WIDTH-1:0] q
    );
    always @(posedge clk, posedge rst) begin
        //Async reset
        if(rst) begin
            q = 0;
        end
        //Sync write and read
        else if(clk) begin
            if(wr) begin
                q <= d;
            end
            else begin
                q <= rd ? q : WIDTH-1'bZ;
            end
        end
    end
endmodule
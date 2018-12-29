`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Grant Haack
// 
// Create Date: 10/21/2018 03:36:01 PM
// Design Name: 
// Module Name: regfile
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

module regfile#(parameter WIDTH=16)
    (
        //Port 0, Read
        //Read data port 1
        output [WIDTH-1:0]rd0,
        //Read address port 1
        input [2:0]ra0,
    
        //Port 1, Read
        //Read data port 1
        output [WIDTH-1:0]rd1,
        //Read address port 1
        input [2:0]ra1,
        
        //Port 2, Write
        //Write data port 2
        input [WIDTH-1:0]wd0,
        //Write address port 2
        input [2:0]wa0,
        //Write enable port 2
        input we0,
        
        //Clock
        input clk,
        //Chip Select
        input cs,
        //Reset the regfile (TODO)
        input rst
    );
    
    //Declare a 2d array of bytes to create the register file
    reg [WIDTH-1:0]rf [7:0];
    
    always @(posedge clk) begin
        //Use an if/else to make sure that two sources can't
        //write to the reg at the same time from two write ports
        if(we0) begin
            rf[wa0] <= wd0;
        end
    end
    
    //Asynchronous reads with output enable
    assign rd0 = rf[ra0];
    assign rd1 = rf[ra1];
endmodule
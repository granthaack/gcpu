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

//Triple ported register file
//Asynchronously read from 2 ports at the same time and write to another port

//Register Map
//[0] A (General Purpose)
//[1] B (General Purpose)
//[2] C (General Purpose)
//[3] D (General Purpose)
//[4] Instruction Pointer (IP)
//[5] Stack Base (SB)
//[6] Stack Top (ST)
//[7] Status Register (SR)

module regfile#(parameter WIDTH=11)
    (
        //Port 1, Read
        //Read data port 1
        output [WIDTH-1:0]rd1,
        //Read address port 1
        input [2:0]ra1,
        
        //Port 2, Read
        //Read data port 2
        output [WIDTH-1:0]rd2,
        //Read address port 2
        input [2:0]ra2,
        
        //Port 3, Write
        //Write data port 2
        input [WIDTH-1:0]wd1,
        //Write address port 2
        input [2:0]wa1,
        //Write enable port 2
        input we1,
        
        //Clock
        input clk
    );
    
    //Declare a 2d array of bytes to create the register file
    reg [WIDTH-1:0]rf [7:0];
    
    always @(posedge clk) begin
        //Use an if/else to make sure that two sources can't
        //write to the reg at the same time from two write ports
        if(we1) begin
            rf[wa1] <= wd1;
        end
    end
    
    //Asynchronous reads
    assign rd1 = rf[ra1];
    assign rd2 = rf[ra2];    
endmodule
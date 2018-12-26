`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2018 01:43:59 AM
// Design Name: Grant Haack
// Module Name: ex_dp
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

//Execution Unit Datapath
//Contains all the hardware to execute an instruction, minus the control circuitry
module ex_dp(

    );
    alu ex_alu();
    regfile #(11)regs();
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2019 12:49:59 AM
// Design Name: 
// Module Name: cpu_dp_tb
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


module cpu_dp_tb();

        //Data lines
        wire  [15:0]data_mem_in;
        reg   [15:0]data_mem_out;
        reg   [15:0]instr_mem_in;
        
        //Address Lines
        wire  [15:0]data_mem_addr;
        wire  [15:0]instr_mem_addr;
        
        //Signals for the BIU
        wire give_instr_addr;
        wire get_instr_mem;
        wire give_data_addr;
        wire get_data_mem;
        wire give_data_mem;
        
        //Inputs from Control System
        reg regfile_rd1_mux_sel;
        reg regfile_we0;
        reg [1:0]regfile_wd0_mux_sel;
        reg alu_a_mux_sel;
        reg alu_b_mux_sel;
        reg [1:0]pc_mux_sel;
        reg alu_opcode;
        
        //Feedback to Control System
        wire not_eq;
        wire [2:0]opcode;
        
        //Basic Control Signals
        reg clk;
        reg rst;
    
        cpu_dp DUT(
            .data_mem_in(data_mem_in),
            .data_mem_out(data_mem_out),
            .instr_mem_in(instr_mem_in),
            .data_mem_addr(data_mem_addr)
        );
endmodule

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
// Available Instructions
// Move data
// MOV [addr], [reg], MOV [reg], [addr], MOV [reg], [reg], MOV [addr], [addr]
//
// Add data, store back in reg1
// ADD [reg1], [reg]
//
// Subtract data, store back in reg1
// SUB [reg1], [reg]
// 
// Bitwise AND data, store back in reg1
// AND [reg1], [reg]
//
// Bitwise OR data, store back in reg1
// OR [reg1], [reg]
//
// Bitwise XOR data, store back in reg1
// XOR [reg1], [reg]
//
// Bitwise NOT reg1, Store back in reg1
// NOT [reg1]
//
// Push reg1 to stack
// PUSH [reg1]
//
// Pop from stack, store in reg1
// POP [reg1]
// 
// Unconditional Jump to an address
// JMP [addr]
//
// Conditional jump if zero flag is set
// JZ [addr]
module ex_dp#(parameter WIDTH=11)(
    //IO bus
    inout [WIDTH-1:0]io_bus,
    
    //Control bus signals
    //Clock
    input clk,
    //Read
    input rd,
    //Write
    input wr,
    //Reset
    input rst,
    
    //Write enables for the regs connected to the ALU
    input alu_a_reg_cs,
    input alu_b_reg_cs,
    
    //Opcode for the ALU
    input [2:0]alu_op,
    //Chip select for the Status register
    input stat_reg_cs,
    
    //Write enable for the regfile
    input regfile_cs,
    //Write address for the regfile
    input regfile_wa,
    //Read address for the regfile
    input regfile_ra,
    
    //Select pin for the const mux
    input consts_sel,
    //Chip select for the const mux
    input consts_cs,
    
    //Output enable for the ALU
    input alu_oe
    );
    
    wire [WIDTH-1:0] alu_a_reg_w;
    wire [WIDTH-1:0] alu_b_reg_w;
    wire o_flag_w;
    wire z_flag_w;
    
    dreg #(WIDTH)alu_a_reg(
        .wr(wr),
        .rd(rd),
        .d(io_bus),
        .q(alu_a_reg_w),
        .cs(alu_a_reg_cs),
        .rst(rst),
        .clk(clk)
    );
    
    dreg #(WIDTH)alu_b_reg(
        .d(io_bus),
        .wr(wr),
        .rd(rd),
        .cs(alu_b_reg_cs),
        .clk(clk),
        .rst(rst),
        .q(alu_b_reg_w)
    );
    
    alu ex_alu(
        .a(alu_a_reg_w),
        .b(alu_b_reg_w),
        .op(alu_op),
        .oe(alu_oe),
        .c(io_bus),
        .o_flag(o_flag_w),
        .z_flag(z_flag_w)
    );
    
    regfile #(WIDTH)regs(
        .rd1(io_bus),
        .wd1(io_bus),
        .ra1(regfile_ra),
        .wa1(regfile_wa),
        .re1(rd),
        .we1(wr),
        .cs(regfile_cs),
        .clk(clk)
    );
    
    dreg #(WIDTH)stat(
        .d({z_flag_w, o_flag_w, 9'b0}),
        .wr(wr),
        .rd(rd),
        .cs(stat_reg_cs),
        .clk(clk),
        .rst(rst),
        .q(io_bus)
    );
    
    const_mux consts(
        .sel(consts_sel),
        .cs(consts_cs),
        .out(io_bus)
    );
endmodule
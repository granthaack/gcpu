`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2018 01:14:40 AM
// Design Name: 
// Module Name: cpu_dp
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


module cpu_dp(
        //Data lines
        //Data coming IN FROM the memory
        input  [15:0]data_mem_in,
        //Data going OUT TO the memory
        output   [15:0]data_mem_out,
        //Data coming IN FROM the memory
        input   [15:0]instr_mem_in,
        
        //Address Lines
        output  [15:0]data_mem_addr,
        output  [15:0]instr_mem_addr,
        
        //Inputs from Control System
        input regfile_rd1_mux_sel,
        input regfile_we0,
        input [1:0]regfile_wd0_mux_sel,
        input alu_a_mux_sel,
        input alu_b_mux_sel,
        input [1:0]pc_mux_sel,
        input [1:0]alu_opcode,
        input ireg_wr,
        input pc_wr,
        
        //Feedback to Control System
        output not_eq,
        output [2:0]opcode,
        
        //Basic Control Signals
        input clk,
        input rst
    );
    wire [15:0]iword_shifter_out_w;
    wire [15:0]iword_stender_out_w;
    wire [15:0]regfile_rd0_w;
    wire [15:0]regfile_rd1_w;
    wire [15:0]regfile_in_w;
    wire [15:0]alu_a_in_w;
    wire [15:0]alu_b_in_w;
    wire [15:0]alu_out_w;
    wire [15:0]pc_out_w;
    wire [15:0]ireg_out_w;
    wire [15:0]pc_in_w;
    wire [6:0] stender_in_w;
    wire [9:0] shifter_in_w;
    wire [15:0] inc_out_w;
    wire [15:0] beq_adder_out_w;
    wire [2:0]  ireg_ra_w;
    wire [2:0]  ireg_rb_w;
    wire [2:0]  ireg_rc_w;
    wire [2:0] rd1_mux_out_w;
        
    assign regfile_rd1_w = data_mem_out;
    assign opcode = ireg_out_w[15:13];
    assign stender_in_w = ireg_out_w[6:0];
    assign shifter_in_w = ireg_out_w[9:0];
    assign ireg_ra_w = ireg_out_w[12:10];
    assign ireg_rb_w = ireg_out_w[9:7];
    assign ireg_rc_w = ireg_out_w[2:0];
    assign data_mem_addr = alu_out_w;
    
    assign instr_mem_addr = pc_out_w;   
    
    //Program Counter Data Register
    dreg #(16,"PC")pc(
        .rst(rst),
        .clk(clk),
        .d(pc_in_w),
        .q(pc_out_w),
        .wr(pc_wr)
    );
    
    //Incrementer
    //Used to increment the program counter after each instruction fetch
    incrementer inc(
        .in(pc_out_w),
        .out(inc_out_w)
    );
    
    //BEQ Adder
    //
    cla_adder beq_adder(
        .a(iword_stender_out_w),
        .b(inc_out_w),
        .c_in(1'b0),
        .s(beq_adder_out_w)
    );
    
    mux4 pc_mux(
        .a(alu_out_w),
        .b(beq_adder_out_w),
        .c(inc_out_w),
        .d(pc_out_w),
        .sel(pc_mux_sel),
        .out(pc_in_w)
    );
    
    mux4 regfile_wd0_mux(
        .a(inc_out_w),
        .b(alu_out_w),
        .c(data_mem_in),
        .sel(regfile_wd0_mux_sel),
        .out(regfile_in_w)
    );
    
    dreg #(16,"IR") ir(
        .rst(rst),
        .clk(clk),
        .d(instr_mem_in),
        .q(ireg_out_w),
        .wr(ireg_wr)
    );
    
    mux2 #(3)regfile_rd1_mux(
        .a(ireg_ra_w),
        .b(ireg_rc_w),
        .out(rd1_mux_out_w),
        .sel(regfile_rd1_mux_sel)
    );
    
    regfile regs(
        .rd0(regfile_rd0_w),
        .rd1(regfile_rd1_w),
        .ra0(ireg_rb_w),
        .ra1(rd1_mux_out_w),
        .wa0(ireg_ra_w),
        .wd0(regfile_in_w),
        .clk(clk),
        .rst(rst),
        .we0(regfile_we0)
    );
    
    lshift6 iword_shifter(
        .in(shifter_in_w),
        .out(iword_shifter_out_w)
    );
    
    stender7 iword_stender(
        .in(stender_in_w),
        .out(iword_stender_out_w)
    );
    
    mux2 alu_a_mux(
        .a(iword_stender_out_w),
        .b(regfile_rd1_w),
        .sel(alu_a_mux_sel),
        .out(alu_a_in_w)
    );
    
    mux2 alu_b_mux(
        .a(iword_shifter_out_w),
        .b(regfile_rd0_w),
        .sel(alu_b_mux_sel),
        .out(alu_b_in_w)
    );
    
    alu the_alu(
        .a(alu_a_in_w),
        .b(alu_b_in_w),
        .c(alu_out_w),
        .opcode(alu_opcode),
        .not_eq(not_eq)
    );
    
endmodule

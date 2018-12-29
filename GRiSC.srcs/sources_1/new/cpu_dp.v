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
        inout [15:0]data_bus,
        inout [15:0]addr_bus,
        input clk,
        input rst
    );
    
    wire [15:0]iword_shifter_out_w;
    wire [15:0]iword_stender_out_w;
    wire [15:0]regfile_r0_w;
    wire [15:0]regfile_r1_w;
    wire [15:0]alu_a_in_w;
    wire [15:0]alu_b_in_w;
    wire [15:0]alu_out_w;
    wire [15:0]pc_out_w;
    wire [15:0]ireg_out_w;
    wire [15:0]pc_in_w;
    wire [15:0]ireg_in_w;
    wire [5:0] stender_in_w;
    assign stender_in_w = ireg_out_w[5:0];
    wire [8:0] shifter_in_w;
    assign shifter_in_w = ireg_out_w[8:0];
    
    dreg pc(
        .rst(rst),
        .clk(clk),
        .d(pc_in_w),
        .q(pc_out_w)
    );
    
    dreg ir(
        .rst(rst),
        .clk(clk),
        .d(ireg_in_w),
        .q(ireg_out_w)
    );
    
    regfile regs(
        .rd0(regfile_r0_w),
        .rd1(regfile_r1_w)
    );
    
    lshift6 iword_shifter(
        .in(shifter_in_w),
        .out(iword_shifter_out_w)
    );
    
    stender9 iword_stender(
        .in(stender_in_w),
        .out(iword_stender_out_w)
    );
    
    mux2 alu_a_mux(
        .a(iword_stender_out_w),
        .b(regfile_r1_w),
        .out(alu_a_in_w)
    );
    
    mux2 alu_b_mux(
        .a(iword_shifter_out_w),
        .b(regfile_r0_w),
        .out(alu_b_in_w)
    );
    
    alu the_alu(
        .a(alu_a_in_w),
        .b(alu_b_in_w)
    );
    
endmodule

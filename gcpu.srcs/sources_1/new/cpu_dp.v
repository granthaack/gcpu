`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2018 11:57:11 PM
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


module cpu_dp #(parameter WIDTH=11)(
        //IO Busses
        //Internal IO bus
        inout [WIDTH-1:0]i_io_bus,
        //External IO Bus
        inout [WIDTH-1:0]e_io_bus,
        
        //Control bus signals
        //Clock
        input clk,
        //Reset
        input rst,
        
        //Internal IO Bus Controls
        //Internal Read
        input i_rd,
        //Internal Write
        input i_wr,
        
        //External IO Bus Controls
        //External Write
        output e_wr,
        //External Read
        output e_rd,
        
        //Chip selects for the regs connected to the ALU
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
        input alu_oe,
        
        //Control signals for the BIU registers
        input addr_reg_cs,
        input datin_reg_cs,
        input datout_reg_cs,
        input ctrl_reg_cs
    );
    
    ex_dp ex(
        .clk(clk),
        .rst(rst),
        .rd(i_rd),
        .wr(i_wr),
        .io_bus(i_io_bus),
        .alu_a_reg_cs(alu_a_reg_cs),
        .alu_b_reg_cs(alu_b_reg_cs),
        .alu_op(alu_op),
        .stat_reg_cs(stat_reg_cs),
        .regfile_cs(regfile_cs),
        .regfile_wa(regfile_wa),
        .regfile_ra(regfile_ra),
        .consts_sel(consts_sel),
        .consts_cs(consts_cs),
        .alu_oe(alu_oe)
    );
    
    biu_dp biu(
        .i_io_bus(i_io_bus),
        .addr_reg_cs(addr_reg_cs),
        .datin_reg_cs(datin_reg_cs),
        .datout_reg_cs(datout_reg_cs),
        .ctrl_reg_cs(ctrl_reg_cs),
        .i_rd(i_rd),
        .i_wr(i_wr),
        .e_io_bus(e_io_bus),
        .e_wr(e_wr),
        .e_rd(e_rd),
        .rst(rst),
        .clk(clk)
    );
    
endmodule

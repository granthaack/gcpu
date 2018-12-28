`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2018 10:26:11 PM
// Design Name: 
// Module Name: biu_dp
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

//Bus Interface Unit Datapath
module biu_dp #(parameter WIDTH=11)(
    //Internal IO Bus
    inout [WIDTH-1:0]i_io_bus,
    
    //Control signals for the BIU registers
    input addr_reg_cs,
    input datin_reg_cs,
    input datout_reg_cs,
    input ctrl_reg_cs,
    input i_rd,
    input i_wr,
    
    //External IO Bus
    inout [WIDTH-1:0]e_io_bus,
    
    //External IO Bus Controls
    output e_wr,
    output e_rd,
    
    //Basic controls
    input rst,
    input clk
    );
    
    //Address register
    dreg #(WIDTH)addr_reg(
        .d(i_io_bus),
        .wr(i_wr),
        .rd(i_rd),
        .cs(addr_reg_cs),
        .clk(clk),
        .rst(rst),
        .q(e_io_bus)
    );
    
    //Data In register
    dreg #(WIDTH)datin_reg(
        .d(e_io_bus),
        .wr(i_wr),
        .rd(i_rd),
        .cs(datin_reg_cs),
        .clk(clk),
        .rst(rst),
        .q(i_io_bus)
    );
    
    //Data Out register
    dreg #(WIDTH)datout_reg(
        .d(i_io_bus),
        .wr(i_wr),
        .rd(i_rd),
        .cs(datout_reg_cs),
        .clk(clk),
        .rst(rst),
        .q(e_io_bus)
    );
    
    //External Control register
    dreg #(WIDTH)ctrl_reg(
        .d(i_io_bus),
        .wr(i_wr),
        .rd(i_rd),
        .cs(ctrl_reg_cs),
        .clk(clk),
        .rst(rst),
        .q({e_wr, e_rd, 9'b0})
    );
endmodule

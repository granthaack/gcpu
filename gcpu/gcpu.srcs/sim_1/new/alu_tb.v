`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/22/2018 10:08:14 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();

    reg [10:0]a_tb;
    reg [10:0]b_tb;
    
    reg [2:0]op_tb;
    
    wire [10:0]c_tb;
    wire o_flag_tb;
    wire z_flag_tb;

    alu DUT(
        .a(a_tb),
        .b(b_tb),
        .op(op_tb),
        .c(c_tb),
        .o_flag(o_flag_tb),
        .z_flag(z_flag_tb)
    );
    
    integer i = 0;
    integer j = 0;
    integer errors = 0;
    
    reg [10:0]c_exp_tb;
    reg o_flag_exp_tb;
    reg z_flag_exp_tb;
    
    initial begin
    
        //Test addition
        op_tb = 0;
        for(i = 0; i < 2048; i = i + 1) begin
            for(j = 0; j < 2048; j = j + 1) begin
                a_tb = i;
                b_tb = j;
                c_exp_tb = i + j;
                #5;
                if(c_tb != c_exp_tb) begin
                    $display("ERROR: Expected %d, got %d", c_exp_tb, c_tb);
                    errors = errors + 1;
                end
                else begin
                    $display("SUCCESS: Got %d", c_tb);
                end
            end
        end
    end

endmodule

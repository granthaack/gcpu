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
    
    reg [10:0]a_tb_check = 0;
    reg [10:0]b_tb_check = 0;
    
    //Check the overflow flag.
    //This ALU is signed with 2's complement
    task o_flag_check(sub); begin
        a_tb_check = a_tb;
        b_tb_check = b_tb;
        //If the sub option is set, perform 2's compliment on b first
        if(sub == 1) begin
            b_tb_check = (~b_tb_check) + 1;
        end
        //If a and b have the same sign bit, the output must have that same signed bit
        //If they don't, an overflow occured
        if ((a_tb_check[10] == b_tb_check[10]) && (a_tb_check[10] != c_tb[10])) begin
            if(o_flag_tb) begin
                $display("SUCCESS: o_flag caught overflow");
            end
            else begin
                $display("ERROR: o_flag failed to catch overflow");
                errors = errors + 1;
            end
        end
        //If these situations didn't occur and the o_flag was set, it's a false positive
        else if(o_flag_tb) begin
            $display("ERROR: o_flag is falsely set");
            errors = errors + 1;
        end
    end
    endtask
        
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
                    $display("SUCCESS: %d + %d = %d",a_tb, b_tb, c_tb);
                end
                o_flag_check(0);
            end
        end
        //Test Subtraction
        op_tb = 1;
        for(i = 0; i < 2048; i = i + 1) begin
            for(j = 0; j < 2048; j = j + 1) begin
                a_tb = i;
                b_tb = j;
                c_exp_tb = i - j;
                #5;
                if(c_tb != c_exp_tb) begin
                    $display("ERROR: Expected %d, got %d", c_exp_tb, c_tb);
                    errors = errors + 1;
                end
                else begin
                    $display("SUCCESS: %d - %d = %d",a_tb, b_tb, c_tb);
                end
                o_flag_check(1);
            end
        end
        //Test AND
        op_tb = 2;
        for(i = 0; i < 2048; i = i + 1) begin
            for(j = 0; j < 2048; j = j + 1) begin
                a_tb = i;
                b_tb = j;
                c_exp_tb = i & j;
                #5;
                if(c_tb != c_exp_tb) begin
                    $display("ERROR: Expected %b, got %b", c_exp_tb, c_tb);
                    errors = errors + 1;
                end
                else begin
                    $display("SUCCESS: %b & %b = %b",a_tb, b_tb, c_tb);
                end
            end
        end    
        //Test OR
        op_tb = 3;
        for(i = 0; i < 2048; i = i + 1) begin
            for(j = 0; j < 2048; j = j + 1) begin
                a_tb = i;
                b_tb = j;
                c_exp_tb = i | j;
                #5;
                if(c_tb != c_exp_tb) begin
                    $display("ERROR: Expected %b, got %b", c_exp_tb, c_tb);
                    errors = errors + 1;
                end
                else begin
                    $display("SUCCESS: %b | %b = %b",a_tb, b_tb, c_tb);
                end
            end
        end  
        //Test XOR
        op_tb = 4;
        for(i = 0; i < 2048; i = i + 1) begin
            for(j = 0; j < 2048; j = j + 1) begin
                a_tb = i;
                b_tb = j;
                c_exp_tb = i ^ j;
                #5;
                if(c_tb != c_exp_tb) begin
                    $display("ERROR: Expected %b, got %b", c_exp_tb, c_tb);
                    errors = errors + 1;
                end
                else begin
                    $display("SUCCESS: %b ^ %b = %b",a_tb, b_tb, c_tb);
                end
            end
        end  
        //Test NOT
        op_tb = 5;
        for(i = 0; i < 2048; i = i + 1) begin
            a_tb = i;
            c_exp_tb = ~a_tb;
            #5;
            if(c_tb != c_exp_tb) begin
                $display("ERROR: Expected %b, got %b", c_exp_tb, c_tb);
                errors = errors + 1;
            end
            else begin
                $display("SUCCESS: ~%b = %b",a_tb, c_tb);
            end
        end  
    end
endmodule

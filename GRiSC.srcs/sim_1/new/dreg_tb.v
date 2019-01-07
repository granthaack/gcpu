`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/06/2019 06:15:28 PM
// Design Name: 
// Module Name: dreg_tb
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


module dreg_tb();
    reg [15:0] d;
    reg wr;
    reg clk;
    reg rst;
    wire [15:0] q;
    
    dreg #(16, "DUT") DUT(
        .d(d),
        .wr(wr),
        .clk(clk),
        .rst(rst),
        .q(q)
    );
    task tick;
        begin
            clk = 1;
            #5;
            clk = 0;
            #5;
        end
    endtask
    
    task reset;
        begin
            rst = 1;
            #5;
            rst = 0;
            #5;
        end
    endtask
    
    initial begin
        reset();
        d = 16'haaaa;
        tick();
        wr = 1;
        tick();
        $display("Got %h on q", q);
    end
    
endmodule

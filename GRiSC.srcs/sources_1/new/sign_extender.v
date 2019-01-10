`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2018 01:04:37 AM
// Design Name: 
// Module Name: sign_extender
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


module stender7(
        input [6:0]in,
        output [15:0]out
    );
    
    assign out = in[6] ? {9'b111111111, in} : {9'b000000000, in};
    
    always @(*) begin
        $display("Extender is %b", out);
    end
    
endmodule

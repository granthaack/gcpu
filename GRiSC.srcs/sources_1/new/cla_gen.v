// 16 Bit Carry Lookahead Adder
module cla_gen(
    //Sum propogated inputs
    input [15:0]P_in,
    //Carry inputs
    input [15:0]G_in,
    //Extra carry in bit
    input C_in,
    //All the carry out bits
    output[16:0]C_out
    );

    //Compute all 17 carry out bits in parallel
    assign C_out[0] = C_in;
    assign C_out[1] = G_in[0] | P_in[0] & C_out[0];
    assign C_out[2] = G_in[1] | P_in[1] & C_out[1];
    assign C_out[3] = G_in[2] | P_in[2] & C_out[2];
    assign C_out[4] = G_in[3] | P_in[3] & C_out[3];
    assign C_out[5] = G_in[4] | P_in[4] & C_out[4];
    assign C_out[6] = G_in[5] | P_in[5] & C_out[5];
    assign C_out[7] = G_in[6] | P_in[6] & C_out[6];
    assign C_out[8] = G_in[7] | P_in[7] & C_out[7];
    assign C_out[9] = G_in[8] | P_in[8] & C_out[8];
    assign C_out[10] = G_in[9] | P_in[9] & C_out[9];
    assign C_out[11] = G_in[10] | P_in[10] & C_out[10];
    assign C_out[12] = G_in[11] | P_in[11] & C_out[11];
    assign C_out[13] = G_in[12] | P_in[12] & C_out[12];
    assign C_out[14] = G_in[13] | P_in[13] & C_out[13];
    assign C_out[15] = G_in[14] | P_in[14] & C_out[14];
    assign C_out[16] = G_in[15] | P_in[15] & C_out[15];
    
endmodule

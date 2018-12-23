// 11 bit CLA adder
module cla_adder(
    //Inputs to perform addition on
    input [10:0]a,
    input [10:0]b,
    input c_in,

    //Carry out bit
    output c_out,
    //Sum out bits
    output [10:0] s
    );

    wire [10:0] P_w;
    wire [10:0] G_w;
    wire [11:0] C_w;

    //Instantiate the CLA generator to compute the carry bits
    cla_gen cla_g(.P_in(P_w), .G_in(G_w), .C_in(c_in), .C_out(C_w));

    //Instantiate the 11 half adders, one for each bit
    half_adder h0(.A_in(a[0]), .B_in(b[0]), .P_out(P_w[0]), .G_out(G_w[0]));
    half_adder h1(.A_in(a[1]), .B_in(b[1]), .P_out(P_w[1]), .G_out(G_w[1]));
    half_adder h2(.A_in(a[2]), .B_in(b[2]), .P_out(P_w[2]), .G_out(G_w[2]));
    half_adder h3(.A_in(a[3]), .B_in(b[3]), .P_out(P_w[3]), .G_out(G_w[3]));
    half_adder h4(.A_in(a[4]), .B_in(b[4]), .P_out(P_w[4]), .G_out(G_w[4]));
    half_adder h5(.A_in(a[5]), .B_in(b[5]), .P_out(P_w[5]), .G_out(G_w[5]));
    half_adder h6(.A_in(a[6]), .B_in(b[6]), .P_out(P_w[6]), .G_out(G_w[6]));
    half_adder h7(.A_in(a[7]), .B_in(b[7]), .P_out(P_w[7]), .G_out(G_w[7]));
    half_adder h8(.A_in(a[8]), .B_in(b[8]), .P_out(P_w[8]), .G_out(G_w[8]));
    half_adder h9(.A_in(a[9]), .B_in(b[9]), .P_out(P_w[9]), .G_out(G_w[9]));
    half_adder h10(.A_in(a[10]), .B_in(b[10]), .P_out(P_w[10]), .G_out(G_w[10]));

    //Assign the sum outputs to the outputs of the half adders and the carries
    assign s[0] = P_w[0] ^ C_w[0];
    assign s[1] = P_w[1] ^ C_w[1];
    assign s[2] = P_w[2] ^ C_w[2];
    assign s[3] = P_w[3] ^ C_w[3];
    assign s[4] = P_w[4] ^ C_w[4];
    assign s[5] = P_w[5] ^ C_w[5];
    assign s[6] = P_w[6] ^ C_w[6];
    assign s[7] = P_w[7] ^ C_w[7];
    assign s[8] = P_w[8] ^ C_w[8];
    assign s[9] = P_w[9] ^ C_w[9];
    assign s[10] = P_w[10] ^ C_w[10];
    assign c_out = C_w[11];

endmodule

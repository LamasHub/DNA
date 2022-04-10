/*------------------------------------------------------------------------------
 * File          : PE1.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module PE1(
	input logic CLK,
	input logic signed [0:6][0:11] Ix_in,
	input logic signed [0:6][0:11] Ixy_in,
	input logic signed [0:6][0:11] Ixz_in,
	input logic signed [0:6][0:11] Iy_in,
	input logic signed [0:6][0:11] Iyz_in,
	input logic signed [0:6][0:11] Iz_in,
	input logic signed [0:6][0:11] M_in,
	input logic signed [0:1] Score2AB,
	input logic signed [0:1] Score2AC,
	input logic signed [0:1] Score2BC,
	input logic signed [0:2] Score3ABC,
	
	output logic signed [0:11] Final_score,
	output logic signed [0:6][0:11] PE_OUT
);

logic signed [0:6][0:11] Delay1_out;
logic signed [0:6][0:11] Delay2_out;
logic signed [0:6][0:11] Delay3_out;
logic signed [0:6][0:11] Delay4_out;
logic signed [0:6][0:11] Delay5_out;
logic signed [0:6][0:11] Delay6_out;
logic signed [0:6][0:11] Delay7_out;

logic signed [0:11] M_out;
logic signed [0:11] Ix_out;
logic signed [0:11] Iy_out;
logic signed [0:11] Iz_out;
logic signed [0:11] Ixy_out;
logic signed [0:11] Iyz_out;
logic signed [0:11] Ixz_out;

logic signed [0:11] FF8_in;

logic signed [0:6][0:11] pe_out; // tmp PE_OUT
logic signed [0:11] final_score;


Delay Delay1(.clk(CLK),.a1(Iyz_in[0]),.b1(Iyz_in[1]),.c1(Iyz_in[2]),.d1(Iyz_in[3]),.e1(Iyz_in[4]),.f1(Iyz_in[5]),.g1(Iyz_in[6]),.a2(Delay1_out[0]),.b2(Delay1_out[1]),.c2(Delay1_out[2]),.d2(Delay1_out[3]),.e2(Delay1_out[4]),.f2(Delay1_out[5]),.g2(Delay1_out[6]));

Delay Delay2(.clk(CLK),.a1(M_in[0]),.b1(M_in[1]),.c1(M_in[2]),.d1(M_in[3]),.e1(M_in[4]),.f1(M_in[5]),.g1(M_in[6]),.a2(Delay2_out[0]),.b2(Delay2_out[1]),.c2(Delay2_out[2]),.d2(Delay2_out[3]),.e2(Delay2_out[4]),.f2(Delay2_out[5]),.g2(Delay2_out[6]));

Delay Delay3(.clk(CLK),.a1(Delay2_out[0]),.b1(Delay2_out[1]),.c1(Delay2_out[2]),.d1(Delay2_out[3]),.e1(Delay2_out[4]),.f1(Delay2_out[5]),.g1(Delay2_out[6]),.a2(Delay3_out[0]),.b2(Delay3_out[1]),.c2(Delay3_out[2]),.d2(Delay3_out[3]),.e2(Delay3_out[4]),.f2(Delay3_out[5]),.g2(Delay3_out[6]));

Delay Delay4(.clk(CLK),.a1(Ixy_in[0]),.b1(Ixy_in[1]),.c1(Ixy_in[2]),.d1(Ixy_in[3]),.e1(Ixy_in[4]),.f1(Ixy_in[5]),.g1(Ixy_in[6]),.a2(Delay4_out[0]),.b2(Delay4_out[1]),.c2(Delay4_out[2]),.d2(Delay4_out[3]),.e2(Delay4_out[4]),.f2(Delay4_out[5]),.g2(Delay4_out[6]));

Delay Delay5(.clk(CLK),.a1(Ixz_in[0]),.b1(Ixz_in[1]),.c1(Ixz_in[2]),.d1(Ixz_in[3]),.e1(Ixz_in[4]),.f1(Ixz_in[5]),.g1(Ixz_in[6]),.a2(Delay5_out[0]),.b2(Delay5_out[1]),.c2(Delay5_out[2]),.d2(Delay5_out[3]),.e2(Delay5_out[4]),.f2(Delay5_out[5]),.g2(Delay5_out[6]));


Ix Ix1(.Mjk(Ix_in[0]),.Ixy(Ix_in[1]),.Iyz(Ix_in[2]),.Ixz(Ix_in[3]),.Ix(Ix_in[4]),.Iy(Ix_in[5]),.Iz(Ix_in[6]),.Ix_out(Ix_out));

Iyz Iyz1(.Score2BC(Score2BC),.Mi(Delay1_out[0]),.Ixy(Delay1_out[1]),.Iyz(Delay1_out[2]),.Ixz(Delay1_out[3]),.Ix(Delay1_out[4]),.Iy(Delay1_out[5]),.Iz(Delay1_out[6]),.Iyz_out(Iyz_out));

M M1(.Score3ABC(Score3ABC),.M(Delay3_out[0]),.Ixy(Delay3_out[1]),.Iyz(Delay3_out[2]),.Ixz(Delay3_out[3]),.Ix(Delay3_out[4]),.Iy(Delay3_out[5]),.Iz(Delay3_out[6]),.M_out(M_out));

Iy Iy1(.Mik(Iy_in[0]),.Ixy(Iy_in[1]),.Iyz(Iy_in[2]),.Ixz(Iy_in[3]),.Ix(Iy_in[4]),.Iy(Iy_in[5]),.Iz(Iy_in[6]),.Iy_out(Iy_out));

Ixy Ixy1(.Score2AB(Score2AB),.Mk(Delay4_out[0]),.Ixy(Delay4_out[1]),.Iyz(Delay4_out[2]),.Ixz(Delay4_out[3]),.Ix(Delay4_out[4]),.Iy(Delay4_out[5]),.Iz(Delay4_out[6]),.Ixy_out(Ixy_out));

Iz Iz1(.Mij(Iz_in[0]),.Ixy(Iz_in[1]),.Iyz(Iz_in[2]),.Ixz(Iz_in[3]),.Ix(Iz_in[4]),.Iy(Iz_in[5]),.Iz(Iz_in[6]),.Iz_out(Iz_out));

Ixz Ixz1(.Score2AC(Score2AC),.Mj(Delay5_out[0]),.Ixy(Delay5_out[1]),.Iyz(Delay5_out[2]),.Ixz(Delay5_out[3]),.Ix(Delay5_out[4]),.Iy(Delay5_out[5]),.Iz(Delay5_out[6]),.Ixz_out(Ixz_out));

max7 max77(.a(M_out),.b(Ix_out),.c(Iy_out),.d(Iz_out),.e(Ixy_out),.f(Iyz_out),.g(Ixz_out),.maxout(FF8_in));

FF FF1(.clk(CLK),.D(Ix_out),.Q(PE_OUT[4]));
FF FF2(.clk(CLK),.D(Iyz_out),.Q(PE_OUT[2]));
FF FF3(.clk(CLK),.D(M_out),.Q(PE_OUT[0]));
FF FF4(.clk(CLK),.D(Iy_out),.Q(PE_OUT[5]));
FF FF5(.clk(CLK),.D(Ixy_out),.Q(PE_OUT[1]));
FF FF6(.clk(CLK),.D(Iz_out),.Q(PE_OUT[6]));
FF FF7(.clk(CLK),.D(Ixz_out),.Q(PE_OUT[3]));
FF FF8(.clk(CLK),.D(FF8_in),.Q(Final_score));


endmodule

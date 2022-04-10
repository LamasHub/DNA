/*------------------------------------------------------------------------------
 * File          : Ixz.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Ixz(
	input logic signed [0:1]Score2AC, //S(A_i,C_k)
	input logic signed [0:11]Mj,//M(i-1,j,k-1)
	
	input logic signed [0:11]Ixy,//Iyz(i-1,j,k-1)
	input logic signed [0:11]Iyz,//Iyz(i-1,j,k-1)
	input logic signed [0:11]Ixz,//Iyz(i-1,j,k-1)
	
	input logic signed [0:11]Ix,//Ix(i-1,j,k-1)
	input logic signed [0:11]Iy,//Iy(i-1,j,k-1)
	input logic signed [0:11]Iz,//Iz(i-1,j,k-1)
	
	output logic signed [0:11]Ixz_out
	
);
parameter G0 = 2;
parameter GE = 1;

logic signed [0:11] element1, element2, element3, element4, element5,element6,element7;

assign element1 = Mj-G0+Score2AC;
assign element2 = Ixy-G0+Score2AC;
assign element3 = Iyz-G0+Score2AC;
assign element4 = Ixz-GE+Score2AC;
assign element5 = Ix-GE+Score2AC;
assign element6 = Iy-G0+Score2AC;
assign element7 = Iz-GE+Score2AC;


max7 Ixz1(.a(element1),.b(element2),.c(element3),.d(element4),.e(element5),.f(element6),.g(element7),.maxout(Ixz_out));

endmodule
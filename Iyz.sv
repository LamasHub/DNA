/*------------------------------------------------------------------------------
 * File          : Iyz.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Iyz(
	input logic signed [0:1]Score2BC, //S(B_j,C_k)
	input logic signed [0:11]Mi,//M(i,j-1,k-1)
	
	input logic signed [0:11]Ixy,//Iyz(i,j-1,k-1)
	input logic signed [0:11]Iyz,//Iyz(i,j-1,k-1)
	input logic signed [0:11]Ixz,//Iyz(i,j-1,k-1)
	
	input logic signed [0:11]Ix,//Ix(i,j-1,k-1)
	input logic signed [0:11]Iy,//Iy(i,j-1,k-1)
	input logic signed [0:11]Iz,//Iz(i,j-1,k-1)
	
	output logic signed [0:11]Iyz_out
	
);
parameter G0 = 2;
parameter GE = 1;

logic signed [0:11] element1, element2, element3, element4, element5,element6,element7;

assign element1 = Mi-G0+Score2BC;
assign element2 = Ixy-G0+Score2BC;
assign element3 = Iyz-GE+Score2BC;
assign element4 = Ixz-G0+Score2BC;
assign element5 = Ix-G0+Score2BC;
assign element6 = Iy-GE+Score2BC;
assign element7 = Iz-GE+Score2BC;


max7 Iyz1(.a(element1),.b(element2),.c(element3),.d(element4),.e(element5),.f(element6),.g(element7),.maxout(Iyz_out));

endmodule
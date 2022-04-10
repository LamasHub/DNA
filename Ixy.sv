/*------------------------------------------------------------------------------
 * File          : Ixy.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Ixy(
	input logic signed [0:1]Score2AB, //S(A_i,B_j)
	input logic signed [0:11]Mk,//M(i-1,j-1,k)
	
	input logic signed [0:11]Ixy,//Iyz(i-1,j-1,k)
	input logic signed [0:11]Iyz,//Iyz(i-1,j-1,k)
	input logic signed [0:11]Ixz,//Iyz(i-1,j-1,k)
	
	input logic signed [0:11]Ix,//Ix(i-1,j-1,k)
	input logic signed [0:11]Iy,//Iy(i-1,j-1,k)
	input logic signed [0:11]Iz,//Iz(i-1,j-1,k)
	
	output logic signed [0:11]Ixy_out
	
);
parameter G0 = 2;
parameter GE = 1;

logic signed [0:11] element1, element2, element3, element4, element5,element6,element7;

assign element1 = Mk-G0+Score2AB;
assign element2 = Ixy-GE+Score2AB;
assign element3 = Iyz-G0+Score2AB;
assign element4 = Ixz-G0+Score2AB;
assign element5 = Ix-GE+Score2AB;
assign element6 = Iy-GE+Score2AB;
assign element7 = Iz-G0+Score2AB;


max7 Ixy1(.a(element1),.b(element2),.c(element3),.d(element4),.e(element5),.f(element6),.g(element7),.maxout(Ixy_out));

endmodule
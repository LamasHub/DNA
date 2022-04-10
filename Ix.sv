/*------------------------------------------------------------------------------
 * File          : Ix.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Ix(
	input logic signed [0:11]Mjk,//M(i-1,j,k)
	
	input logic signed [0:11]Ixy,//Iyz(i-1,j,k)
	input logic signed [0:11]Iyz,//Iyz(i-1,j,k)
	input logic signed [0:11]Ixz,//Iyz(i-1,j,k)
	
	input logic signed [0:11]Ix,//Ix(i-1,j,k)
	input logic signed [0:11]Iy,//Iy(i-1,j,k)
	input logic signed [0:11]Iz,//Iz(i-1,j,k)
	
	output logic signed [0:11]Ix_out
	
);
parameter G0 = 2;
parameter GE = 1;


logic signed [0:11] element1, element2, element3, element4, element5,element6,element7;

assign element1 = Mjk-2*G0;
assign element2 = Ixy-G0-GE;
assign element3 = Iyz-2*G0;
assign element4 = Ixz-G0-GE;
assign element5 = Ix-2*GE;
assign element6 = Iy-G0-GE;
assign element7 = Iz-G0-GE;


max7 Ix1(.a(element1),.b(element2),.c(element3),.d(element4),.e(element5),.f(element6),.g(element7),.maxout(Ix_out));

endmodule
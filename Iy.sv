/*------------------------------------------------------------------------------
 * File          : Iy.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Iy(
	input logic signed [0:11]Mik,//M(i,j-1,k)
	
	input logic signed [0:11]Ixy,//Iyz(i,j-1,k)
	input logic signed [0:11]Iyz,//Iyz(i,j-1,k)
	input logic signed [0:11]Ixz,//Iyz(i,j-1,k)
	
	input logic signed [0:11]Ix,//Ix(i,j-1,k)
	input logic signed [0:11]Iy,//Iy(i,j-1,k)
	input logic signed [0:11]Iz,//Iz(i,j-1,k)
	
	output logic signed [0:11]Iy_out
	
);
parameter G0 = 2;
parameter GE = 1;

logic signed [0:11] element1, element2, element3, element4, element5,element6,element7;

assign element1 = Mik-2*G0;
assign element2 = Ixy-G0-GE;
assign element3 = Iyz-G0-GE;
assign element4 = Ixz-2*G0;
assign element5 = Ix-G0-GE;
assign element6 = Iy-2*GE;
assign element7 = Iz-G0-GE;


max7 Iy1(.a(element1),.b(element2),.c(element3),.d(element4),.e(element5),.f(element6),.g(element7),.maxout(Iy_out));

endmodule
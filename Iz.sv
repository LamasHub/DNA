/*------------------------------------------------------------------------------
 * File          : Iz.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Iz(
	input logic signed [0:11]Mij,//M(i,j,k-1)
	
	input logic signed [0:11]Ixy,//Iyz(i,j,k-1)
	input logic signed [0:11]Iyz,//Iyz(i,j,k-1)
	input logic signed [0:11]Ixz,//Iyz(i,j,k-1)
	
	input logic signed [0:11]Ix,//Ix(i,j,k-1)
	input logic signed [0:11]Iy,//Iy(i,j,k-1)
	input logic signed [0:11]Iz,//Iz(i,j,k-1)
	
	output logic signed [0:11]Iz_out
	
);
parameter G0 = 2;
parameter GE = 1;

logic signed [0:11] element1, element2, element3, element4, element5,element6,element7;

assign element1 = Mij-2*G0;
assign element2 = Ixy-2*G0;
assign element3 = Iyz-G0-GE;
assign element4 = Ixz-G0-GE;
assign element5 = Ix-G0-GE;
assign element6 = Iy-G0-GE;
assign element7 = Iz-2*GE;


max7 Iz1(.a(element1),.b(element2),.c(element3),.d(element4),.e(element5),.f(element6),.g(element7),.maxout(Iz_out));

endmodule
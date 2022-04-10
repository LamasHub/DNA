/*------------------------------------------------------------------------------
 * File          : M.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module M(
	input logic signed [0:2]Score3ABC, //S(A_i,B_j,C_k)
	input logic signed [0:11]M,//M(i-1,j-1,k-1)
	
	input logic signed [0:11]Ixy,//Iyz(i-1,j-1,k-1)
	input logic signed [0:11]Iyz,//Iyz(i-1,j-1,k-1)
	input logic signed [0:11]Ixz,//Iyz(i-1,j-1,k-1)
	
	input logic signed [0:11]Ix,//Ix(i-1,j-1,k-1)
	input logic signed [0:11]Iy,//Iy(i-1,j-1,k-1)
	input logic signed [0:11]Iz,//Iz(i-1,j-1,k-1)
	
	output logic signed [0:11]M_out
	
);

logic signed [0:11] element1, element2, element3, element4, element5,element6,element7;

assign element1 = M+Score3ABC;
assign element2 = Ixy+Score3ABC;
assign element3 = Iyz+Score3ABC;
assign element4 = Ixz+Score3ABC;
assign element5 = Ix+Score3ABC;
assign element6 = Iy+Score3ABC;
assign element7 = Iz+Score3ABC;


max7 M1(.a(element1),.b(element2),.c(element3),.d(element4),.e(element5),.f(element6),.g(element7),.maxout(M_out));

endmodule
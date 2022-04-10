/*------------------------------------------------------------------------------
 * File          : Create.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Feb 27, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module Create #(parameter LEN = 7)

(
	input logic reset,
	input string a, b, c,
	output logic [0:LEN][0:1]A,[0:LEN][0:1]B, [0:LEN][0:1]C,
	output logic flag
);
//uncomment when debugging
/*
string a= "ATCGCGA";
string b= "ATCCCAA";
string c= "AATCCGA";
*/
logic [0:LEN][0:1]A2,B2,C2;

always_comb begin
if (reset == 1)
flag = 1;

else begin
flag = 0;
	if (reset != 1) begin
		for(int i = 0; i <= LEN; i++) begin
			if(a.getc(i)== "A") A2[i]=2'b00;
			else if(a.getc(i)=="T") A2[i]=2'b01;
			else if(a.getc(i)=="G") A2[i]=2'b10;
			else if(a.getc(i)=="C") A2[i]=2'b11;
			else A2[i]=2'b00;

			if(b.getc(i)=="A") B2[i]=2'b00;
			else if(b.getc(i)=="T") B2[i]=2'b01;
			else if(b.getc(i)=="G") B2[i]=2'b10;
			else if(b.getc(i)=="C") B2[i]=2'b11;
			else B2[i]=2'b00;

			if(c.getc(i)=="A") C2[i]=2'b00;
			else if(c.getc(i)=="T") C2[i]=2'b01;
			else if(c.getc(i)=="G") C2[i]=2'b10;
			else if(c.getc(i)=="C") C2[i]=2'b11;
			else C2[i]=2'b00;
		end
	flag = 1;
	end
end
end
assign A = A2;
assign B = B2;
assign C = C2;
endmodule
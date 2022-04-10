/*------------------------------------------------------------------------------
 * File          : Master.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Feb 28, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module Master #(parameter LEN = 7)
(
	  
	input logic CLK,
	input logic rst,
           
	input string A,
	input string B,
	input string C,

	output logic signed  [0:3*LEN][0:2] CommandsB,
	output logic signed  [0:3*LEN][0:2]CommandsC
);

           
logic flagc, flagi, flagt, flagv;
logic rstc, rsti, rstt, rstv;
logic [0:LEN][0:1]codedA, codedB, codedC;
logic signed [0:LEN][0:LEN][0:LEN][0:11]cube;
//logic [0:3*LEN][0:2] commandsB, commandsC;

//sim
//string A = "AAAAAAAT", B = "AAAAAAAC", C = "AAAAAAAG";
//string A = "CTCAGTAT", B = "CGTCATTA", C = "CCCTGGTC";
//string A = "AGTCGGTA", B = "ACGTAGGT", C = "CTAGAACT";


FSM fsm(.clk(CLK),.reset(rst),.fcreate(flagc),.finitialize(flagi),.ftraceback(flagt),.fverdict(flagv),
		.Create(rstc),.Initialize(rsti),.Traceback(rstt),.Verdict(rstv));

Create create(.reset(rstc),.a(A),.b(B),.c(C),.A(codedA),.B(codedB),.C(codedC),.flag(flagc));

Initialize Initialize1(.reset(rsti),.clk(CLK),.A(codedA),.B(codedB),.C(codedC),.cube_out(cube),.flag(flagi));

Traceback1 Traceback(.reset(rstt),.clk(CLK),.cube(cube),.CommandsB(CommandsB),
			.CommandsC(CommandsC),.flag(flagt));

verdict Verdict(.reset(rstv),.CommandsB(CommandsB),.CommandsC(CommandsC),.flag(flagv));

endmodule
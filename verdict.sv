
/*------------------------------------------------------------------------------
 * File          : verdict.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Feb 27, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module verdict #(parameter LEN = 7)

(	
	input logic reset,
	//uncomment when not debugging
	input logic [0:3*LEN][0:2] CommandsB,CommandsC,
	output logic flag
);
//comment when not debugging
//logic [0:3*LEN][0:2] CommandsB = {0,1,2,0,0,3,2,1,3,4},CommandsC = {0,1,2,2,2,1,2,1,6,0};

always_comb begin
if(reset == 1)
flag = 1;

else begin

flag = 0;
$display("To get an aligned sequences, please do the following operations to each of the sequences:");
$display("Sequence B:");

for(int i = 0; i <= 3*LEN; i++) begin
	if((CommandsB[i])== 3'b000)
		$display("DELETE");

		else if(CommandsB[i]== 3'b001)
		$display("INSERT");
			else if(CommandsB[i]== 3'b010)
			$display("KEEP");
				else if(CommandsB[i]== 3'b011)
				$display("DO NOTHING");
						else
						$display("THIS OPERATION IS NOT DEFINED");
end

$display("Sequence C:");

for(int i = 0; i <= 3*LEN; i++) begin
	if((CommandsC[i])== 3'b000)
		$display("DELETE");

		else if(CommandsC[i]== 3'b001)
		$display("INSERT");
			else if(CommandsC[i]== 3'b010)
			$display("KEEP");
				else if(CommandsC[i]== 3'b011)
				$display("DO NOTHING");
						else
						$display("THIS OPERATION IS NOT DEFINED");
end
flag = 1;
end
end
endmodule
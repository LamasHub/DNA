/*------------------------------------------------------------------------------
 * File          : FF.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module FF(

	input clk,
	input logic signed [0:11] D,
	
	output logic signed [0:11] Q
);

always_ff @(posedge clk) begin

		Q <= D;
end

endmodule
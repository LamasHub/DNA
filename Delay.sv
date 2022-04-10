/*------------------------------------------------------------------------------
 * File          : Delay.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Delay (
	
	input clk,
	input logic signed [0:11] a1,b1,c1,d1,e1,f1,g1,
	
	output logic signed [0:11] a2,b2,c2,d2,e2,f2,g2
	
);

logic counter=1'b0;
always_ff @(posedge clk) begin
counter<=counter+1;
if(counter==1)begin
a2 <= a1;
b2 <= b1;
c2 <= c1;
d2 <= d1;
e2 <= e1;
f2 <= f1;
g2 <= g1;
end

end
endmodule
	
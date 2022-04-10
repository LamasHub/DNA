/*------------------------------------------------------------------------------
 * File          : max7.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module max7(
	input logic signed [0:11] a,b,c,d,e,f,g,
	
	output logic signed [0:11] maxout 
);



logic signed [0:11] max1, max2, max3, max4, max5;



assign max1 = (signed'(a) > signed'(b)) ? signed'(a) : signed'(b);
assign max2 = (signed'(c) > signed'(d)) ? signed'(c) : signed'(d);
assign max3 = (signed'(e) > signed'(f)) ? signed'(e) : signed'(f);
assign max4 = (signed'(max1) > signed'(max2)) ? signed'(max1) : signed'(max2);
assign max5 = (signed'(max3) > signed'(g)) ? signed'(max3) : signed'(g);

assign maxout = (signed'(max4) > signed'(max5)) ? signed'(max4): signed'(max5);

endmodule
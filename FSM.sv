/*------------------------------------------------------------------------------
 * File          : FSM.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Feb 27, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module FSM #()
(
input logic clk,
input logic reset,

input logic fcreate,
input logic finitialize,
input logic ftraceback,
input logic fverdict,
	
output logic Create,	  
output logic Initialize, 
output logic Traceback,
output logic Verdict
);

// state machine and parameters decleration 

enum logic [2:0] {screate, sinitialize, straceback, sverdict} pres_st, next_st; // state machine

logic create = 0;  
logic initialize = 1;
logic traceback = 1;
logic verdict = 1;

//--------------------------------------------------------------------------------------------
//  1.  syncronous code,  executed once every clock to update the current state 

always_ff @(posedge clk or posedge reset) // State machine logic ////
begin

if ( reset ) begin // initialize the state machine 
pres_st <= screate;
end

else begin 			// Synchronic logic of the state machine; once every clock 
pres_st <= next_st;  // present state <= next state
end 
end // always_ff state machine ///////////////////////////////


//--------------------------------------------------------------------------------------------
//  2.  asynchornous code : logic defining what is the next state 	

always_comb begin// Update the next state  /////////////////////////

// 0. Set default operation values
//if the current state has not finished working, stay there
if (
(pres_st == screate) && (fcreate == 0) ||
(pres_st == sinitialize) && (finitialize == 0) ||
(pres_st == straceback) && (ftraceback == 0) ||
(pres_st == sverdict) && (fverdict == 0)
) 

next_st = pres_st;	

else begin  // if the current state finished, go to the next one 

case (pres_st)

	screate: begin
		if(fcreate == 1) begin
			next_st = sinitialize;  //next state
			initialize = 0;
			traceback = 1;
			verdict = 1;
			create = 1;
		end
		
		
	end
		
	sinitialize: begin
		if(finitialize == 1) begin
			next_st = straceback;  //next state
			traceback = 0;
			verdict = 1;
			create = 1;
			initialize = 1;
		end
		
	end 
		
	straceback: begin
		if(ftraceback == 1) begin
			next_st = sverdict;  //next state
			verdict = 0;
			create = 1;
			initialize = 1;
			traceback = 1;
		end

	end 
		
	sverdict: begin
		if(fverdict == 1)begin
			next_st = screate;
			verdict = 1;
			create = 1;
			initialize = 1;
			traceback = 1;
		end
		 // 			
	end 

endcase
end // else

end // always next state ///////////////////////////////

assign Create = create;	  
assign Initialize = initialize; 
assign Traceback = traceback;
assign Verdict = verdict;

endmodule
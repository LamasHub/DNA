/*------------------------------------------------------------------------------
 * File          : Traceback1.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Nov 7, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module Traceback1 #(parameter LEN=7)
(
input logic  reset,clk,

input logic signed [0:LEN][0:LEN][0:LEN][0:11] cube,

output logic [0:3*LEN][0:2] CommandsB, CommandsC,
output logic flag
);



logic [0:3*LEN][0:2] arrows;
int i = LEN , j = LEN , k = LEN , m = 0, counter = 0;
logic signed [0:4] max1, max2, max3, max4, max5, maxout;
//logic signed [0:LEN][0:LEN][0:LEN][0:4] cube= '{'{'{-10,-10,-10,-10},'{-10,-10,-10,-10},'{-10,-10,-10,-10},'{-10,-10,-10,-10}}, '{'{-10,-10,-10,-10},'{-10,0,-2,-4},'{-10,-2,-2,-2},'{-10,-4,-4,-2}}, '{'{-10,-10,-10,-10},'{-10,-2,-2,-4},'{-10,-4,-3,-3},'{-10,-4,-5,-3}},'{'{-10,-10,-10,-10},'{-10,-4,-2,-4},'{-10,-4,-3,-3},'{-10,-4,-3,-4}}};

//logic [0:LEN][0:2] seqA = '{0,1,1,2};
//logic [0:LEN][0:2] seqB = '{ 0,3,1,2};
//logic [0:LEN][0:2] seqC = '{0,0,3,1};


///uncomment when debugging
/*
logic signed [0:LEN][0:LEN][0:LEN][0:4] cube= '{'{'{-10,-10,-10,-10,-10,-10,-10},'{-10,-10,-10,-10,-10,-10,-10},'{-10,-10,-10,-10,-10,-10,-10},'{-10,-10,-10,-10,-10,-10,-10},'{-10,-10,-10,-10,-10,-10,-10},'{-10,-10,-10,-10,-10,-10,-10},'{-10,-10,-10,-10,-10,-10,-10}}, 
'{'{-10,-10,-10,-10,-10,-10,-10},'{-10,0,-2,-4,-6,-8,-10},'{-10,-2,-2,-2,-5,-6,-9},'{-10,-4,-4,-4,-2,-5,-7},'{-10,-6,-6,-4,-5,-2,-5},'{-10,-8,-6,-7,-6,-5,-2},'{-10,-10,-8,-8,-9,-7,-5}}, 
'{'{-10,-10,-10,-10,-10,-10,-10},'{-10,-2,0,-3,-5,-7,-8},'{-10,-2,-1,-1,-4,-5,-7},'{-10,-4,-3,-4,-1,-4,-5},'{-10,-6,-5,-4,-4,-1,-3},'{-10,-6,-3,-5,-5,-3,1}, '{-10,-8,-5,-6,-7,-5,-2}},
'{'{-10,-10,-10,-10,-10,-10,-10}, '{-10,-4 , -3, -2, -5, -7 ,-9},'{ -10,-4,-3, -1 ,-4 ,-5 , -8},'{-10, -4,-4 ,-4, -2 , -4 ,-6},'{-10,  -6,-6   ,-4, -4 ,-2 ,-4},'{ -10 ,-8 ,-7 , -6,-6,-4 ,-2},'{-10,-8 ,-6 ,-6 ,-7, -5,-2} },
'{'{-10 ,-10 ,-10 ,-10, -10, -10 ,-10 },'{-10, -6,-5,-3,-4,-5,-8},'{ -10,-4,-3,0,-3,-2,-6},'{-10 , -6 ,-5,-4, -1,-3 ,-5},'{-10,-4,-4,-1, -3,1, -3},'{ -10,-7,-5, -5,-4,-3,0},'{-10, -9 , -7,-7 ,-7,-5,-3}},
'{'{-10, -10 ,-10 ,-10 ,-10 ,-10 ,-10}, '{ -10,-8,-7 ,-6 ,-5, -6,-7},'{ -10, -7 , -6, -4,-3, -5,-5},'{ -10,-6, -5 ,-3,-1 ,-4, -5},'{ -10, -7, -7,-5, -4, -2,-2},'{-10, -6, -5 , -4, -4, -2, 0},'{ -10,-9,-7,-7,-7,-5, -3}}, 
'{'{ -10 ,-10 ,-10, -10, -10, -10 ,-10 },'{-10 , -10,-9,-8,-8,-7,-8},'{ -10,-9,-8 ,-6,-6,-5,-8},'{-10,-9,-8,-6 ,-5,-4,-6},'{ -10,-8,-7 ,-5,-4,-2,-5},'{ -10,-9,-8,-7 , -6,-5,-3},'{ -10,-8 ,-7,-6,-7,-4,-3}}};

logic [0:LEN][0:2] seqA = '{ 1, 1, 2, 1, 0, 0, 3};
logic [0:LEN][0:2] seqB = '{ 0, 0, 1, 2, 1, 0, 0};
logic [0:LEN][0:2] seqC = '{ 0, 0, 3, 1, 3, 3, 0};
*/
//commands key
logic [0:2]
Delete = 3'b000, // delete letter
Insert = 3'b001, // insert gap
Keep = 3'b010,   // match
Nothing=3'b011;  // do nothing

// not relevant anymore
/*ReplaceWithA = 3'b100,
ReplaceWithT = 3'b101,
ReplaceWithC = 3'b110,
ReplaceWithG = 3'b111;*/


always_ff @(posedge clk) begin
	if(reset == 1) begin
		i<=LEN;
		j<=LEN;
		k<=LEN;
		m<=0;
		flag=1;
		counter=0;

	end
	else begin
	if(counter == 0)
	flag = 0;
	counter++;
		if((i!=0) && (j!=0) && (k!=0))begin 
			m<=m+1;

			//draw path
			if(arrows[m][0]==1'b1) i<=i-1;

			if(arrows[m][1]==1'b1) j<=j-1;
	
			if(arrows[m][2]==1'b1) k<=k-1;			
		end
	end
	if(counter == LEN)
		flag = 1;
end

always_comb begin

max1 = (signed'(cube [i-1][j-1][k-1]) > signed'(cube [i][j-1][k-1])) ? signed'(cube [i-1][j-1][k-1]) : signed'(cube [i][j-1][k-1]);
max2 = (signed'(cube [i-1][j][k-1]) > signed'(cube [i-1][j-1][k])) ? signed'(cube [i-1][j][k-1]) : signed'(cube [i-1][j-1][k]);
max3 = signed'((cube [i-1][j][k]) > signed'(cube [i][j-1][k])) ? signed'(cube [i-1][j][k]) : signed'(cube [i][j-1][k]);
max4 = (signed'(max1) > signed'(max2)) ? signed'(max1) : signed'(max2);
max5 = (signed'(max3) > signed'(cube [i][j][k-1])) ? signed'(max3) : signed'(cube [i][j][k-1]);
maxout = (signed'(max4) > signed'(max5)) ? signed'(max4): signed'(max5);

/*

if ((seqA[i] == seqB[j]) && (seqB[j] == seqC[k])) begin	

	arrows[m] = 3'b111;
	CommandsB[m] = Keep;
	CommandsC[m] = Keep;

end


else if (seqA[i] == seqB[j]) begin

	CommandsB[m] = Keep;

	if (signed'(cube[i-1][j-1][k]) > signed'(cube [i-1][j-1][k-1])) begin

		arrows[m] = 3'b110;
		CommandsC[m] = Insert;

	end


	else begin 

		arrows[m] = 3'b111;
		CommandsC[m]=Nothing;

	end

end

else if (seqA[i] == seqC[k]) begin

	CommandsC[m] = Keep;
	if (signed'(cube[i-1][j][k-1]) > signed'(cube [i-1][j-1][k-1])) begin

		arrows[m] = 3'b101;
		CommandsB[m] = Insert;

	end

	else begin


		arrows[m] = 3'b111;
		CommandsB[m]=Nothing;

	end

end


else if (seqB[j] == seqC[k]) begin

	if (signed'(cube[i][j-1][k-1]) > signed'(cube [i-1][j-1][k-1])) begin 


		arrows[m] = 3'b011;
		CommandsB[m] = Delete;
		CommandsC[m] = Delete;			


	end

	else begin

		arrows[m] = 3'b111;
		CommandsB[m]=Nothing;
		CommandsC[m]=Nothing;

	end
end


else begin
*/
	if (maxout == cube [i-1][j-1][k-1]) begin
		arrows[m] = 3'b111;
		CommandsB[m]=Nothing;
		CommandsC[m]=Nothing;			

	end

	else if (maxout == cube [i][j-1][k-1]) begin 
		arrows[m] = 3'b011;
		CommandsB[m]= Delete;
		CommandsC[m]= Delete;	
	end

	else if (maxout == cube [i-1][j][k-1]) begin 
		arrows[m] = 3'b101;
		CommandsB[m]= Insert;
		CommandsC[m]=Nothing;				

	end

	else if (maxout == cube [i-1][j-1][k]) begin 
		arrows[m] = 3'b110;
		CommandsB[m]=Nothing;
		CommandsC[m]= Insert;	

	end

	else if (maxout == cube [i][j][k-1]) begin 
		arrows[m] = 3'b001;
		CommandsB[m]= Nothing;
		CommandsC[m]= Delete;			
	end

	else if (maxout == cube [i][j-1][k]) begin 
		arrows[m] = 3'b010;
		CommandsB[m]= Delete;
		CommandsC[m]= Nothing;			
	end

	else if(maxout == cube [i-1][j][k]) begin 
		arrows[m] = 3'b100;
		CommandsB[m]= Insert;
		CommandsC[m]= Insert;			
	end

	else begin
		arrows[m] = 3'b000;
		CommandsB[m]= Nothing;	
		CommandsC[m]= Nothing;	
	end

//end
			
end
endmodule
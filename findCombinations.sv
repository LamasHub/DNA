/*------------------------------------------------------------------------------
 * File          : findCombinations.sv
 * Project       : RTL
 * Author        : eplhec
 * Creation date : Oct 22, 2021
 * Description   :
 *------------------------------------------------------------------------------*/

module findCombinations #(
		parameter INF = 38,
		parameter UNVISITED = -1,
		parameter maxIndex = 7
)

(
	input int sum,
	output int allcombinations [0:INF][0:2], numOcombs
);


function int findcombinations
	(input int sum, numOcombs, ref int Allcombinations [0:INF][0:2]);
	
for (int m = 0 ; m <= INF ; m++) begin
		for (int i = 1 ; i <= maxIndex ; i++) begin
		
			for (int j = 1 ; j <= maxIndex ; j++) begin
				
				Allcombinations [m][0] = i;
				Allcombinations [m][1] = j;
				Allcombinations [m][2] = sum - (Allcombinations [m][0] + Allcombinations [m][1]);

				if ((Allcombinations [m][2] <= maxIndex) && (Allcombinations [m][2] > 0))
				m++;
				
				if ((Allcombinations [m][0] == maxIndex) && (Allcombinations [m][1] == maxIndex))begin
		
			if(Allcombinations [m][2] <=0) begin
			
			Allcombinations [m][0] = UNVISITED;
			Allcombinations [m][1] = UNVISITED;
			Allcombinations [m][2] = UNVISITED;
			
			numOcombs = m;
			
			return numOcombs; 
			end
			
			else begin
				numOcombs = m+1;
				return numOcombs; 
			end
		end
				
			end
			
		
end
numOcombs = m;
return numOcombs;
end
endfunction


int Allcombinations [0:INF][0:2];
int counter = 0;

always_comb begin
if (counter == 0) begin		
	for (int m = 0 ; m <= INF ; m++) begin
		
		Allcombinations [m][0] = UNVISITED;
		Allcombinations [m][1] = UNVISITED;
		Allcombinations [m][2] = UNVISITED;
	end
counter = 1;
end

numOcombs = findcombinations(sum, 0, Allcombinations);
end

assign allcombinations = Allcombinations;

endmodule

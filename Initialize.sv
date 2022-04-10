module Initialize #(

	parameter INF = 38,
	parameter MAXSUM = 21,
	parameter MAXPES = 38,
	parameter LEN = 7)

(
	input logic reset,
	input logic clk,
	
//UNCOMMENT WHEN NOT DEBUGGING/////
	input logic [0:LEN][0:1]A,
	input logic [0:LEN][0:1]B,
	input logic [0:LEN][0:1]C,
	/////////////////////////
	output logic signed [0:LEN][0:LEN][0:LEN][0:11]cube_out,
	output logic flag
);

logic signed [0:LEN][0:LEN][0:LEN][0:11]cube_in='{default:-50};

logic signed [0:MAXPES][0:6][0:6][0:11] inputs = '{default:-50};//pe's num; vars(M,IXY,IYZ,IXZ,IX,IY,IZ); var's value
logic signed [0:MAXPES][0:6][0:11] outputs;

logic signed [0:2] Score3ABC [0:MAXPES]= '{default:0};
logic signed [0:1] Score2AB [0:MAXPES]= '{default:0};
logic signed [0:1] Score2BC [0:MAXPES]= '{default:0};
logic signed [0:1] Score2AC [0:MAXPES]= '{default:0};

logic signed [0:MAXPES][0:11] finalScore;

int Allcombinations [0:MAXSUM][0:INF][0:2];
int numOcombs[0:MAXSUM];
int sum = 2;
int neighbors [0:6];
int i,j,k;
int counter =0;
int PEcnt = 0;

/*
//DEBUG
logic [0:LEN][0:1]A;
logic [0:LEN][0:1]B;
logic [0:LEN][0:1]C;
initial begin

A[0]=1;
A[1]=0;
A[2]=1;
A[3]=1;
A[4]=1;
A[5]=0;
A[6]=1;
A[7]=1;

B[0]=1;
B[1]=0;
B[2]=3;
B[3]=1;
B[4]=1;
B[5]=0;
B[6]=3;
B[7]=1;

C[0]=1;
C[1]=3;
C[2]=1;
C[3]=0;
C[4]=1;
C[5]=3;
C[6]=1;
C[7]=0;

end
*/

//create all possible combinations for each sum
genvar s;
generate
for(s = 3; s <= MAXSUM; s++) begin :combs
	findCombinations combs(.sum(s),.allcombinations(Allcombinations[s]),.numOcombs(numOcombs[s]));
end :combs
endgenerate

//generate PEs with generate loop
genvar p;
generate
	for(p = 0; p <= MAXPES; p++) begin :PES
		PE1 p_PEinst(.CLK(clk),.M_in(inputs[p][0]),.Ixy_in(inputs[p][1]),.Iyz_in(inputs[p][2]),.Ixz_in(inputs[p][3]),.Ix_in(inputs[p][4]),.Iy_in(inputs[p][5]),.Iz_in(inputs[p][6]),.Score3ABC(Score3ABC[p]),.Score2AB(Score2AB[p]),.Score2BC(Score2BC[p]),.Score2AC(Score2AC[p]),.PE_OUT(outputs[p]),.Final_score(finalScore[p]));
	end :PES
endgenerate

always_ff @(posedge clk) begin
if (reset == 1)
	flag = 0;
	
else begin
flag = 0;
PEcnt++;
	if(PEcnt >=5 )
	sum = sum + 1;
	if(sum == MAXSUM)
	flag=1;

end
end
always_comb begin

if(sum ==2) begin

cube_out = cube_in;
inputs[0] = {0};

end

else begin
for(int m = 0; m < numOcombs[sum]; m++) begin

	i = Allcombinations[sum][m][0];
	j = Allcombinations[sum][m][1];
	k = Allcombinations[sum][m][2];
	
	counter = 0;
	neighbors = {-1,-1,-1,-1,-1,-1,-1};
	findneighbors(i, j, k, Allcombinations,counter,neighbors); //find PEs of neighbors	

	//update inputs AND SCORES
	if(neighbors[0] != -1) begin
	
		inputs[neighbors[0]][4] = outputs[m];
		
		Scores(A[i+1],B[j],C[k],Score2AB[neighbors[0]],Score2AC[neighbors[0]], Score2BC[neighbors[0]],Score3ABC[neighbors[0]]);
		
	end
	else
		inputs[neighbors[0]][4] = -50;
		
	if(neighbors[1] != -1) begin
	
		inputs[neighbors[1]][5] = outputs[m];
		
		Scores(A[i],B[j+1],C[k],Score2AB[neighbors[1]],Score2AC[neighbors[1]], Score2BC[neighbors[1]],Score3ABC[neighbors[1]]);	
		
	end
	else
		inputs[neighbors[1]][5] = -50;
	
	if(neighbors[2] != -1) begin
	
		inputs[neighbors[2]][6] = outputs[m];
		Scores(A[i],B[j],C[k+1],Score2AB[neighbors[2]],Score2AC[neighbors[2]], Score2BC[neighbors[2]],Score3ABC[neighbors[2]]);
		
	end
	else
		inputs[neighbors[2]][6] = -50;
		
	if(neighbors[3] != -1) begin
	
		inputs[neighbors[3]][1] = outputs[m];
		Scores(A[i+1],B[j+1],C[k],Score2AB[neighbors[3]],Score2AC[neighbors[3]], Score2BC[neighbors[3]],Score3ABC[neighbors[3]]);
		
	end	
	else
		inputs[neighbors[3]][1] = -50;
	
	if(neighbors[4] != -1) begin
	
		inputs[neighbors[4]][3] = outputs[m];
		Scores(A[i+1],B[j],C[k+1],Score2AB[neighbors[4]],Score2AC[neighbors[4]], Score2BC[neighbors[4]],Score3ABC[neighbors[4]]);
	end
	else
		inputs[neighbors[4]][3] = -50;
		
	if(neighbors[5] != -1) begin
	
		inputs[neighbors[5]][2] = outputs[m];
		Scores(A[i],B[j+1],C[k+1],Score2AB[neighbors[5]],Score2AC[neighbors[5]], Score2BC[neighbors[5]],Score3ABC[neighbors[5]]);
		
	end
	else
		inputs[neighbors[5]][2] = -50;
	
	if(neighbors[6] != -1) begin
	
		inputs[neighbors[6]][0] = outputs[m];
		Scores(A[i+1],B[j+1],C[k+1],Score2AB[neighbors[6]],Score2AC[neighbors[6]], Score2BC[neighbors[6]],Score3ABC[neighbors[6]]);
		
	end
	else
		inputs[neighbors[6]][0] = -50;

//update cube
cube_out[i][j][k] = finalScore[m];
end
end
end

function void findneighbors(input int i, j, k, Allcombinations [0:MAXSUM][0:INF][0:2],
ref int counter,ref int neighbors [0:6]);

int sum; 
sum = i + j + k;

for (int m = 0 ; (m <= INF) ; m++) begin
	if (counter<7) begin
	//i+1,j,k
	if ((Allcombinations [sum+1][m][0] == i+1)
		&& (Allcombinations [sum+1][m][1] == j) 
		&& (Allcombinations [sum+1][m][2] == k)) begin
		
		neighbors [0] = m;
		counter++;
end
	
	//i,j+1,k	
	if ((Allcombinations [sum+1][m][0] == i) 
		&& (Allcombinations [sum+1][m][1] == j+1) 
		&& (Allcombinations [sum+1][m][2] == k)) begin
		
		neighbors [1] = m;
		counter++;

	end
	
	//i,j,k+1
	if ((Allcombinations [sum+1][m][0] == i) 
		&& (Allcombinations [sum+1][m][1] == j) 
		&& (Allcombinations [sum+1][m][2] == k+1)) begin
		
		neighbors [2] = m;
		counter++;

	end
	
	//i+1,j+1,k
	if ((Allcombinations [sum+2][m][0] == i+1) 
		&& (Allcombinations [sum+2][m][1] == j+1) 
		&& (Allcombinations [sum+2][m][2] == k)) begin
		
		neighbors [3] = m;
		counter++;
	end
	
	//i+1,j,k+1
	if ((Allcombinations [sum+2][m][0] == i+1) 
		&& (Allcombinations [sum+2][m][1] == j) 
		&& (Allcombinations [sum+2][m][2] == k+1)) begin
		
		neighbors [4] = m;
		counter++;
	end
	
	//i,j+1,k+1
	if ((Allcombinations [sum+2][m][0] == i) 
		&& (Allcombinations [sum+2][m][1] == j+1) 
		&& (Allcombinations [sum+2][m][2] == k+1)) begin
		
		neighbors [5] = m;
		counter++;
	end
	
	//i+1,j+1,k+1
	if ((Allcombinations [sum+3][m][0] == i+1) 
		&& (Allcombinations [sum+3][m][1] == j+1) 
		&& (Allcombinations [sum+3][m][2] == k+1)) begin
		
		neighbors [6] = m;
		counter++;
	end
	
end
end
endfunction

function void Scores(

		input logic signed [0:1]A,//alpha = Ai
		input logic signed [0:1]B,//beta = Bj
		input logic signed [0:1]C,//gamma = Ck
		
			
		ref logic signed [0:1]Score2AB,//S(alpha,beta)
		ref logic signed [0:1]Score2AC,//S(alpha,gamma)
		ref logic signed [0:1]Score2BC,//S(beta,gamma)
		ref logic signed [0:2]Score3ABC//S(alpha,beta,gamma)

);

parameter logic signed [0:1] MATCH = 1;
parameter logic signed [0:1] MISMATCH = -1;


	if (A == B) 
		Score2AB = MATCH;
		
		else
		Score2AB = MISMATCH;
	
	
	if (A == C) 
		Score2AC = MATCH;
		
		else
		Score2AC = MISMATCH;
	
	
	if (B == C) 
		Score2BC = MATCH;
		
		else
		Score2BC = MISMATCH;
	

Score3ABC = Score2AB + Score2AC + Score2BC;

endfunction

endmodule

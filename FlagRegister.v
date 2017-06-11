module flagRegister(output reg[3:0] Q, input[3:0] D, input ENABLE,CLK);

	reg reset=1'b1;

	always @ (posedge CLK)
	if(reset)
	begin
		/*Q[3]<=1'b0;		//output initialization
		Q[2]<=1'b0;		//output initialization
		Q[1]<=1'b0;		//output initialization
		Q[0]<=1'b0;		//output initialization*/
		Q<=4'b0;
		reset <= 1'b0; 	//turn off reset state
	end
	else
	begin

		if(ENABLE)
		begin
			Q<=D;
	/*	Q[3]<=Z;		//output initialization
		Q[2]<=C;		//output initialization
		Q[1]<=N;		//output initialization
		Q[0]<=V;		//output initialization*/
	    end
	else
	Q <= Q;

end

endmodule // D_Latch4bits
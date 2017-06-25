module flagRegister(output reg[3:0] Q, input[3:0] D, input ENABLE,CLK,RESET);

	//reg reset=1'b1;

	always @ (posedge CLK, RESET)
	
	if(RESET)
		Q <= 4'd0;
	else
		begin
			if(ENABLE)
				Q<=D;
			else
				Q<=Q;
		end

endmodule // D_Latch4bits
module registerFile_Tester;

	
	reg[31:0] PC;
	reg CLK,ENABLE,RESET;
	reg[3:0] A,B,C;
	wire[31:0] PA,PB;

	registerFile registerF(PA,PB,PC,CLK,ENABLE,A,B,C,RESET);


	// initial
	// 	begin
	// 		RESET = 0;
	// 		PC = 32'd1;
	// 		CLK = 0;
	// 		ENABLE = 1;
			
	// 		C = 4'd0;
	// 		A = 4'b1111;
	// 		B = 4'b0000;

	// 		repeat(15)#10 begin

	// 			C = C + 4'd1;
	// 				repeat(1) PC = PC +32'd4;
	// 			A = A - 4'd1;
	// 			B = B + 4'd1;
	// 			end	
				
	// 	end


	initial
	begin

		RESET = 0;
		PC = 32'd4;
		C = 0;
		ENABLE = 1;
		A = 4'd0;
		B = 4'd0;
		CLK = 0;

		repeat(15)#10 begin
			PC = PC + 32'd2;
			C = C + 1;

			A = A + 4'd1;
			B = B + 4'd2;
		end

	end




	initial
		begin
			$display(" CLK    EN      C 	  A 	  B 		PA           PB        PC ");
			$monitor(" %b 	 %b    %b        %b     %b        %h      %h    %h ",CLK,ENABLE,C,A,B,PA,PB,PC);

		end	

		always #5 CLK = ~CLK;
		//always #10 ENABLE = ~ENABLE;
		initial #200 $finish;

endmodule // registerFile_Tester
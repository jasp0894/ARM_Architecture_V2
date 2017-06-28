module CondTester (output reg OUT, input [3:0] COND, input C,Z,V,N);

    
	always @ (COND,Z,C,N,V)


	case(COND)
		
		4'b0000: 
		begin
			if(!Z) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b0001: 
		begin
			if(Z) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b0010: 
		begin
			if(!C) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b0011: 
		begin
			if(C) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b0100: 
		begin
			if(!N) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b0101: 
		begin
			if(N) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b0110: 
		begin
			if(!V) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b0111: 
		begin
			if(V) 
				OUT=1'b0;
			else
				OUT=1'b1;
		end
		4'b1000: 
		begin
			if(C==1 && Z==0) 
				OUT=1'b1;
			else
				OUT=1'b0;
		end
		4'b1001: 
		begin
			if(C==0 || Z==1) 
				OUT=1'b1;
			else
				OUT=1'b0;
		end
		4'b1010: 
		begin
			if(N==V) 
				OUT=1'b1;
			else
				OUT=1'b0;
		end
		4'b1011: 
		begin
			if(N!=V) 
				OUT=1'b1;
			else
				OUT=1'b0;
		end
		4'b1100: 
		begin
			if(Z==0 && N==V) 
				OUT=1'b1;
			else
				OUT=1'b0;
		end

		4'b1101: 
		begin
			if(Z==1 || N!=V) 
				OUT=1'b1;
			else
				OUT=1'b0;
		end
		4'b1110: OUT = 1'b1;
		
	endcase // IN



endmodule // NextStateAdd

// Vi Ghost in the shell. Estuvo mas o menos...	
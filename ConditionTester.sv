module CondTester (output reg OUT, input [3:0] COND, input Z,C,N,V);

    
	always @ (COND,Z,C,N,V)

	COND = 0;

	case(COND)
		4'b0000: 
			if(Z) COND =1;
	
		

	endcase // IN



endmodule // NextStateAdd

// Vi Ghost in the shell. Estuvo mas o menos...	
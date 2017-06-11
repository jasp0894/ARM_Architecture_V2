module NextStateAdd (output reg[1:0] M1M0, input [2:0]IN, input STS);

    
	always @ (IN,STS)

	case(IN)
		3'b000: M1M0 = 2'b00;	//Encoder regardless STS value
	
		3'b010: M1M0 = 2'b10;	//Control Register regardless STS value

		3'b011: M1M0 = 2'b11;	//Incrementer regardless STS value

		3'b100: begin
			if(!STS) M1M0 = 2'b00;	//Encoder
			else M1M0 = 2'b10;	//Control Register
		end


		3'b101: begin
			if(!STS) M1M0 = 2'b11;	//Incrementer
			else M1M0 = 2'b10;	//Control Register
		end


		3'b110: begin 
			if(!STS) M1M0 = 2'b11;	//Incrementer
			else M1M0 = 2'b00;	//Encoder
		end

	endcase // IN

endmodule // NextStateAdd

// Vi Ghost in the shell. Estuvo mas o menos...	
module IncRegister_pepo (D, Enable, CLK, Q);

	//Description
		//Register placed at the output of the control unit adder to maintain the adder's value.

	//Inputs
	input wire [7:0] D;		//Input data to the register
	input wire Enable;		//Signals the register to latch or not
	input wire CLK;

	//Outputs
	output reg [7:0] Q;		//Output data of the register.

	//Implementation
	always @ (posedge CLK)
		if(Enable)
			Q = D;
endmodule // IncRegister

/*
reg reset=1'b1;

always @ (posedge CLK)
if(reset)
	begin
		Q<=8'd0;		//output initialization
		reset <= 1'b0; 	//turn off reset state
	end
else
 	begin

		if(ENABLE)
			Q <= D;
		else
			Q <= Q;

	end
*/
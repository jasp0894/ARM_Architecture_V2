//------------------Control Unit Test Module-----------------------
module CU_Tester;
	//input signals
	reg[31:0] IR;
	reg MOC, COND, MLS0, MLS1, CLK;
	reg[1:0] M1M0;

	//output signals
	wire[31:0] CTL ;



	parameter sim_time = 400;

	//module instantiation
	controlUnit_p cu (CTL,IR,MOC,COND,MLS0,MLS1,CLK);

	
	initial
		begin
			//IRPUTS initialization

			MOC=1'd0; COND=1'd0; MLS0=1'd0; MLS1=1'd0; CLK=1'd0; 			




			IR = 32'b11100001110101000101000000000100;		//State 10



			
			// #500;


			/*M1M0 = 2'd2;#100;
			M1M0 = 2'd3;#100;*/
			// M1M0 = 2'd3;

			/*
			IR =  32'b11110010100110100001000000101100; 		//state 11
			#200;

			IR= 32'b11110001001110100001000000101100;		//state 14
			#200;

			IR=  32'b11110011000110100001000000101100;			//state 15
			#20;*/






		end

	initial
		begin
			
		
			$display("S2S0   STS      N2N0    M1M0     ENC    muxA          CR7_0   muxE  IncReg  ADD_Out      muxD         ctlRregister");
			$monitor("%b     %d       %b      %b       %d     %d        %d      %d    %d      %d       %d              %b", cu.ctl_register.Q[50:48], cu.inv.OUT,cu.ctl_register.Q[56:54], cu.nextState.M1M0, cu.encoder.OUT, cu.muxA.Y,cu.ctl_register.Q[7:0],cu.muxE.Y, cu.incrementerRegister.Q,  cu.adder.S, cu.muxD.Y, cu.ctl_register.Q);
		
		//

		end


	always #20 CLK = ~CLK;
	initial #sim_time $finish;

endmodule // controlunit_piecewise Tester







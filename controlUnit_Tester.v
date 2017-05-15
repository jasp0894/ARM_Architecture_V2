//------------------Control Unit Test Module-----------------------
module CU_Tester;
	//input signals
	reg[31:0] IR;
	reg MOC, COND, MLS0, MLS1, CLK;

	//output signals
	wire[31:0] CTL ;



	parameter sim_time = 50000;

	//module instantiation
	controlUnit cu (CTL,IR,MOC,COND,MLS0,MLS1,CLK);

	
	initial
		begin
			//INPUTS initialization
	
			IR = 32'b11100101110101000101000000000100; //State 16
			MOC=1'd0; COND=1'd0; MLS0=1'd0; MLS1=1'd0; CLK=1'd0;


			#200;


		end

	initial
		begin
			$display("ENC  M1M0    muxA   muxE   muxD            ctlRregister                                                       IncReg         TIME");
			$monitor("%d    %d     %d     %d     %d                %b         %d    %d", cu.encoder.OUT, cu.nextState.M1M0, cu.muxA.Y,cu.muxE.Y, cu.muxD.Y,cu.ctl_register.Q, cu.incrementerRegister.Q,$time);
		end

	always #20 CLK = ~CLK;
	initial #sim_time $finish;

endmodule // mux4Tester



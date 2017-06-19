//------------------Control Unit Test Module-----------------------
module ControlUnit_Tester_pepo;
	//input signals
	reg [31:0] IR;
	reg MOC;
	reg COND;
	reg LSM_DETECT;
	reg LSM_END;
	reg CLK;

	//output signals
	wire [33:0] cu_datapath;

	//Simulatio Parameters
	parameter sim_time = 50000;

	//module instantiation
	cu_pepo cu_pepo (IR, MOC, COND, LSM_DETECT, LSM_END, CLK, cu_datapath);

	initial
		begin
			//INPUTS initialization
	
			IR = 32'b11100101110101000101000000000100; //State 16
			MOC = 1'd0; COND=1'd0; MLS0=1'd0; MLS1=1'd0; CLK=1'd0;


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



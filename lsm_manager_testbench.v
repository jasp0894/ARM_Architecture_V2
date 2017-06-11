module lsm_manager_testbench;

//Simulate the interactions of the lsm_manager with the control unit.

//Inputs to the lsm_manager
	reg LSM_EN;
	reg	[2:0] LSM_IN_3_0;
	reg	[31:0] IR;
	reg CLK;
//Ouputs of the lsm_manager
	wire LSM_DETECT;
	wire LSM_END;
	wire [3:0] LSM_COUNTER;
//Simulation parameters
	parameter sim_time = 40;
//Call the lsm_manager module
	lsm_manager lsm_manager (LSM_EN, LSM_IN_3_0, IR, CLK, LSM_DETECT, LSM_END, LSM_COUNTER);

//Initialize the inputs to the lsm_manager
	initial
		begin
			#1 fork
			LSM_EN = 1'b0;
			LSM_IN_3_0 = 3'b000;
			IR = 32'd0;
			CLK = 1'b0;
			join
//Test 1: Test that the lsm_manager can be loaded with its initial appropriate values.
			
			#1 fork
			LSM_EN = 1'b1;
			LSM_IN_3_0 = 3'b001;
			IR = 32'b00000001110000001100110011001100;
			join

			#4 LSM_IN_3_0 = 3'b110;

		end
//Setup the CLK signal
	always #1 CLK = ~CLK;


//Monitoring	
initial
		begin
			$display("LSM_EN 	LSM_IN_3_0 	IR 				CLK 	LSM_DETECT 	LSM_END 	LSM_COUNTER 	LSMAHR 		TIME");
			$monitor("%b 	%b 	%b 	%b 	%b 		%b 			%d 	 %b	%d", LSM_EN, LSM_IN_3_0, IR, CLK, LSM_DETECT, LSM_END, LSM_COUNTER, lsm_manager.LSMsequential.LSMAHR, $time);
		end

initial #sim_time $finish;

endmodule // lsm_manager
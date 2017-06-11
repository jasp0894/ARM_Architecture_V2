module lsm_manager_testbench;

//Simulate the interactions of the lsm_manager with the control unit.

//Inputs to the lsm_manager
	reg LSM_EN;
	reg	[2:0] LSM_IN_3_0;
	reg	[31:0] IR;
	reg CLK;
//Ouputs of the lsm_manager
	reg LSM_DETECT;
	reg LSM_END;
	reg [3:0] LSM_COUNTER;
//Call the lsm_manager module
	lsm_manager lsm_manager (LSM_EN, LSM_IN_3_0, IR, CLK, LSM_DETECT, LSM_END, LSM_COUNTER);

//Initialize the inputs to the lsm_manager
	initial
		begin
			LSM_EN = 1'b0;
			LSM_IN_3_0 = 3'b000;
			IR = 32'd0;
			CLK = 1'b0;
		end
//Setup the CLK signal
	always #20 CLK = ~CLK;


//Test 1: Test that the lsm_manager can be loaded with its initial appropriate values.
	

endmodule // lsm_manager
module lsm_manager_s_testbench;
	
//Inputs to the module
	reg LSM_EN;
	reg [2:0] LSM_IN_3_0;
	reg [31:0] IR;
	reg LSM_END;
	reg CLK;
//Output of the module
	wire LSMAHR;
	wire LSM_COUNTER;
//Call module: lsm_manager_s

	lsm_manager_s sequential (LSM_EN, LSM_IN_3_0, IR, LSM_END)

endmodule // lsm_manager_s_testbench
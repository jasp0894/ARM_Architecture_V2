module lsm_manager (LSM_EN, 
					LSM_IN_3_0,
					IR,
					CLK,
					LSM_DETECT,
					LSM_END,
					LSM_COUNTER);

//Inputs
	input wire LSM_EN;
	input wire [2:0] LSM_IN_3_0;
	input wire [31:0] IR;
	input wire CLK;

//Outputs
	output wire LSM_DETECT;
	output wire LSM_END;
	output wire [3:0] LSM_COUNTER;
//Internal Connections
	//wire LSM_END;
	wire [15:0] LSMAHR;
//Call modules

	lsm_manager_s LSMsequential(LSM_EN, LSM_IN_3_0, IR, LSM_END, CLK, LSMAHR, LSM_COUNTER);
	lsm_manager_c LSMcombinational(LSM_EN, IR[23], LSMAHR[0], LSMAHR[15], LSM_COUNTER, LSM_DETECT, LSM_END);

endmodule // lsm_manager
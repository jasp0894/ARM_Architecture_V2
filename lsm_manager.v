module lsm_manager (LSM_EN, LSM_IN30, IR, LSM_ADRR30, LSM_DETECT, LSM_END);

//Variable definitions
	//Inputs
	input wire LSM_EN;
	input wire LSM_IN30;
	input wire IR;

	//Outputs
	output reg [3:0] LSM_ADRR30;
	output reg LSM_DETECT;		//The type "reg" of line 11 and 12 is tentative since
	output reg LSM_END;			//I still don't know the nature of such signals.

endmodule
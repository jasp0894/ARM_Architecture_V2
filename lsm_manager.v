module lsm_manager (LSM_EN, LSM_IN30, IR, CLK, LSM_ADRR30, LSM_DETECT, LSM_END);

//Variable definitions
	//Inputs
	input wire LSM_EN;
	input wire [2:0] LSM_IN30;
	input wire [31:0] IR;			//Labeled in the instruction format as U. Determines if the transfer is made upwards or downwards.
	input wire CLK;

	//Outputs
	output reg [3:0] LSM_ADRR30;
	output reg LSM_DETECT;		//The type "reg" of line 11 and 12 is tentative since
	output reg LSM_END;			//I still don't know the nature of such signals.

	//Local
	reg [15:0] LSMAHR;			//Register that holds the register list from the instruction register.
	reg [3:0]  LSM_COUNTER;		//Keeps track of the register being considered in the register list and provides its address.
 
//Load/Store Multiple Manager

	always@(LSM_EN)								//Aqui faltan señales, sino no van a ocurrir los cambios. Es el mismo caso de los muxes a los cuales les cambian las entradas.
		if(LSM_EN)
			if(LSM_IN30[0])						//LSM_IN30's least significant bit is the LSMAHR load enable
				begin
					LSMAHR = IR[15:0];
					if(IR[23]) 					//Transfer is made downward. U = IR[23] = 1
						LSM_COUNTER = 4'd0;
					else						//Transfer is made upward. U = IR[23] = 0
						LSM_COUNTER = 4'd16;
				end
			else if(LSM_IN30[2] && LSM_IN30[1]) //Perform shift and count
				
endmodule
module lsm_manager (LSM_EN, LSM_IN_3_0, IR, CLK, LSM_ADRR_3_0, LSM_DETECT, LSM_END);

//Observations
//The counter should be placed as an output since it resembles the same thing as the LSM_ASRR_3_0 variable.
//What is the purpose of the CLK in this module? 


//Variable definitions
	//Inputs
	input wire LSM_EN;					//Input signal that enables the LSM manager to perform operations.
	input wire [2:0] LSM_IN_3_0;		//Control signals of the LSM combined in a bus. The signals are LSM_Count, LSM_Shift, and the least significant bit is both the LSMAHR and the counter load enable.
	input wire [31:0] IR;				//Labeled in the instruction format as U. Determines if the transfer is made upwards or downwards.
	//Completely FALSE statement --> //Check the above line since the only bit that is used from the instruction register is bit 23.
	input wire CLK;						//Clock signal

	//Outputs
	output reg [3:0] LSM_ADRR_3_0;		//Indicates the number identifying the register that is currently being considered.
	output reg LSM_DETECT;				//The type "reg" of line 11 and 12 is tentative since????????
	output reg LSM_END;					//I still don't know the nature of such signals.

	//Local
	reg [15:0] LSMAHR;					//Register that holds the register list from the instruction register.
	reg [3:0]  LSM_COUNTER;				//Keeps track of the register being considered in the register list and provides its address.
 
//Load/Store Multiple Manager

	always@(LSM_EN, LSM_IN_3_0, CLK)				//Which signals are essential here and which aren't? Seems to me that only the CLK is needed.
		if(LSM_EN)									//If the block is enabled, proceed to perform desired operation.
			if(LSM_IN_3_0[0])						//If true load the counter and the LSMAHR. LSM_IN_3_0's least significant bit is both the LSMAHR's and Counter's load enable.
				begin
					LSMAHR = IR[15:0];				//The LSMAHR is loaded
					if(IR[23]) 						//Transfer is made downward. U = IR[23] = 1
						LSM_COUNTER = 4'd15;		//The counter is loaded with a 15, since the first register to be loaded/stored is the one with highest address.
					else							//Transfer is made upward. U = IR[23] = 0
						LSM_COUNTER = 4'd0;			//The counter is loaded with the lowest address of the register list.
				end
			
			else if(LSM_IN_3_0[2] && LSM_IN_3_0[1]) 					//If true perform shift and count
					if(IR[23])											//Transfer is made downwards. U = IR[23] = 1		
						begin
							LSMAHR <= LSMAHR << 1;								//Shift LEFT to check LSMAHR's most significant bit.
							//Check if counter finished?
							if(LSM_COUNTER == 0)						//If true the counter finished
								LSM_END <= 1'b1;						//Signal that the counter finished.
							else 										//The counter has NOT finished.
								begin
									LSM_COUNTER <= LSM_COUNTER - 1'b1;	//Decrease counter by one.
									LSM_END <= 1'b0;					//Signal that the counter has NOT finished.
								end
						end
					else												//Transfer is made upwards
						begin											
							LSMAHR <= LSMAHR >> 1;								//Shift RIGHT to check LSMAHR's least significant bit.
							if(LSM_COUNTER == 15)						//If true the counter finished
								LSM_END <= 1'b1;						//Signal that the counter finished.
							else 										//The counter has NOT finished.
								begin
									LSM_COUNTER <= LSM_COUNTER + 1;		//Increment the counter by one
									LSM_END <= 1'b0;					//Signal that the counter has NOT finished.
								end
						end
			
			else							  //CHECK State//CHECK State//CHECK State
					if(IR[23])												//Transfer is made downward, that is U = IR[23] = 1, thus the register list must be checked from left to right.
						if(LSMAHR[15])		//initialize this value?		//If true a register was detected at the LSMAHR's most significatn position.
							begin
								LSM_DETECT <= 1'b1;							//Signal that a register was detected.
								LSM_ADRR_3_0 <= LSM_COUNTER;				//Ouput the address of the currently detected register.
							end
						else												//No register was detected.
							LSM_DETECT <= 1'b0;								//Ouput that no signal was detected.
					else													//Transfer is made upward, that is U = IR[23] = 0, thus the register list must be checked from right to left.
						if(LSMAHR[0])										//If true a register was detected at the LSMAHR's least significant position.
							begin
								LSM_DETECT <= 1'b1;							//Signal that a register was detected.
								LSM_ADRR_3_0 <= LSM_COUNTER;				//Ouput the address of the currently detected register.
							end
						else												//No register was detected.
							LSM_DETECT <= 1'b0;								//Ouput that no signal was detected.
endmodule // lsm_manager
module lsm_manager_c (LSM_EN, IR_23, LSMAHR_0, LSMAHR_15, LSM_COUNTER, LSM_DETECT, LSM_END);

//This is the combinational circuit of the Load/Store multiple manager.
//The module is concerned entirely with the check state by
//signaling if a register was detected.

//Inputs
	input wire LSM_EN;
	input wire IR_23;
	input wire LSMAHR_0;
	input wire LSMAHR_15;
	input wire [3:0] LSM_COUNTER;

//Outputs
	output reg LSM_DETECT;
	output reg LSM_END;

//Combinational portion of lsm_manager for the check-state.
	always@(LSM_EN, IR_23, LSMAHR_0, LSMAHR_15, LSM_COUNTER) //CHECK State//CHECK State//CHECK State
		if(LSM_EN)
			if(IR_23)												//Transfer is made downward, that is U = IR[23] = 1, thus the register list must be checked from left to right.
				fork
					//Register detection
					if(LSMAHR_15)		//initialize this value?		//If true a register was detected at the LSMAHR's most significatn position.
						begin
							LSM_DETECT <= 1'b1;							//Signal that a register was detected.
							//LSM_ADRR_3_0 <= LSM_COUNTER;				//Ouput the address of the currently detected register.
						end
					else												//No register was detected.
						LSM_DETECT <= 1'b0;								//Ouput that no signal was detected.
					//Report final count
					if(LSM_COUNTER == 0)						//If true the counter finished
						LSM_END <= 1'b1;						//Signal that the counter finished.
					else 										//The counter has NOT finished.
						LSM_END <= 1'b0;					//Signal that the counter has NOT finished.
				join
			
			else	//Transfer is made upward, that is U = IR[23] = 0, thus the register list must be checked from right to left.
				fork
					//Register detection
					if(LSMAHR_0)										//If true a register was detected at the LSMAHR's least significant position.
						begin
							LSM_DETECT <= 1'b1;							//Signal that a register was detected.
							//LSM_ADRR_3_0 <= LSM_COUNTER;				//Ouput the address of the currently detected register.
						end
					else												//No register was detected.
						LSM_DETECT <= 1'b0;
					//Report final count
					if(LSM_COUNTER == 15)						//If true the counter finished
						LSM_END <= 1'b1;						//Signal that the counter finished.
					else 										//The counter has NOT finished.
						LSM_END <= 1'b0;					//Signal that the counter has NOT finished.
				join
		else
			fork
				LSM_DETECT <= 0;
				LSM_END <= 0;
			join

endmodule // lsm_manager_c
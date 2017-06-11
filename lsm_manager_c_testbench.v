module lsm_manager_c_testbench;

//Inputs to the combinational module.
	reg LSM_EN;
	reg IR_23;
	reg LSMAHR_0;
	reg LSMAHR_15;
	reg [3:0] LSM_COUNTER;
//Outputs of the combinational module.
	wire LSM_DETECT;
	wire LSM_END;
//Module call: lsm_manager_c_testbench

	lsm_manager_c combinational (LSM_EN, IR_23, LSMAHR_0, LSMAHR_15, LSM_COUNTER, LSM_DETECT, LSM_END);

//Initialize input signals:
	initial
		begin

					LSM_EN = 1'b0;
					IR_23 = 1'b0;
					LSMAHR_0 = 1'b0;
					LSMAHR_15 = 1'b0;
					LSM_COUNTER = 4'b0000;
	
			#1	fork
					LSM_EN = 1'b1;
					IR_23 = 1'b1;
					LSMAHR_0 = 1'b0;	//
					LSMAHR_15 = 1'b1;
					LSM_COUNTER = 4'b0001;
				join
			
			#1 LSM_EN = 0;

			#1	fork
					LSM_EN = 1'b1;
					IR_23 = 1'b1;
					LSMAHR_0 = 1'b0;	//
					LSMAHR_15 = 1'b0;
					LSM_COUNTER = 4'b0000;
				join

			#1 LSM_EN = 0;

			#1	fork
					LSM_EN = 1'b1;
					IR_23 = 1'b0;
					LSMAHR_0 = 1'b1;
					LSMAHR_15 = 1'b0;	//
					LSM_COUNTER = 4'b1111;
				join

			#1 LSM_EN = 0;

			#1	fork
					LSM_EN = 1'b1;
					IR_23 = 1'b0;
					LSMAHR_0 = 1'b0;
					LSMAHR_15 = 1'b0;	//
					LSM_COUNTER = 4'b0000;
				join
		end

	initial
		begin
			$display("LSM_EN 	IR_23 	LSMAHR_0 	LSMAHR_15 	LSM_COUNTER 	LSM_DETECT 	LSM_END 	TIME");
			$monitor("%b 	%b 	%b 			%b   	%b 		%b 	 	%b %d", LSM_EN, IR_23, LSMAHR_0, LSMAHR_15, LSM_COUNTER, LSM_DETECT, LSM_END, $time);
		end

endmodule // lsm_manager_c_testbench
//------------------Control Unit Test Module-----------------------
module ControlUnit_Tester_pepo;
	//input signals
	reg [31:0] IR;
	reg MOC;
	reg COND;
	reg LSM_DETECT;
	reg LSM_END;
	reg RESET;
	reg CLK;

	//output signals
	wire [33:0] cu_datapath;

	//Simulatio Parameters
	parameter sim_time = 40;

	//module instantiation
	cu_pepo cu_pepo (IR, MOC, COND, LSM_DETECT, LSM_END, RESET, CLK, cu_datapath);

	initial
		begin
			//INPUTS initialization
			fork
			MOC = 1'b0;
			COND = 1'b0;
			LSM_DETECT = 1'b0;
			LSM_END = 1'b0;
			RESET = 1'b0;
			CLK = 1'b0;
			join

			#1 RESET = 1'b1;
			#2 RESET = 1'b0;

			IR = 32'b00011010111111111111111111111101; //Load/Store Register Offset
			MOC = 1'd1; COND=1'd1 ; LSM_DETECT=1'd0; LSM_END=1'd0; CLK=1'd0;


		end

	initial
		begin
			$display("MA_OUT 	M1M0 	MR_OUT 	RESET 	ME_OUT 	MI 	INC_REG_OUT 	cu_datapath 	CLK 	TIME");
			$monitor("%d %d %d %b %d %b %d %b %b %d",
					cu_pepo.MA_OUT,
					cu_pepo.M1M0,
					cu_pepo.MR_OUT,
					cu_pepo.RESET,
					cu_pepo.ME_OUT,
					cu_pepo.CTL_REG_CUI[19],
					cu_pepo.INC_REG_OUT,
					cu_datapath,
					CLK,
					$time);
		end

	always #2 CLK = ~CLK;
	initial #sim_time $finish;

endmodule // ControlUnit_Tester_pepo



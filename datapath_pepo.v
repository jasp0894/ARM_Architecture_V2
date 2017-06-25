module datapath_pepo (cu_datapath, CLK, RESET, IR_OUT, LSM_DETECT, LSM_END, MOC, COND);

	//Inputs
	input wire [33:0] cu_datapath;
	input wire CLK;
	input wire RESET;

	//Output
	output wire [31:0] IR_OUT;
	output wire LSM_DETECT;
	output wire LSM_END;
	output wire MOC;
	output wire COND;

	//Internal Connections
	wire [3:0] MA_OUT;			//Mux A output
	wire [3:0] LSM_COUNTER;
	wire [31:0] MB_OUT;			//Mux B output
	wire [31:0] PB;				//Port B of the register file.
	wire [31:0] SHIFTER_OUT;	//Output of shifter.
	wire [31:0] MDR_OUT;
	wire [31:0] MAR_OUT;
	wire [3:0] MC_OUT;			//Mux C output
	wire [4:0] MD_OUT;			//Mux D output
	wire [4:0] MG_OUT;
	wire [4:0] MI_OUT;
	wire [31:0] ME_OUT;
	wire [31:0] ALU_OUT;
	wire [31:0] MEM_OUT;		//Output of RAM
	wire [2:0] MF_OUT;
	wire [3:0] SLS_OUT;			//Single load/store manager output Data-Size signals
	wire MH_OUT;
	wire MJ_OUT;
	wire SLS_R_W;				//Read/Write signal from the SLS manager.
	wire [3:0] FR_OUT;
	wire [3:0] FLAGS;
	wire [31:0] PA;				//Port A of the register file.
	wire CONDTESTER_OUT;
	
	//Module Implementation
		//Muxes
		mux_4x1_4bit muxA (MA_OUT, cu_datapath[26:25], IR_OUT[19:16], 4'b1111, LSM_COUNTER, IR_OUT[15:12]);
		mux_8x1_32bit muxB (MB_OUT, IR_OUT[24:22], PB, SHIFTER_OUT, MDR_OUT, MAR_OUT, 32'd0, 32'd0, 32'd0, 32'd0);
		mux_8x1_4bit muxC (MC_OUT, cu_datapath[21:19], IR_OUT[19:16], 4'b1111, 4'b1110, IR_OUT[15:12], LSM_COUNTER, 4'd0, 4'd0, 4'd0);
		mux_4x1_5bit muxD (MD_OUT, cu_datapath[18:17], cu_datapath[15:11]/*OP4-OP0*/, {1'b0,IR_OUT[24:21]} /*1bit concatennation*/, MG_OUT, MI_OUT);
		mux_2x1_32bit muxE (ME_OUT, cu_datapath[16], ALU_OUT, MEM_OUT);
		mux_2x1_3bit muxF (MF_OUT, cu_datapath[0], cu_datapath[9:7], SLS_OUT[2:0]);
		mux_2x1_5bit muxG (MG_OUT, IR_OUT[23], 5'b10110, 5'b10101);
		mux_4x1_1bit muxH (MH_OUT, cu_datapath[2:1], cu_datapath[28], SLS_OUT[3], IR_OUT[20]/*Corresponds to MLS?*/, 1'b0);
		mux_2x1_5bit muxI (MI_OUT, IR_OUT[23], 5'b10001, 5'b10011);
		mux_2x1_1bit muxJ (MJ_OUT, cu_datapath[33], 1'b0, IR_OUT[20]);

		//Memory
		ram256x8 ram256x8 (cu_datapath[27], MH_OUT, MF_OUT, MDR_OUT, MAR_OUT, CLK, MOC, MEM_OUT, RESET);

		//Registers
		Reg32bits MAR (MAR_OUT, ALU_OUT, cu_datapath[30], CLK, RESET);
		Reg32bits MDR (MDR_OUT, ME_OUT, cu_datapath[29], CLK, RESET);
		Reg32bits IR (IR_OUT, MEM_OUT, cu_datapath[31], CLK, RESET);
		flagRegister FR (FR_OUT,FLAGS,MJ_OUT,CLK,RESET);

		//ALU
		ALU_V1 ALU (ALU_OUT, FLAGS, MB_OUT, PA, FR_OUT[3], MD_OUT);

		//Management Blocks
		RegisterFile_pepo RF (PA, PB, ALU_OUT, CLK, cu_datapath[32], MA_OUT, IR_OUT[3:0], MC_OUT, RESET);
		lsm_manager lsm_manager (cu_datapath[6], cu_datapath[5:3], IR_OUT, CLK, LSM_DETECT, LSM_END, LSM_COUNTER);
		SLSManager SLSManager (SLS_OUT,IR_OUT,cu_datapath[10]);
		shifter shifter (SHIFTER_OUT, FLAGS[3], PB, IR_OUT, FR_OUT[3], 1'b1 /*Wierd*/);	//Most ackard wiring.
		CondTester ConditionTester (CONDTESTER_OUT, IR_OUT[31:28], FR_OUT[3], FR_OUT[2], FR_OUT[1], FR_OUT[0]);

endmodule // datapath_pepo
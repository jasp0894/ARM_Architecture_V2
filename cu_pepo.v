module cu_pepo (IR, MOC, COND, LSM_DETECT,LSM_END, CLK, cu_datapath);

	//Inputs
	input wire [31:0] IR;		//Output of IR contents supplied to the cu.
	input wire MOC;				//Memory signal indicating that access to memory was completed.
	input wire COND;			//Output of the conditon tester to indicate if an instruction will be executed. Use in state 4 of fetch.
	input wire LSM_DETECT;		//Output of LSM_manager indicating for LSM instructions that a register was detected in the instruction register list.
	input wire LSM_END;			//Output of LSM_manager indiccating that the LSM instruction management process ended.
	input wire CLK;

	//Outputs
	output wire [33:0] cu_datapath;	//All the signals that the cu uses to control the datapath.

	//Wires
	wire [1:0] M1M0;
	wire MC_OUT, INV_OUT, ADDER_COUT ;
	wire [7:0] MD_OUT,
			   ADD_OUT,
			   INC_REG_OUT,
			   ME_OUT,
			   MA_OUT, 
			   ENC_OUT;
	wire [63:0] ROM_OUT;
	wire [29:0] CTL_REG_CUI;	//Internal signals of the control register for the control unit.

	//Reference
	//63 62 61 60 59 58  57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0
//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0  MJ   RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF
//						23-21	20	19	18-16	15-8	7-0	CTL_REG_CUI
	//Implementation
	Encoder encoder (ENC_OUT,IR);	//--

	mux_4x1_8bit muxAc (MA_OUT,M1M0,ENC_OUT,8'd0,CTL_REG_CUI[7:0]/*CR7-CR0*/,ME_OUT);	//--

	rom_64bits_pepo rom_64bits_pepo (ROM_OUT,MA_OUT);	//--

	ControlRegister_pepo ControlRegister_pepo (ROM_OUT, 1'd1, CLK, CTL_REG_CUI, cu_datapath);	//--

	AdderCU AdderCU (ADD_OUT,ADDER_COUT,MA_OUT,8'd1,1'd0);	//--

	IncRegister_pepo IncRegister_pepo (ADD_OUT,1'd1,CLK,INC_REG_OUT);	//--

	mux_2x1_8bit muxEc (ME_OUT,CTL_REG_CUI[19]/*MI*/,INC_REG_OUT,CTL_REG_CUI[15:8]/*CR15-CR8*/);	//--

	mux_8x1_1bit muxCc (MC_OUT,CTL_REG_CUI[18:16]/*S2-S0*/, MOC, COND, IR[20], LSM_DETECT, LSM_END,IR[21],1'd0,1'd0);	//--

	InverterCU InverterCU (INV_OUT, MC_OUT,CTL_REG_CUI[20]);	//--

	NextStateAdd NextStateAdd (M1M0, CTL_REG_CUI[23:21]/*N2-N0*/, INV_OUT);	//--

endmodule // cu_pepo
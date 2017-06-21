//Datapath Phase 1 Tester: DOES NOT include memory interface 



module dp_phase2;



//input signals

	//reg[31:0] IR;
	integer fi,code;
	reg  CLK, RESET;
	reg[31:0] Address;
	reg [31:0] data;			//Dummy variable used to pre-charge RAM.
	reg[31:0] DATA_IN;






//output signals

	wire[31:0]  PA, PB, ALU_OUT, IR_Q, MAR_Q, MDR_Q, SHIFTER_OUT, MB_OUT, ME_OUT;

	wire [33:0] CU_OUT_DP,CU_OUT_CU;

	wire[3:0] FR_Q, MC_OUT, MA_OUT , FLAGS, LSM_COUNTER;
	
	wire[2:0] SLS_OUT, MF_OUT;

	wire[4:0] MI_OUT, MG_OUT,MD_OUT;
	
	wire CONDTESTER_OUT, Z, N, V, C, MH_OUT, MJ_OUT;
	wire LSM_DETECT, LSM_END,MOC;
	
	wire[31:0] DATA_OUT;

	


//63 62 61 60 59 58      57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0

//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0 FRLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF



	parameter sim_time = 1000;



	//modules instantiation

	flagRegister FR(FR_Q,FLAGS,MJ_OUT,CLK,RESET);

	//controlUnit_p cu1(CU_OUT,IR_Q,MOC,CONDTESTER_OUT,LSM_DETECT,LSM_END,CLK,RESET);

	cu_pepo cu(IR_Q,MOC,CONDTESTER_OUT,LSM_DETECT,LSM_END,CLK,CU_OUT)
	ALU_V1 alu(ALU_OUT,FLAGS,MB_OUT,PA,FR_Q[3], MD_OUT);

	CondTester conditionTester (CONDTESTER_OUT,IR_Q[31:28],FR_Q[3],FR_Q[2],FR_Q[1],FR_Q[0]);

	mux_4x1_4bit muxA (MA_OUT,CU_OUT[26:25],IR_Q[19:16], 4'b1111, LSM_COUNTER, IR_Q[15:12]);

	mux_8x1_4bit muxC (MC_OUT,CU_OUT[21:19],IR_Q[19:16], 4'b1111, 4'b1110, IR_Q[15:12], LSM_COUNTER, 4'd0, 4'd0, 4'd0);

	registerFile RF (PA,PB,ALU_OUT, CLK, CU_OUT[32],MA_OUT,IR_Q[3:0],MC_OUT);

	mux_8x1_32bit muxB (MB_OUT,CU_OUT[24:22],PB, SHIFTER_OUT, MDR_Q, MAR_Q, 32'd0, 32'd0, 32'd0, 32'd0);

	shifter SHIFTER (SHIFTER_OUT,FLAGS[3],PB,IR_Q,FR_Q[3],1'd1);
	//*******************************************************************************************************
	
	mux_4x1_1bit muxH(MH_OUT,CU_OUT[2:1],CU_OUT[28],1'b0,IR_Q[20],1'b0);	// falta B = SLS_R/W

	mux_2x1_3bit muxF(MF_OUT, CU_OUT[0], CU_OUT[9:7],SLS_OUT);

	SLSManager sls(SLS_OUT,IR_Q,CU_OUT[10]);

	mux_2x1_32bit muxE(ME_OUT, CU_OUT[16], ALU_OUT, DATA_OUT);


	lsm_manager lsm(CU_OUT[6], CU_OUT[5:3], IR_Q, CLK, LSM_DETECT, LSM_END, LSM_COUNTER);

	mux_2x1_1bit muxJ(MJ_OUT,CU_OUT[33],1'b0,IR_Q[20]);

	mux_4x1_5bit muxD(MD_OUT,CU_OUT[18:17],CU_OUT[15:11],{1'b0,IR_Q[24:21]}, MG_OUT,MI_OUT);

	mux_2x1_5bit muxI(MI_OUT, IR_Q[23], 5'b10001, 5'b10011);

	mux_2x1_5bit muxG(MG_OUT, IR_Q[23], 5'b10110, 5'b10101);

	Reg32bits IR (IR_Q, DATA_OUT, CU_OUT[31], CLK,RESET);

	Reg32bits MDR(MDR_Q, ME_OUT, CU_OUT[29], CLK,RESET);

	Reg32bits MAR(MAR_Q, ALU_OUT, CU_OUT[30], CLK,RESET);

	//  MOV, ReadWrite, MS_2_0, DataIn, Address, CLK, MOC, DataOut
	ram256x8 ram256x8 (CU_OUT[27],MH_OUT,MF_OUT,MDR_Q,MAR_Q,CLK,MOC,DATA_OUT);






	initial

		begin

			//INPUTS initialization



			 //COND=1'd0;
			  		


			 //Memory Pre-Charge
				
			fi = $fopen("ramdata.txt", "r");				//Open the input file.
			Address = 32'd0;								//Set the initial Address in memory to begin pre-charge.
			while (!$feof(fi)) 
				begin					//Keep the file open until you reach its end.
					code = $fscanf(fi, "%b", data); 		//Read a line of the input file and store it in the dummy variable.
					ram256x8.ram256x8_cREC.memory[Address] = data;			//Store in the given Address of "memory" the data in the dummy variable.
					Address = Address + 1;					//Point to the next Address in order to continue pre-charge.
				end
			$fclose(fi);									//Close the input file.
																//Pre-charge ends

		   	
		     //DA = 32'b11100001101110001000000000101100;	//MOV  Rd = R8 = 12
		    // #200;
		    // DATA_IN = 32'b11100000100111001000000000101100; //ADD Rd= R12; Rn=R8; shifterOp = 12
		    // #200;
			//DATA_IN = 32'b11100000100110100001000000101100;		//State 10
			//#20;
			/*
			IR =  32'b11110010100110100001000000101100; 		//state 11
			#200;
			IR= 32'b11110001001110100001000000101100;		//state 14
			#200;
			IR=  32'b11110011000110100001000000101100;			//state 15
			#20;*/

		end

	initial
		begin
			$display("        \t CU\t   	STATE#	CR15-CR8 CR7-CR0   R/W  MEM_IN  MEM_OUT  CondT  IR_OUT   Rd Rn  SHIFTER   \tPA \t PB  FR_Q     ALU_OUT CZVN MA\t\tMB MC\tMD  	  ME MF MG MH MI  MDR 	  MAR      \tPC"); 
		end

	always@(posedge CLK)

		begin

			$monitor("%b  %d   %d   %d         %b   %h %h   %b   %h %d %d%d%d%d   %b%d  %b %d  %d %d   %d %d %d %d %d  %d  %h %h %d",
					CU_OUT,
					cu1.CTL_REG_OUT[63:58],
					cu1.CTL_REG_OUT[49:42],
					cu1.CTL_REG_OUT[41:34],
					MH_OUT,
					MDR_Q,
					DATA_OUT,
					CONDTESTER_OUT,
					IR_Q,
					IR_Q[15:12],
					IR_Q[19:16],
					SHIFTER_OUT,
					PA,
					PB,
					FR_Q,
					ALU_OUT,
					FLAGS,
					MA_OUT,
					MB_OUT,
					MC_OUT,
					MD_OUT,
					ME_OUT,
					MF_OUT,
					MG_OUT,
					MH_OUT,
					MI_OUT,
					MDR_Q,
					MAR_Q,
					RF.QS15); 

			//$monitor("%b   %d ",CU_OUT,/*MA_OUT,MC_OUT,PA,PB,SHIFTER_OUT,MB_OUT,ALU_OUT,Z,C,N,V,*/ $time); 

		//



		end



	// Cambiar el Clock

	/*
	CLK=1'd0;
	always #2 CLK = ~CLK;
	*/

	initial 
	begin
		CLK = 1'b0;
		repeat (1000)
		#2 CLK = ~CLK;
	end

	initial
		fork
			RESET = 1;
			#6 RESET = 0;
		join




	initial #sim_time $finish;



endmodule // controlunit_piecewise Tester








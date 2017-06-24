//Datapath Phase 1 Tester: DOES NOT include memory interface 



module MCU_TESTER;



//input signals

	//reg[31:0] IR;
	integer fi,code;
	reg  CLK, RESET;
	reg[31:0] Address;
	reg [31:0] data;			//Dummy variable used to pre-charge RAM.
	reg[31:0] DATA_IN;

	//Internal Connections
	wire [31:0] IR_OUT;
	wire MOC;
	wire COND;
	wire LSM_DETECT;
	wire LSM_END;
	wire [33:0] cu_datapath;


cu_pepo cu (IR_OUT, MOC, COND, LSM_DETECT,LSM_END, RESET, CLK, cu_datapath);

datapath_pepo datapath (cu_datapath, CLK, RESET, IR_OUT, LSM_DETECT, LSM_END, MOC, COND);

//63 62 61 60 59 58      57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0

//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0 FRLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF



	parameter sim_time = 1000;


	initial

		begin
			 //Memory Pre-Charge
				
			fi = $fopen("ramdata.txt", "r");				//Open the input file.
			Address = 32'd0;								//Set the initial Address in memory to begin pre-charge.
			while (!$feof(fi)) 
				begin					//Keep the file open until you reach its end.
					code = $fscanf(fi, "%b", data); 		//Read a line of the input file and store it in the dummy variable.
					datapath.ram256x8.ram256x8_cREC.memory[Address] = data;			//Store in the given Address of "memory" the data in the dummy variable.
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
					cu_datapath,
					cu.CTL_REG_CUI[29:24], 
					cu.CTL_REG_CUI[15:8], 
					cu.CTL_REG_CUI[7:0],
					datapath.MH_OUT,
					datapath.MDR_OUT,
					datapath.MEM_OUT,
					datapath.CONDTESTER_OUT,
					IR_OUT,
					IR_OUT[15:12],
					IR_OUT[19:16],
					datapath.SHIFTER_OUT,
					datapath.PA,
					datapath.PB,
					datapath.FR_OUT,
					datapath.ALU_OUT,
					datapath.FLAGS,
					datapath.MA_OUT,
					datapath.MB_OUT,
					datapath.MC_OUT,
					datapath.MD_OUT,
					datapath.ME_OUT,
					datapath.MF_OUT,
					datapath.MG_OUT,
					datapath.MH_OUT,
					datapath.MI_OUT,
					datapath.MDR_OUT,
					datapath.MAR_OUT,
					datapath.RF.QS15); 
		end



	// Cambiar el Clock

	/*
	CLK=1'd0;
	always #2 CLK = ~CLK;
	*/

	initial 
	begin
		CLK = 1'b0;
		repeat (1000000000)
		#2 CLK = ~CLK;
	end

	initial
		fork
			RESET = 1;
			#6 RESET = 0;
		join
	initial #sim_time $finish;

endmodule // controlunit_piecewise Tester








module MCU_TESTER;



	//DUT Input signals
	reg  CLK, RESET;

	//Internal Connections
	wire [31:0] IR_OUT;
	wire MOC;
	wire COND;
	wire LSM_DETECT;
	wire LSM_END;
	wire [34:0] cu_datapath;

	//Simulation Controls
	integer fi,fo,code;
	reg[31:0] Address;
	reg [31:0] data;			//Dummy variable used to pre-charge RAM.
	reg MOV;						//Indicates memory that an operation will be performed.
	reg ReadWrite;
	reg [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	
	

	//Call Modules
	cu_pepo cu (IR_OUT, MOC, COND, LSM_DETECT,LSM_END, RESET, CLK, cu_datapath);
	datapath_pepo datapath (cu_datapath, CLK, RESET, IR_OUT, LSM_DETECT, LSM_END, MOC, COND);

	parameter sim_time = 1500;


	initial

		begin
			 //Memory Pre-Charge
				
			fi = $fopen("ramdata2.txt", "r");				//Open the input file.
			Address = 32'd0;								//Set the initial Address in memory to begin pre-charge.
			while (!$feof(fi)) 
				begin					//Keep the file open until you reach its end.
					code = $fscanf(fi, "%b", data); 		//Read a line of the input file and store it in the dummy variable.
					datapath.ram256x8.ram256x8_cREC.memory[Address] = data;			//Store in the given Address of "memory" the data in the dummy variable.
					Address = Address + 1;					//Point to the next Address in order to continue pre-charge.
				end
			$fclose(fi);									//Close the input file.															//Pre-charge ends
		end


		//Interact with memory
		initial
			begin
				fo = $fopen("ramoutput.txt", "w");	//Open memory output file
			end

		always @(MOC)
			begin
				if(MOC)
					if(~cu_datapath[28])							//If the RAM signals it completed the current operation and the operation was read,
						$fdisplay(fo,"Contents of memory location %d are %b",datapath.ram256x8.Address,datapath.ram256x8.DataIn);		//Place the bits in the output bus of the RAM in a file.
					//Note that you must read from memory in order to write in the ouput file.
			end	

	

	initial
		begin
			$display("  \t CU\t   	     STATE#	CR15-CR8 CR7-CR0   R/W  MEM_IN  MEM_OUT  CondT  IR_OUT   Rd Rn  SHIFTER   \tPA \t   PB  FR_Q     ALU_OUT   CZVN MA\t     MB MC   MD        ME MF MG MH MI  MDR 	  MAR      \t PC           R0        R1          R5           R10      R12       R14"); 
		end

	always@(posedge CLK)

		begin

			$monitor("%b  %d   %d   %d         %b   %h %h   %b   %h %d %d %d %d %d   %b %d   %b %d  %d %d   %d %d %d %d %d  %d  %h %d  %d %d %d %d %d %d %d",
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
					datapath.RF.QS15,
					datapath.RF.QS0,
					datapath.RF.QS1,
					datapath.RF.QS5,
					datapath.RF.QS10,
					datapath.RF.QS12,
					datapath.RF.QS14); 
		end



	// Cambiar el Clock

	/*
	CLK=1'd0;
	always #2 CLK = ~CLK;
	*/

	initial 
	begin
		CLK = 1'b0;
		repeat (1500)
		#2 CLK = ~CLK;
	end

	initial
		fork
			RESET = 1;
			#6 RESET = 0;
		join
	initial #sim_time $finish;

endmodule // controlunit_piecewise Tester








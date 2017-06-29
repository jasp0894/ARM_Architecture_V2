module mcu2;

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


initial $readmemb("ramdata.txt", datapath.ram256x8.ram256x8_cREC.memory);

reg [8:0] i; // loop index

initial begin
//	FILL RAM MEMORY
	for(i=9'h000;i<9'h0FF;i=i+9'h004)

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
			$fclose(fi);									//Close the input file.															//Pre-charge ends
		end
	  	
		#1490;
		for(i=9'h000;i<9'h0FE;i=i+9'h004)
		begin
			$write ("WORD at location %d: %b", i, datapath.ram256x8.ram256x8_cREC.memory[i[7:0]]);
	      	$write ("%b", datapath.ram256x8.ram256x8_cREC.memory[i[7:0]+1]);
	      	$write ("%b", datapath.ram256x8.ram256x8_cREC.memory[i[7:0]+2] );
	      	$display ("%b", datapath.ram256x8.ram256x8_cREC.memory[i[7:0]+3]);
		end
end

initial
	begin
		CLK = 1;
		RESET<=0;
		#5 RESET =1;
		#1 repeat (1500)
		begin
			#1 CLK = ~CLK;
		end
end






endmodule

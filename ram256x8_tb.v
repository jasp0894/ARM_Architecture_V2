module ram256x8_tb;
	
	integer fi, fo, code;
	
	//Inputs
	input reg MOV;						//Indicates memory that an operation will be performed.
	input reg ReadWrite;				//Indicates memory which type of operation will be performed.
	input reg [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	input reg [31:0] DataIn;			//Input bus of data of the RAM.
	input reg [31:0] Address;		//Indicates the memory location to be accessed.
	input reg CLK;

	//Outputs
	output wire MOC;					//Indicates if memory operation finished.
	output wire [31:0] DataOut;			//Output bus of the ram.

	
	



	//Simulation
	initial 
		begin
			fi = $fopen("PF1_Barreras_Gonzalez_Jose_ramdata.txt", "r");			//Open the input file.
			Address = 32'd0;							//Set the initial address in memory to begin pre-charge.
			while (!$feof(fi)) 
				begin					//Keep the file open until you reach its end.
					code = $fscanf(fi, "%b", data); 		//Read a line of the input file and store it in the dummy variable.
					ramito.memory[address] = data;			//Store in the given address of "memory" the data in the dummy variable.
					address = address + 1;					//Point to the next address in order to continue pre-charge.
				end
			$fclose(fi);								//Close the input file.
		end												//Pre-charge ends

endmodule // ram256x8_tb
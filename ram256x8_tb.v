module ram256x8_tb;
	
//Simulation Setup

	integer fi, fo, code;
	
	//Inputs
	reg MOV;						//Indicates memory that an operation will be performed.
	reg ReadWrite;				//Indicates memory which type of operation will be performed.
	reg [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	reg [31:0] DataIn;			//Input bus of data of the RAM.
	reg [31:0] Address;		//Indicates the memory location to be accessed.
	reg CLK;

	//Outputs
	output wire MOC;					//Indicates if memory operation finished.
	output wire [31:0] DataOut;			//Output bus of the ram.

	//Simulation parameters
	parameter sim_time = 500;

	//Call the memory module
	ram256x8 ram256x8 (MOV, ReadWrite, MS_2_0, DataIn, Address, MOC, DataOut);	




//Simulation

	//Memory Pre-Charge
	initial 
		begin
			fi = $fopen("ramdata.txt", "r");			//Open the input file.
			Address = 32'd0;							//Set the initial Address in memory to begin pre-charge.
			while (!$feof(fi)) 
				begin					//Keep the file open until you reach its end.
					code = $fscanf(fi, "%b", data); 		//Read a line of the input file and store it in the dummy variable.
					ram256x8.ram256x8_c.memory[Address] = data;			//Store in the given Address of "memory" the data in the dummy variable.
					Address = Address + 1;					//Point to the next Address in order to continue pre-charge.
				end
			$fclose(fi);								//Close the input file.
		end												//Pre-charge ends

	
	//Interact with memory
	initial
		begin
			fo = $fopen("ramoutput.txt", "w");	//Open memory output file
			
			//Reading a byte
				Address = 32'd5;							//Select memory location.
				MS_2_0 = 3'b000;							//Select the data size
				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;								//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;								//Operation completed.

			//Reading a half-word
				Address = 32'd14;							//Select memory location.
				MS_2_0 = 3'b001;							//Select the data size.
				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

			//Reading a word
				Address = 32'd18;							//Select memory location.
				MS_2_0 = 3'b010;							//Select the data size.
				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.	

			//Reading a double-word
				Address = 32'd22;							//Select memory location.
				MS_2_0 = 3'b011;							//Select the data size.
				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

				Address = 32'd26;							//Select memory location.
					
				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

			//==========Perform Write Operation=============================================================================================
			//The objective is to write on memory and then read the data from the written locations.
			//These observations are provided because all the read operations' data is sent to the SAME output file.

			//Writing a byte
				Address = 32'd0;							//Select memory location.
				MS_2_0 = 3'b000;							//Select the data size
				DataIn = 32'b11111111;						//Data to be written
				ReadWrite = 1'b0;							//Perform write operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

				MS_2_0 = 3'b010;
				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.
			//The interpretation for the bits that appear when performing a read in this ocassion is that since the memory
			//is already pre-charged there may be values of no importance at the output bus of the RAM. Its up to the
			//processor to interpret correctly the bit locations for which "it" asked for "information".

			//Writing a half-word
				Address = 32'd10;							//Select memory location.
				MS_2_0 = 3'b001;							//Select the data size
				DataIn = 32'b1111111111111111;			//Data to be written
				ReadWrite = 1'b0;							//Perform write operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

				MS_2_0 = 3'b010;
				Address = 32'd8;
				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

			//Writing a word
				Address = 32'd13;							//Select memory location.
				MS_2_0 = 3'b010;							//Select the data size
				DataIn = 32'b11000000000000000000000000000001;			//Data to be written
				ReadWrite = 1'b0;							//Perform write operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

			//Writing a double-word
				//Since the bus sizes are only of 32 bits, when a double-word is to be written the processor must take such limitation
				//into account and update the Address of the first word by 4. Thus, all the responsability of updating the Address is
				//solely resting on the processor and the memory has nothing to do with this.

				Address = 32'd25;							//Select memory location.
				MS_2_0 = 3'b011;							//Select the data size
				DataIn = 32'b11000000000000000001111100000001; //Data to be written
				ReadWrite = 1'b0;							//Perform write operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

				//Prepare and write the next word.

				Address = 32'd29;							//Note the updated Address.
				MS_2_0 = 3'b011;							//Select the data size
				DataIn = 32'b11111111111110000111111111111111; //Data to be written
				ReadWrite = 1'b0;							//Perform write operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

				ReadWrite = 1'b1;							//Perform read operation.

				#5 MOV = 1'b1;							//Indicates the RAM to perform an operation.
				#5 MOV = 1'b0;							//Operation completed.

					

		end

	//Clock signal setup
	always #1 CLK = ~CLK;

initial #sim_time $finish;

initial
	begin
		$display("MOV 	MOC 	CLK 	TIME");
		$monitor("%b 	%b 	%b 	%b 	%d",MOV, MOC, CLK, $time);
	end

/*always @(RAMdone) begin
		if(RAMdone)								//If the RAM signals it completed the current operation and the operation was read,
			if(ReadWrite) 						//Avoid storing data from write operations.
				$fdisplay(fo,"Contents of memory location %d are %b",address, RAMout);		//Place the bits in the output bus of the RAM in a file.
*/
endmodule // ram256x8_tb
module ram256x8_tb;
	
//Simulation Setup
	//Simulation preparation
	integer fi, fo, code;
	reg [31:0] data;			//Dummy variable used to pre-charge RAM.
	reg [2:0] CaseCounter;		//Used to feed the memory different CPU control signals
	reg [1:0] CPUstate;			//Simulates the state of the CPU.

	//Inputs
	reg MOV;					//Indicates memory that an operation will be performed.
	reg ReadWrite;				//Indicates memory which type of operation will be performed.
	reg [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	reg [31:0] DataIn;			//Input bus of data of the RAM.
	reg [31:0] Address;			//Indicates the memory location to be accessed.
	reg CLK;

	//Outputs
	output wire MOC;					//Indicates if memory operation finished.
	output wire [31:0] DataOut;			//Output bus of the ram.

	//Simulation parameters
	parameter sim_time = 25;

	//Call the memory module
	ram256x8 ram256x8 (MOV, ReadWrite, MS_2_0, DataIn, Address, CLK, MOC, DataOut);	




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
			//Initialize the clock
			CLK = 1'b0;
			//Open memory output file
			fo = $fopen("ramoutput.txt", "w");
			//CPU initial state
			MOV = 1'b0;
			CaseCounter = 5'd0;
			CPUstate = 3'd0;
		end


	always@(posedge CLK)
		
		if(CaseCounter != 3'd6)
			
			case(CPUstate)

				2'b00: //State 0: Place control signals

					case(CaseCounter) //Setup the desired control signals.
					
						3'b000: //Reading a byte
							begin
								Address = 32'd5;					//Select memory location.
								MS_2_0 = 3'b000;					//Select the data size
								ReadWrite = 1'b1;					//Perform read operation.
								CPUstate = 2'b01;
							end
						3'b001: //Reading a half-word
							begin
								Address = 32'd14;					//Select memory location.
								MS_2_0 = 3'b001;					//Select the data size.
								ReadWrite = 1'b1;					//Perform read operation.
								CPUstate = 2'b01;
							end
						3'b010: //Reading a word
							begin
								Address = 32'd18;					//Select memory location.
								MS_2_0 = 3'b010;					//Select the data size.
								ReadWrite = 1'b1;
								CPUstate = 2'b01;
							end

//Writing operations

						3'b011: //Writing a byte
							begin
								Address = 32'd0;							//Select memory location.
								MS_2_0 = 3'b000;							//Select the data size
								DataIn = 32'b11111111;						//Data to be written
								ReadWrite = 1'b0;
								CPUstate = 2'b01;
							end
						3'b100: //Writing a half-word
							begin
								Address = 32'd10;							//Select memory location.
								MS_2_0 = 3'b001;							//Select the data size
								DataIn = 32'b1111111111111111;			//Data to be written
								ReadWrite = 1'b0;							//Perform write operation.
								CPUstate = 2'b01;
							end
						3'b101: //Writing a word
							begin
								Address = 32'd13;							//Select memory location.
								MS_2_0 = 3'b010;							//Select the data size
								DataIn = 32'b11000000000000000000000000000001;			//Data to be written
								ReadWrite = 1'b0;
								CPUstate = 2'b01;
							end

					endcase // CaseCounter

				2'b01://State1: Perform Operatio State
					begin
						MOV = 1'b1;
						CPUstate = 2'b10;
					end

				2'b10://State3: Do some other stuff not related to memory
					begin
						MOV = 1'b0;
						CPUstate = 2'b00;
						CaseCounter <= CaseCounter + 1;
					end

			endcase //CPUstate


	//Clock signal setup
	always #1 CLK = ~CLK;

initial #sim_time $finish;

initial
	begin
		$display("MOV 	MOC 	CLK CaseCounter CPUstate	TIME");
		$monitor("%b 	%b 	%b     %d         %d %d",MOV, MOC, CLK, CaseCounter, CPUstate, $time);
	end

always @(MOC)
	begin
		if(MOC)							//If the RAM signals it completed the current operation and the operation was read,
			if(ReadWrite) 				//Avoid storing data from write operations.
				$fdisplay(fo,"Contents of memory location %d are %b",Address, DataOut);		//Place the bits in the output bus of the RAM in a file.
			//Note that you must read from memory in order to write in the ouput file.
	end

endmodule // ram256x8_tb
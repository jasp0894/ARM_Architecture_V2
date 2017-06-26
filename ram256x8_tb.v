module ram256x8_tb;
	
//Simulation Setup
	//Simulation preparation
	integer fi, fo, code;
	reg [31:0] data;			//Dummy variable used to pre-charge RAM.
	reg [4:0] CaseCounter;		//Used to feed the memory different CPU control signals
	reg [1:0] CPUstate;			//Simulates the state of the CPU.

	//Inputs
	reg MOV;					//Indicates memory that an operation will be performed.
	reg ReadWrite;				//Indicates memory which type of operation will be performed.
	reg [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	reg [31:0] DataIn;			//Input bus of data of the RAM.
	reg [31:0] Address;			//Indicates the memory location to be accessed.
	reg RESET;
	reg CLK;

	//Outputs
	wire MOC;					//Indicates if memory operation finished.
	wire [31:0] DataOut;			//Output bus of the ram.

	//Simulation parameters
	parameter sim_time = 70;

	parameter BYTE = 3'b000; //byte w/o sign extension
	parameter HALFWORD = 3'b001; //halfword w/o sign extension
	parameter WORD = 3'b010; //byte w/o sign extension
	parameter BYTEe = 3'b100; //byte w sign extension
	parameter HALFWORDe = 3'b101; //halfword w sign extension
	parameter WORDe = 3'b110; //word w sign extension

	//Call the memory module
	ram256x8 ram256x8 (MOV, ReadWrite, MS_2_0, DataIn, Address, CLK, MOC, DataOut, RESET);	




//Simulation

	//Memory Pre-Charge
	initial 
		begin
			fi = $fopen("ramdata.txt", "r");				//Open the input file.
			Address = 32'd0;								//Set the initial Address in memory to begin pre-charge.
			while (!$feof(fi)) 
				begin					//Keep the file open until you reach its end.
					code = $fscanf(fi, "%b", data); 		//Read a line of the input file and store it in the dummy variable.
					ram256x8.ram256x8_cREC.memory[Address] = data;			//Store in the given Address of "memory" the data in the dummy variable.
					Address = Address + 1;					//Point to the next Address in order to continue pre-charge.
				end
			$fclose(fi);									//Close the input file.
		end													//Pre-charge ends

	
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
		
		if(CaseCounter != 5'd13)
			
			case(CPUstate)

				2'b00: //State 0: Place control signals

					case(CaseCounter) //Setup the desired control signals.
					
						5'd0: //Reading a byte
							begin
								Address = 32'd0;					//Select memory location.
								MS_2_0 = BYTE;					//Select the data size
								ReadWrite = 1'b1;					//Perform read operation.
								CPUstate = 2'b01;
							end
						5'd1: //Reading a half-word
							begin
								Address = 32'd0;					//Select memory location.
								MS_2_0 = HALFWORD;					//Select the data size.
								ReadWrite = 1'b1;					//Perform read operation.
								CPUstate = 2'b01;
							end
						5'd2: //Reading a word
							begin
								Address = 32'd0;					//Select memory location.
								MS_2_0 = WORD;					//Select the data size.
								ReadWrite = 1'b1;
								CPUstate = 2'b01;
							end

//Writing operations

						5'd3: //Writing a byte
							begin
								Address = 32'd3;							//Select memory location.
								MS_2_0 = BYTE;							//Select the data size
								DataIn = 32'b10101010;						//Data to be written
								ReadWrite = 1'b0;
								CPUstate = 2'b01;
							end
						5'd4: //Writing a half-word
							begin
								Address = 32'd30;							//Select memory location.
								MS_2_0 = HALFWORD;							//Select the data size
								DataIn = 32'b1000000110000001;			//Data to be written
								ReadWrite = 1'b0;							//Perform write operation.
								CPUstate = 2'b01;
							end
						5'd5: //Writing a word
							begin
								Address = 32'd26;							//Select memory location.
								MS_2_0 = WORD;							//Select the data size
								DataIn = 32'b11000000000000000000000000000001;			//Data to be written
								ReadWrite = 1'b0;
								CPUstate = 2'b01;
							end

//Reading Again

						5'd6: //Reading a byte
							begin
								Address = 32'd3;					//Select memory location.
								MS_2_0 = BYTE;					//Select the data size
								ReadWrite = 1'b1;					//Perform read operation.
								CPUstate = 2'b01;
							end
						5'd7: //Reading a half-word
							begin
								Address = 32'd30;					//Select memory location.
								MS_2_0 = HALFWORDe;					//Select the data size.
								ReadWrite = 1'b1;					//Perform read operation.
								CPUstate = 2'b01;
							end
						5'd8: //Reading a word
							begin
								Address = 32'd26;					//Select memory location.
								MS_2_0 = WORD;					//Select the data size.
								ReadWrite = 1'b1;
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
		$display("MOV 	MOC 	CLK CaseCounter CPUstate DataOut	TIME");
		$monitor("%b 	%b 	%b     %d         %d  %b %d",MOV, MOC, CLK, CaseCounter, CPUstate, ram256x8.ram256x8_cREC.DataOut, $time);
	end

always @(MOC)
	begin
		if(MOC)							//If the RAM signals it completed the current operation and the operation was read,
			if(ReadWrite) 				//Avoid storing data from write operations.
				$fdisplay(fo,"Contents of memory location %d are %b",Address, DataOut);		//Place the bits in the output bus of the RAM in a file.
			//Note that you must read from memory in order to write in the ouput file.
	end

endmodule // ram256x8_tb
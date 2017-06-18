module ram256x8_cREC_tb;

	//Inputs
	reg MOV;						//Indicates memory that an operation will be performed.
	reg ReadWrite;				//Indicates memory which type of operation will be performed.
	reg [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	reg [31:0] DataIn;			//Input bus of data of the RAM.
	reg [31:0] Address;			//Indicates the memory location to be accessed.
	reg MOCoff;
	
	//Outputs
	output wire MOC;						//Indicates if memory operation finished.
	output wire [31:0] DataOut;

	//Simulation Parameters
	parameter sim_time = 70;
	
	
	parameter BYTE = 3'b000; //byte w/o sign extension
	parameter HALFWORD = 3'b001; //halfword w/o sign extension
	parameter WORD = 3'b010; //byte w/o sign extension
	parameter BYTEe = 3'b100; //byte w sign extension
	parameter HALFWORDe = 3'b101; //halfword w sign extension
	parameter WORDe = 3'b110; //word w sign extension

	integer fi, fo, code;
	reg [31:0] data;			//Dummy variable used to pre-charge RAM.
	reg [3:0] CaseCounter; 
	reg CLK;

	//Call the memory module
	ram256x8_cREC ram256x8_cREC (MOV, ReadWrite, MS_2_0, DataIn, Address, MOCoff, MOC, DataOut);

	//Simulation

		//Memory Pre-Charge
		initial 
			begin
				fi = $fopen("ramdata.txt", "r");				//Open the input file.
				Address = 32'd0;								//Set the initial Address in memory to begin pre-charge.
				while (!$feof(fi)) 
					begin					//Keep the file open until you reach its end.
						code = $fscanf(fi, "%b", data); 		//Read a line of the input file and store it in the dummy variable.
						ram256x8_cREC.memory[Address] = data;			//Store in the given Address of "memory" the data in the dummy variable.
						Address = Address + 1;					//Point to the next Address in order to continue pre-charge.
					end
				$fclose(fi);									//Close the input file.
			end													//Pre-charge ends

		//Interact with memory
		initial
			fork
				fo = $fopen("ramoutput.txt", "w");	//Open memory output file
				CaseCounter = 4'd0;
				MOV = 1'b0;
				ReadWrite = 1'd0;
				MS_2_0 = 3'd0;
				CLK = 1'b0;
			join

		always #5 CLK = ~CLK;	//Keep inverting the MOV signal to perform operations on memory.
		
		always@(CLK)
			begin
				case(CaseCounter)
					4'd0:
						begin
							fork
								Address = 32'd0;
								ReadWrite = 1'd1;
								MS_2_0 = BYTE;
							join
							MOV = 1'b1;
						end
					4'd1:
						begin
							fork
								Address = 32'd0;
								ReadWrite = 1'd1;
								MS_2_0 = HALFWORDe;
							join
							MOV = 1'b1;
						end
					4'd2:
						begin
							fork
								Address = 32'd0;
								ReadWrite = 1'd1;
								MS_2_0 = WORD;
							join
							MOV = 1'b1;
						end
					4'd3:
						begin
							fork
								Address = 32'd20;
								ReadWrite = 1'd0;
								MS_2_0 = BYTE;
								DataIn = 32'b10101010101010101010101011101110;
							join
							MOV = 1'b1;
						end
					4'd4:
						begin
							fork
								Address = 32'd200;
								ReadWrite = 1'd0;
								MS_2_0 = HALFWORD;
								DataIn = 32'b10101010101010101110111011101110;
							join
							MOV = 1'b1;
						end
					4'd5:
						begin
							fork
								Address = 32'd240;
								ReadWrite = 1'd0;
								MS_2_0 = WORD;
								DataIn = 32'b10000000000000011110111011101110;
							join
							MOV = 1'b1;
						end
					4'd6:
						begin
							fork
								Address = 32'd20;
								ReadWrite = 1'd1;
								MS_2_0 = BYTE;
							join
							MOV = 1'b1;
						end
					4'd7:
						begin
							fork
								Address = 32'd200;
								ReadWrite = 1'd1;
								MS_2_0 = HALFWORD;
							join
							MOV = 1'b1;
						end
					4'd8:
						begin
							fork
								Address = 32'd240;
								ReadWrite = 1'd1;
								MS_2_0 = WORD;
							join
							MOV = 1'b1;
						end
				endcase // CaseCounter
				#1 MOV = 1'd0;
				CaseCounter = CaseCounter + 1;
			end
			

initial
	begin
		$display("MOV 	CaseCounter 	DataOut 	TIME");
		$monitor("%b %d %b %d",MOV, CaseCounter,ram256x8_cREC.DataOut, $time);
	end

initial #sim_time $finish;

endmodule // ram256x8_cREC_tb
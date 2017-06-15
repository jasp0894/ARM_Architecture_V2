module ram256x8_c (MOV, ReadWrite, MS_2_0, DataIn, ExtAddress, CLK, MOCoff, MOC, DataOut);

	//Inputs
	input wire MOV;						//Indicates memory that an operation will be performed.
	input wire ReadWrite;				//Indicates memory which type of operation will be performed.
	input wire [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	input wire [31:0] DataIn;			//Input bus of data of the RAM.
	input wire [31:0] ExtAddress;		//Indicates the memory location to be accessed.
	input wire CLK;						//Clock signal.
	input wire MOCoff;					//

	//Outputs
	output reg MOC;						//Indicates if memory operation finished.
	output reg [31:0] DataOut;			//Output bus of the ram.

	//Internal
	reg [7:0] memory [255:0];
	reg [31:0] IntAddress;

	//Ram Implementation
	always@(MOV, MOCoff)
		fork
			if(MOV)
				if(ReadWrite)					//Perform read operation
					case (MS_2_0)		//Determine the data size and the sign extension.
						3'b000: begin	//Byte sized data.
								DataOut[7:0] = memory[ExtAddress];	//Place byte in output bus.
								MOC = 1'b1;					//Memory completed operation.
								end

						3'b001: begin	//Halfword sized data.
								//HalfWords can only be accessed through even addresses.
								fork
									DataOut[15:8] = memory[IntAddress & 1'b0];		//Big endian convention.
									DataOut[7:0] = memory[IntAddress & 1'b0 + 1];	//Read 2nd byte.	
								join
								MOC = 1'b1;
								end

						3'b010: begin	//Word sized data.
								//Words can only be accessed each four memory addresses.
								fork
									DataOut[31:24] = memory[IntAddress & 2'b00];
									DataOut[23:16] = memory[IntAddress & 2'b00 + 1];//Place 2nd byte on output bus.
									DataOut[15:8] = memory[IntAddress & 2'b00 + 2];	//Read 3rd byte on output bus.
									DataOut[7:0] = memory[IntAddress & 2'b00 + 3];	//Read 4th byte on output bus.	
								join
								MOC = 1'b1;
								end
					endcase

				else	//PERFORM READ OPERATION

					case (MS_2_0)		//Determine the data size and the sign extension.
						3'b000: begin	//Byte sized data.
								memory[ExtAddress] = DataIn[7:0]; 	//Place byte in output bus.
								MOC = 1'b1;					//Memory completed operation.
								end

						3'b001: begin	//Halfword sized data.
								//HalfWords can only be accessed through even addresses.
								fork
									memory[IntAddress & 1'b0] = DataIn[15:8];		//Big endian convention.
									memory[IntAddress & 1'b0 + 1] = DataIn[7:0];	//Read 2nd byte.	
								join
								MOC = 1'b1;
				  				end

						3'b010: begin	//Word sized data.
								//Words can only be accessed each four memory addresses.
								fork
									memory[IntAddress & 2'b00] = DataIn[31:24];
									memory[IntAddress & 2'b00 + 1] = DataIn[23:16];//Place 2nd byte on output bus.
									memory[IntAddress & 2'b00 + 2] = DataIn[15:8];	//Read 3rd byte on output bus.
									memory[IntAddress & 2'b00 + 3] = DataIn[7:0];	//Read 4th byte on output bus.	
								join
								MOC = 1'b1;
								end
					endcase
			

			if(MOCoff)
				MOC = 1'b0;
		join

endmodule // ram256x8_c
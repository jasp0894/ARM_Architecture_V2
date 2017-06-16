module ram256x8_c (MOV, ReadWrite, MS_2_0, DataIn, Address, MOCoff, MOC, DataOut);

	//Inputs
	input wire MOV;						//Indicates memory that an operation will be performed.
	input wire ReadWrite;				//Indicates memory which type of operation will be performed.
	input wire [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	input wire [31:0] DataIn;			//Input bus of data of the RAM.
	input wire [31:0] Address;		//Indicates the memory location to be accessed.
	input wire MOCoff;
	
	//Outputs
	output reg MOC;						//Indicates if memory operation finished.
	output reg [31:0] DataOut;			//Output bus of the ram.

	//Internal
	reg [7:0] memory [0:255];
	//reg [31:0] internaladdress;
	
	//Ram Implementation
	always@(MOV, MOCoff)
		begin
		fork
			if(MOV)
				begin
					//internaladdress <= Address;
					if(ReadWrite)			//PERFORM READ OPERATION
						begin
							if(MS_2_0[1:0] == 2'b00)	//Byte sized data.
								begin
									fork
										DataOut[7:0] = memory[Address];	//Place byte in output bus.
										//Sign extension.
										if(MS_2_0[2] == 1'b1)	//If true perform sign extension.
											if(memory[Address][7] == 1'b0)	//If MSB is zero
												DataOut[31:8] = 24'd0;			//Sign extend with zeros.
											else								//MSB was one.
												DataOut[31:8] = 24'b111111111111111111111111;			//Sign extedn with ones.
										else	//Fill the rest of the bits with 0's
											DataOut[31:8] = 24'd0;
									join
									MOC = 1'b1;							//Memory completed operation.
								end
							else if (MS_2_0[1:0] == 2'b01)	//Halfword sized data.
								begin
									//HalfWords can only be accessed through even addresses.
									fork
										DataOut[15:8] = memory[Address & 1'b0];		//Big endian convention.
										DataOut[7:0] = memory[(Address & 1'b0) + 1];	//Read 2nd byte.
										//Sign extension
										if(MS_2_0[2] == 1'b1)	//If true perform sign extension.
											if(memory[Address][15] == 1'b0)	//If MSB is zero
												DataOut[31:16] = 16'd0;			//Sign extend with zeros.
											else								//MSB was one.
												DataOut[31:16] = 16'b1111111111111111;			//Sign extedn with ones.
										else	//Fill the rest of the bits with 0's
											DataOut[31:16] = 16'd0;
									join
									MOC = 1'b1;									//Indicate memory finished executing the task.
								end
							else if(MS_2_0[1:0] == 2'b10)	//Word sized data.
								begin	
									//Words can only be accessed each four memory addresses.
									fork
										DataOut[31:24] = memory[Address & 2'b00];
										DataOut[23:16] = memory[(Address & 2'b00) + 1];//Place 2nd byte on output bus.
										DataOut[15:8] = memory[(Address & 2'b00) + 2];	//Read 3rd byte on output bus.
										DataOut[7:0] = memory[(Address & 2'b00) + 3];	//Read 4th byte on output bus.	
									join
									MOC = 1'b1;									//Indicate memory finished executing the task.
								end
							else //This is used to avoid falling into any other combination not supported.
								begin
								end
						end

					else	//PERFORM WRITE OPERATION
						
						//begin
							case(MS_2_0)

								3'b000:
									begin
										memory[Address] = DataIn[7:0]; 	//Place byte in output bus.
										MOC <= 1'b1;							//Memory completed operation.
									end
							/*
								3'b001:
									begin	
									//HalfWords can only be accessed through even addresses.
										//fork
											internaladdress = internaladdress & 1'b0;
											memory[Address & 1'b0] = DataIn[15:8];		//Big endian convention.
											memory[(Address) & 1'b0 + 1] = DataIn[7:0];	//Read 2nd byte.
										//join
									MOC = 1'b1;									//Indicate memory finished executing the task.
						  			end
						  	*/
							/*
							if(MS_2_0[1:0] == 2'b00)	//Byte sized data.
								begin
									memory[Address] <= DataIn[7:0]; 	//Place byte in output bus.
									MOC <= 1'b1;							//Memory completed operation.
								end
							*/
							/*
							else if(MS_2_0[1:0] == 2'b01)	//Halfword sized data.
								begin	
									//HalfWords can only be accessed through even addresses.
									fork
										memory[Address & 1'b0] <= DataIn[15:8];		//Big endian convention.
										memory[(Address & 1'b0) + 1] <= DataIn[7:0];	//Read 2nd byte.
									join
									MOC = 1'b1;									//Indicate memory finished executing the task.
						  		end
						  	*/
						  	/*
						  	else if(MS_2_0[1:0] == 2'b10)	//Word sized data.
								begin
									//Words can only be accessed each four memory addresses.
									//fork
										memory[Address & 2'b00] = DataIn[31:24];
										memory[(Address & 2'b00) + 1] = DataIn[23:16];//Place 2nd byte on output bus.
										memory[(Address & 2'b00) + 2] = DataIn[15:8];	//Read 3rd byte on output bus.
										memory[(Address & 2'b00) + 3] = DataIn[7:0];	//Read 4th byte on output bus.	
									//join
									MOC <= 1'b1;									//Indicate memory finished executing the task.
								end
							else	//This is used to avoid falling into any other combination not supported.
								begin
								end
							*/
							endcase // MS_2_0
						//end
				end
			//MOC signal management.
			begin
				if(MOCoff)
					MOC = 1'b0;	//Turn off the MOC signal
			end
		join
		end
endmodule // ram256x8_c
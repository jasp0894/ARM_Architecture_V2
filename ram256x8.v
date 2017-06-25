module ram256x8 (MOV, ReadWrite, MS_2_0, DataIn, Address, CLK, MOC, DataOut, RESET);

	//Inputs
	input wire MOV;						//Indicates memory that an operation will be performed.
	input wire ReadWrite;				//Indicates memory which type of operation will be performed.
	input wire [2:0] MS_2_0;			//Allows selection of the data size and indicates if the data is signed?
	input wire [31:0] DataIn;			//Input bus of data of the RAM.
	input wire [31:0] Address;			//Indicates the memory location to be accessed.
	input wire CLK, RESET;						//Clock signal.

	//Outputs
	output wire MOC;					//Indicates if memory operation finished.
	output wire [31:0] DataOut;			//Output bus of the ram.

	//Internal Connections
	wire MOCoff;
	
	//Ram Implementation
	ram256x8_cREC ram256x8_cREC (MOV, ReadWrite, MS_2_0, DataIn, Address, MOCoff, MOC, DataOut);
	ram256x8_s ram256x8_s (CLK, RESET, MOC, MOCoff);

endmodule // ram256x8
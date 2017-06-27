module ControlRegister_pepo (D, Enable, CLK, Q_cu, Q_datapath);

	//Inputs
	input wire [64:0] D;	//Input data to the register
	input wire Enable;		//Indicates if the register will latch or not.
	input wire CLK;

	//Outputs
	output reg [34:0] Q_datapath;	//Output data of the register
	output reg [29:0] Q_cu;
//Output initialization

//reg reset=1'b1;

always @ (posedge CLK)
	if(Enable)
		fork
			Q_cu = D[64:35];	  //Control unit internal signals.
			Q_datapath = D[34:0]; //Datapath signals.
		join
endmodule // ControlRegister
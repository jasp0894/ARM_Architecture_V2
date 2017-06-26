module RegisterFile_tb_pepo;

	//DUT output signals
	output wire [31:0] PA;
	output wire [31:0] PB;
	output wire [31:0] PC;
	
	//DUT input signals
	reg CLK;
	reg RFLD;
	reg [3:0] A;
	reg [3:0] B;
	reg [3:0] C;
	reg RESET;

	//Simulation Controls

	//Simulation parameters
	parameter sim_time = 100;

	//Simulation
	initial 
		begin
			CLK = 1'b0;
			repeat (1000)
			#2 CLK = ~CLK;
		end

	initial
		fork
			RESET = 1;
			#6 RESET = 0;
		join

	always@(posedge CLK)
		
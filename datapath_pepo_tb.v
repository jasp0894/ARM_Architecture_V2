module datapath_pepo_tb;

	//DUT Input Signals
	reg [33:0] cu_datapath;
	reg CLK;
	reg RESET;

	//DUT Output signals
	wire [31:0] IR_OUT;
	wire LSM_DETECT;
	wire LSM_END;
	wire MOC;
	wire COND;

	//Simulation Controls
	reg [5:0] rom_counter;

	//Call Modules
	datapath_pepo datapath_pepo (cu_datapath, CLK, RESET, IR_OUT, LSM_DETECT, LSM_END, MOC, COND);

	//Simulation Parameters
	parameter sim_time = 100;

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
			rom_counter = 6'd0;
		join

	always@(posedge CLK)
		if(rom_counter < 6'd5)
			begin
				case(rom_counter)
					 6'd0: cu_datapath = 34'b0000000000000000000000000000000000;
					 6'd1: cu_datapath = 34'b0001000010000000001000000100000000;
					 6'd2: cu_datapath = 34'b0100011010000010001000100100000000;
					 6'd3: cu_datapath = 34'b0010011000000000000000000100000000;
					 6'd4: cu_datapath = 34'b0000000000000000000000000000000000;
					6'd10: cu_datapath = 34'b1100000000010110100000000000000000;
					6'd11: cu_datapath = 34'b1100000000010110100000000000000000;
					6'd14: cu_datapath = 34'b1000000000010110100000000000000000;
					6'd15: cu_datapath = 34'b1000000000010110100000000000000000;
					6'd16: cu_datapath = 34'b0001000000010001000000000000000000;
					6'd17: cu_datapath = 34'b0001000000010001000000000000000000;
					6'd18: cu_datapath = 34'b0100000000110000001100100000000000;
					6'd19: cu_datapath = 34'b0001000000000000001000000000000000;
					6'd20: cu_datapath = 34'b0100000000010001000000000000000000;
					6'd21: cu_datapath = 34'b0001000000000001000000000000000000;
					6'd22: cu_datapath = 34'b0001000000000001000000000000000000;
					6'd23: cu_datapath = 34'b0001000000000000001000000000000000;
					6'd24: cu_datapath = 34'b0100000000000001000000000000000000;
					6'd25: cu_datapath = 34'b0000001000000000000000010000000011;
					6'd26: cu_datapath = 34'b0000101000000000010000010000000011;
					6'd27: cu_datapath = 34'b1000000000100110001100100000000000;
					6'd28: cu_datapath = 34'b0000100110000000001000000000000000;
					6'd29: cu_datapath = 34'b0000001000000000000000010000000011;
					6'd30: cu_datapath = 34'b0001000000000000001000000001001000;
					6'd31: cu_datapath = 34'b0001000000000001100000000001001000;
					6'd32: cu_datapath = 34'b0000000000000000000000000001000000;
					6'd33: cu_datapath = 34'b0000000000000000000000000001000000;
					6'd34: cu_datapath = 34'b0000001000000000000000000101000100;
					6'd35: cu_datapath = 34'b0000100100000000001000000001000000;
					6'd36: cu_datapath = 34'b0000100000000000010000000000000000;
					6'd37: cu_datapath = 34'b0100000000101000001100100001000000;
					6'd38: cu_datapath = 34'b0000000000000000000000000000000000;
					6'd39: cu_datapath = 34'b0001000000110001100000000001000000;
					6'd40: cu_datapath = 34'b0000000000000000000000000000000000;
					6'd41: cu_datapath = 34'b1100000000110000001100100000000000;
					6'd42: cu_datapath = 34'b0000000000000000000000000001000000;
					6'd43: cu_datapath = 34'b0000000000000000000000000000000000;
					6'd44: cu_datapath = 34'b0100000010000100001000000000000000;
					6'd45: cu_datapath = 34'b0100000010010010001010100000000000;
					6'd46: cu_datapath = 34'b0001000000010001000000000000000000;
					6'd47: cu_datapath = 34'b0001000000010001000000000000000000;
					6'd48: cu_datapath = 34'b0001000000000000001000000000000000;
					6'd49: cu_datapath = 34'b0001000000000001000000000000000000;
					6'd50: cu_datapath = 34'b0001000000000001000000000000000000;
					6'd51: cu_datapath = 34'b0001000000000000001000000000000000;
				endcase // rom_counter
			
				rom_counter <= rom_counter + 1;

			end

		else
			rom_counter = 6'd1;

		//Signal Monitoring
		initial
			begin
				$display("RF_PA		rom_counter	 ALU_OUT	MC_OUT	MA_OUT	CLK");
			end
		always @(posedge CLK)
			begin
				$monitor("%d 	%d		%d %d %d	%d",datapath_pepo.RF.PA, rom_counter, datapath_pepo.ALU_OUT, 
						datapath_pepo.MC_OUT,
						datapath_pepo.MA_OUT,
						CLK);
			end

initial #sim_time $finish;

endmodule // datapath_pepo_tb
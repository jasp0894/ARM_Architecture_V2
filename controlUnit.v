
//---------------------ROM 2^8 cells of 64 bits----------------------
module controlUnit(output [31:0] CU, input [31:0] IR, input MOC, COND, MLS0, MLS1, CLK);
	
	
	//63     62   61   60   59   58     57     56-54   53  52  51  50-48  47    46     45    44      43    42   41  40   39   38   37   36   35   34   33   32   31   30   29  28   27  26   25   24   23      22        21       20    19   18     17      16      15-8      7-0
	//                                         N2-N0  INV  MS  MI  S2-S0  FRLd  RFLd  IRLd  MARLd  MDRLd  R/W  MOV  DS1  DS0  CIN  MA1  MA0  MB2  MB1  MB0  MC2  MC1  MC0  MD  ME  OP4  OP3  OP2  OP1  OP0  LDMAHR1  LDMAHR0  LoadCNT  CCSP  CST  LDOHR  CLROHR  CR15-CR8  CR7-CR0



	//wires
	wire[1:0] M1M0;
	wire MC_OUT, INV_OUT, ADDER_COUT ;

	wire[7:0] CR15_8, CR7_0,MD_OUT,ADD_OUT,INC_REG_OUT,ME, MA_OUT, ENC_OUT;

	wire[63:0] CTL_REG_OUT,ROM_OUT;

	wire CU;

	always @ (CLK);

			


		    Encoder encoder(ENC_OUT,IR);

		    mux_8x1 muxC (MC_OUT,CTL_REG_OUT[50:48], MOC, COND, IR[23], IR[22], MLS0, MLS1,1'd0,1'd0);

		    InverterCU inv(INV_OUT, MC_OUT,CTL_REG_OUT[53]);
		    
			AdderCU adder (ADD_OUT,ADDER_COUT,MD_OUT,8'd1,1'd0);

		
			Reg8bits incrementerRegister(INC_REG_OUT,ADD_OUT,1'd1,CLK);

			mux_2x1 muxE(ME,CTL_REG_OUT[51],INC_REG_OUT,CR15_8);

			mux_4x1 muxA(MA_OUT,M1M0,ENC_OUT,8'd0,CR7_0,ME);

			mux_2x1 muxD(MD_OUT, CTL_REG_OUT[52],MA_OUT,CR7_0);
	

			rom ROM(ROM_OUT,MA_OUT);

			ControlRegister ctl_register(CTL_REG_OUT, ROM_OUT,1'd1,CLK);

			NextStateAdd nextState(M1M0, CTL_REG_OUT[56:54], INV_OUT);

			

			


endmodule //

//Estas atras Gilipot

//---------------------ROM 2^8 cells of 64 bits----------------------
module rom_64bits_pepo (output reg [63:0] OUT,  input [7:0] IN);

//IN contains a codified instruction
//OUT will provde an array of all control variables needed to execute an instruction
//The format is the following:

//63 62 61 60 59 58      57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0
//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0 MJLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF

always @ (IN)

case(IN)

////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////

8'd0: OUT = 64'b0000000110000000000000000000000000000000000000000000000000000000;
8'd1: OUT = 64'b0000000110000000000000000000000001000010000000001000000100000000;
8'd2: OUT = 64'b0000000110000000000000000000000100011010000010001000100100000000;
8'd3: OUT = 64'b0000000111000000000000000000110010011000000000000000000100000000;
8'd4: OUT = 64'b0000001001000100000000000000010000000000000000000000000000000000;
8'd10: OUT = 64'b0000000100000000000000000000011100000000010110100000000000000000;
8'd11: OUT = 64'b0000000100000000000000000000011100000000010110100000000000000000;
8'd14: OUT = 64'b0000000100000000000000000000011000000000010110100000000000000000;
8'd15: OUT = 64'b0000000100000000000000000000011000000000010110100000000000000000;
8'd16: OUT = 64'b0000001010101000011100000110010001000000010001000000000000000000;
8'd17: OUT = 64'b0000000110000000000000000000000001000000010001000000000000000000;
8'd18: OUT = 64'b0000001010101000011100000110010100000000110000001100100000000000;
8'd19: OUT = 64'b0000000110000000000000000000000001000000000000001000000000000000;
8'd20: OUT = 64'b0000001010101000011100000110010100000000010001000000000000000000;
8'd21: OUT = 64'b0000001010101000011100000110010001000000000001000000000000000000;
8'd22: OUT = 64'b0000000100000000000000000100100001000000000001000000000000000000;
8'd23: OUT = 64'b0000000110000000000000000000000001000000000000001000000000000000;
8'd24: OUT = 64'b0000001010101000011100000110010100000000000001000000000000000000;
8'd25: OUT = 64'b0000001011001000011101000111010000001000000000000000010000000011;
8'd26: OUT = 64'b0000001011000000000000000110100000100000000000010000010000000011;
8'd27: OUT = 64'b0000000100000000000000000000011000000000100110001100100000000000;
8'd28: OUT = 64'b0000000100000000000000000110010000100110000000001000000000000000;
8'd29: OUT = 64'b0000001011100000000001000111010000001000000000000000010000000011;
8'd30: OUT = 64'b0000000100000000000000001000000001000000000000001000000001001000;
8'd31: OUT = 64'b0000000110000000000000000000000001000000000001100000000001001000;
8'd32: OUT = 64'b0000001011001100000000001010100000000000000000000000000001000000;
8'd33: OUT = 64'b0000001011001000000000001000110000000000000000000000000001000000;
8'd34: OUT = 64'b0000001011101000100100001001100000001000000000000000000101000100;
8'd35: OUT = 64'b0000000100000000000000001000100000100100000000001000000001000000;
8'd36: OUT = 64'b0000001011000000000000001001000000100000000000010000000000000000;
8'd37: OUT = 64'b0000000100000000000000001001110100000000101000001100100001000000;
8'd38: OUT = 64'b0000001011000000000000001001100000000000000000000000000000000000;
8'd39: OUT = 64'b0000001011010000000000001010110001000000110001100000000001000000;
8'd40: OUT = 64'b0000001011010100000000000001000000000000000000000000000000000000;
8'd41: OUT = 64'b0000000100000000000000000001001100000000110000001100100000000000;
8'd42: OUT = 64'b0000001010010000000000001010000000000000000000000000000001000000;
8'd43: OUT = 64'b0000000100000000000000001000000000000000000000000000000000000000;
8'd44: OUT = 64'b0000000110000000000000000000000100000010000100001000000000000000;
8'd45: OUT = 64'b0000000100000000000000000000010100000010010010001010100000000000;

8'd46: OUT = 64'b0000000100000000000000000100100001000000010001000000000000000000;
8'd47: OUT = 64'b0000001010101000011100000110010001000000010001000000000000000000;
8'd48: OUT = 64'b0000000100000000000000000101000001000000000000001000000000000000;
8'd49: OUT = 64'b0000000100000000000000000100100001000000000001000000000000000000;
8'd50: OUT = 64'b0000001010101000011100000110010001000000000001000000000000000000;
8'd51: OUT = 64'b0000000100000000000000000110000001000000000000001000000000000000;




endcase //IN

endmodule //




//Duuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuureeeexxxxxxxxxxxxxxx!
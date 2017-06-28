
//---------------------ROM 2^8 cells of 64 bits----------------------
module rom (output reg [64:0] OUT,  input [7:0] IN);

//IN contains a codified instruction
//OUT will provde an array of all control variables needed to execute an instruction
//The format is the following:

//64 63 62 61 60 59      58-56  55 54 53-51   50-43    42-35  34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0
//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0  MK  MJLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF

always @ (IN)

case(IN)

//////////////////////////////////////////////////////////////








////////////////////////////////////////////////////////////////

 8'd0: OUT = 65'b00000001100000000000000000000000000000000000000000000000000000000;
 8'd1: OUT = 65'b00000101100000000000000000000000001000010000000001000000100000000;
 8'd2: OUT = 65'b00001001100000000000000000000000100010010000010001000100100000000;
 8'd3: OUT = 65'b00001101110000000000000000001100010011000000000000000000100000000;
 8'd4: OUT = 65'b00010010010001000000000000000100000000000000000000000000000000000;
8'd10: OUT = 65'b00101001000000000000000000000101100000000010110100000000000000000;
8'd11: OUT = 65'b00101101000000000000000000000101100000000010110100000000000000000;
8'd14: OUT = 65'b00111001000000000000000000000101000000000010110100000000000000000;
8'd15: OUT = 65'b00111101000000000000000000000101000000000010110100000000000000000;
8'd16: OUT = 65'b01000010101010000111000001100100001000000010001000000000000000000;
8'd17: OUT = 65'b01000101100000000000000000000000001000000010001000000000000000000;
8'd18: OUT = 65'b01001010101010000111000001100100100000000110000001100100000000000;
8'd19: OUT = 65'b01001101100000000000000000000000001000000000000001000000000000000;
8'd20: OUT = 65'b01010010101010000111000001100100100000000010001000000000000000000;
8'd21: OUT = 65'b01010110101010000111000001100100001000000100111000000000000000000;
8'd22: OUT = 65'b01011001000000000000000001001000001000000000001000000000000000000;
8'd23: OUT = 65'b01011101100000000000000000000000001000000000000001000000000000000;
8'd24: OUT = 65'b01100010101010000111000001100100100000000000001000000000000000000;
8'd25: OUT = 65'b01100110110010000111010001110100000000000000000000000010000000011;
8'd26: OUT = 65'b01101010110000000000000001101000000101000000000010000010000000011;
8'd27: OUT = 65'b01101101000000000000000000000100100000000100110001100100000000000;
8'd28: OUT = 65'b01110001000000000000000001100100000100110000000001000000000000000;
8'd29: OUT = 65'b01110110111000000000010001110100000001000000000000000010000000011;
8'd30: OUT = 65'b01111001000000000000000010000000001000000000000001000000001001000;
8'd31: OUT = 65'b01111101100000000000000000000000001000000000001100000000001001000;
8'd32: OUT = 65'b10000010110011000000000010101000000000000000000000000000001000000;
8'd33: OUT = 65'b10000110110010000000000010001100000000000000000000000000001000000;
8'd34: OUT = 65'b10001010111010001001000010011000000001000000000000000000101000100;
8'd35: OUT = 65'b10001101000000000000000010001000000100100000000001000000001000000;
8'd36: OUT = 65'b10010010110000000000000010010000000100000000000010000000000000000;
8'd37: OUT = 65'b10010101000000000000000010011100100000000101000001100100001000000;
8'd38: OUT = 65'b10011010110000000000000010011000000000000000000000000000000000000;
8'd39: OUT = 65'b10011110110100000000000010101100001000000110001100000000001000000;
8'd40: OUT = 65'b10100010110101000000000000010000000000000000000000000000000000000;
8'd41: OUT = 65'b10100101000000000000000000010000100000000110000001100100000000000;
8'd42: OUT = 65'b10101010100100000000000010100000000000000000000000000000001000000;
8'd43: OUT = 65'b10101101000000000000000010000000000000000000000000000000000000000;
8'd44: OUT = 65'b10110001100000000000000000000010100000010000100001000000000000000;
8'd45: OUT = 65'b10110101000000000000000000000110100000010010010001010100000000000;
8'd46: OUT = 65'b10111001000000000000000001001000001000000010001000000000000000000;
8'd47: OUT = 65'b10111110101010000111000001100100001000000010001000000000000000000;
8'd48: OUT = 65'b11000001000000000000000001010000001000000000000001000000000000000;
8'd49: OUT = 65'b11000101000000000000000001001000001000000000001000000000000000000;
8'd50: OUT = 65'b11001010101010000111000001100100001000000000001000000000000000000;
8'd51: OUT = 65'b11001101000000000000000001100000001000000000000001000000000000000;

endcase //IN

endmodule //




//Duuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuureeeexxxxxxxxxxxxxxx!










































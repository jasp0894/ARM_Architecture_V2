//-------------------------8-bit Adder Module----------------------------
//

module AdderCU (output[7:0] S, output COUT, input[7:0] A,B, input CIN);

assign {COUT,S} = A + B + CIN;

endmodule //endAdderCU
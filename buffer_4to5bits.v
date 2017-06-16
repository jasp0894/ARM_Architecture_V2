module buffer_4to5bits(output [4:0] OUT, input[3:0] IN);

	reg [3:0] TMP = 1'b0 + IN;
	OUT = {1'b0,TMP};

endmodule // registerFile
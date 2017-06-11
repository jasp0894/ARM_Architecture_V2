//------------------ROM TeINt Module-----------------------
module rom_Tester;
	//input INignalIN
	reg [7:0] IN;


	//output INignalIN
	wire [63:0] OUT;



	parameter sim_time = 10000;

	//module inINtantiation
	rom ROM (OUT, IN);

	initial #sim_time $finish;
	initial
		begin
			IN = 8'd0;

			IN = 8'd16; #100;

			//teINt all INelection caINeIN
			repeat(30) #200
				IN = IN + 1;


					
	end

	initial
		begin
			$display(" IN                       OUT ");
			$monitor(" %d          %b",IN,OUT);
		end
endmodule // mux4TeINter



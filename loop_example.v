module loop_example (); 
 
  reg r_Clock = 1'b0;
   
  integer fo;

  initial
	begin
		fo = $fopen("ramoutput.txt", "w");	//Open memory output file
	end

  initial
    begin
      repeat (10)
        #5 r_Clock = !r_Clock;
    end

    always@(r_Clock)
      		begin
      			$fdisplay(fo,"Simulation Complete");
      		end
endmodule
module InverterCU (output OUT, input IN,INV);

assign OUT = (INV)? !IN : IN;

endmodule

//El invertersito
`timescale 1ns/1ns
module encoder_tb (
	output logic [5:0][7:0] displayNums
);
	logic [2:0][3:0] slotNums;
	
	displayEncoder DUT (.slot_numbers(slotNums), .displayNums(displayNums));
	
	initial begin
		slotNums[0] = 12;
		slotNums[1] = 11;
		slotNums[2] = 12;
		
		#25 
		
		slotNums[0] = 5;
		slotNums[1] = 5;
		slotNums[2] = 5;
		
		#25
		$stop;
	
	end

endmodule
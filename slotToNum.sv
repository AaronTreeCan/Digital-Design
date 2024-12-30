module slotToNum (
	input wire [2:0][3:0] slots,
	output logic [5:0][3:0] slotNums
);
	
	always_comb begin
		// order is assuming slotNums[0] is most left, and should be ten's place
		
		// process 1st slot
		slotNums[1] = slots[0] % 10;
		slotNums[0] = (slots[0] / 10) % 10; 
		
		// process 2nd slot
		slotNums[3] = slots[1] % 10;
		slotNums[2] = (slots[1] / 10) % 10; 
		
		// process 3rd slot
		slotNums[5] = slots[2] % 10;
		slotNums[4] = (slots[2] / 10) % 10; 
		
	end
		
endmodule
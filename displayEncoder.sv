module displayEncoder(
	input wire [5:0][3:0] slot_numbers, 
	output logic [5:0][7:0] displayNums
);
 
	// Generate 6 encoders to convert slot nums to display codes.
	genvar i;
	generate 
		for (i = 0; i < 6; i++) begin : genEncoders
			sevenSegDigit encoders (.digit(slot_numbers[i]), .displaydigits(displayNums[i]));
		end
	endgenerate
	
endmodule
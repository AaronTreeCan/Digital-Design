module sevenSegDigit(
	input logic [3:0] digit, 
	output logic [7:0] displaydigits
);
	always_comb begin
		case(digit) 
			// remember A corresponds to LSB, with G being MSB
			// 1 is off 0 is on
			// default decimal point is off = 1
			4'd0: displaydigits = 8'b11000000; // G is off
			4'd1: displaydigits = 8'b11111001; // only B & C are on
			4'd2: displaydigits = 8'b10100100; // C & F are off
			4'd3: displaydigits = 8'b10110000; // F & E are off
			4'd4: displaydigits = 8'b10011001; // A, E, D are off
			4'd5: displaydigits = 8'b10010010; // B, E are off
			4'd6: displaydigits = 8'b10000010; // B off
			4'd7: displaydigits = 8'b11111000; // A, B, C on
			4'd8: displaydigits = 8'b10000000; // all on except decimal
			4'd9: displaydigits = 8'b10011000; // E, D off
			default: displaydigits = 8'b11111111; // display nothing
		endcase
	end
	
endmodule
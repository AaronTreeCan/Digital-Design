/*
	IMPORTANT: The default value of slot must not be 0 in order for the 
	shift register to work or else it just stays 0.
*/
module slot (
	input logic clk,
	input logic running,
	input logic rst,
	
	output logic [3:0] shift_reg
);

	// if running is active, outputs new random number every clock cycle
	// else it will output shift_register constantly
	
	logic [3:0] updated; // new shifted value
	
	always_comb begin
		
		// right shift bits + XOR last 2
		updated = {
				(shift_reg[2] ^ shift_reg[3]), // XOR operation
				shift_reg[0], 
				shift_reg[1], 
				shift_reg[2]};
				
	end 
	
	/*
		Using asynchronous rst because slot clk is too slow. Rst pulse 
		may not be long enough to be captured by the divided clk 
		(slow clk necessary for visible number changing).
	*/
	always @(posedge clk or posedge rst) begin

		// set shift register to default value on reset
		if (rst) begin
			shift_reg <= 11;
		end
		else begin
			// update shift register with shift if running is high
			if (running) begin
				shift_reg <= updated;
			end		
		end
	end
	
endmodule
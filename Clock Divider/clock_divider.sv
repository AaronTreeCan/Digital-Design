/*
	Using Hz as the unit. 
	speed holds up to 1 million Hz to meet 1Mhz requirement.
	counter & clkRatio hold up to 50 million to enable slowest speed of 1Hz.
	
	outClk is the calculated signal based on clockRatio and counter.
	outClk_d is the output flip-flop only updated on clk edge.
*/

module clock_divider #(parameter [25:0] BASE=50_000_000) (
	input logic [19:0] speed,
	input logic clk, 
	input logic rst, 
	
	output logic outClk_d 
);

	// necessary registers & buses
	logic [25:0] counter; 
	logic [25:0] clkRatio; 
	logic outClk; 
	
   // calculate clkRatio
	always_comb begin
		// added a safety check in case of % by 0
		if (speed != 0) begin
			clkRatio = BASE / speed;
		end 
		else begin
			clkRatio = 0;
		end
	end
	
	// calculate next clk cycle's signal
	always_comb begin  
		// switch signal halfway -> ensures 50% duty cycle
		if (counter < (clkRatio / 2) ) begin 
			outClk = 0; 
		end 
		else begin
			outClk = 1;
		end
	end
	
	// all sequential blocks use synchronous reset
	// counter
	always_ff @(posedge clk) begin
		if (rst) begin
			counter <= 0;
		end
		else begin
			if (counter < (clkRatio - 1)) begin
					counter <= counter + 1;
			end 
			else begin
				counter <= 0; 
			end	
		end
	end
	
	// update flip flop
	always_ff @(posedge clk) begin
		if (rst) begin 
			outClk_d <= 0;
		end 
		else begin
			outClk_d <= outClk;
		end
	end

endmodule 
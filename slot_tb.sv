`timescale 1ns/1ns
module slot_tb (
	output logic [3:0] shift_reg
);
	logic running;
	logic clk;
	logic rst;
	
	slot DUT (.clk(clk), .running(running), .rst(rst), .shift_reg(shift_reg));
	
	always begin
		// alternating clock
		#10 clk = ~clk;
	end
	
	initial begin 
		clk = 0;
		rst = 1;
		running = 0;
		
		#30 rst = 0;;
		
		// activate rst after 50 ns for 15ns to set to 11
		// wait 50ns to see if value stays
		
		running = 1; // turn on running
		
		#100 // run for 50ns to see if it generates 7 random numbers
		running = 0; // see if it stays on stop for 100 ns
		
		#100 $stop;
	end 
		
endmodule 
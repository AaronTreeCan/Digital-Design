`timescale 1ns/1ns
module clockDivider_tb(
	output logic [0:0] tb_outClk
);

	logic tb_clk; 
	logic tb_rst;
	logic [19:0] tb_speed;
	
	clock_divider DUT(.speed(tb_speed), .clk(tb_clk), .rst(tb_rst), .outClk_d(tb_outClk));
	
	// switch clock every 10 ns
	always begin
		#10 tb_clk = ~tb_clk;
	end
	
	initial begin 
		tb_clk = 0;
		tb_rst = 0;
		tb_speed = 1 * 1_000_000; //(1 MHz clock)
		
		#2000 tb_rst = 1;
		#10 tb_rst = 0; // test reset
		
		#100000 $stop;
	end
	
endmodule
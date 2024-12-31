`timescale 1ns/1ns
module slotFSM_tb (
	output logic [2:0][3:0] displayNums,
	output logic slotRunning,
	output logic buzzer
);

	logic [2:0][3:0] slotNums;
	logic clk;
	logic rst;
	logic button;
	logic blinkClk; // unused for now
	
	always begin
		// alternating clock for state transition
		#10 clk = ~clk;
	end
	
	always begin
		// alternating clock for blinking
		#10 blinkClk = ~blinkClk;
	end
	
	slot_fsm DUT (.slotNums(slotNums), .clk(clk), .rst(rst), .button(button),
		.blinkClk(blinkClk), .displayNums(displayNums), .slotRunning(slotRunning),
		.buzzer(buzzer));
	
	initial begin
		
		slotNums = 0;
		rst = 0;
		clk = 0;
		button = 0;
		blinkClk = 0;
		buzzer = 0;
		// SET state should activate @ 50ns
		#50 rst = 1;
		#50 rst = 0;
		
		slotNums[0] = 3;
		slotNums[1] = 0;
		slotNums[2] = 3;
		
		// RUN state should activate @ 150ns and displayNums should be 303
		#50 button = 1;
		#50 button = 0;
		
		// STOP state should activate @ 250 and displayNums should alternate 
		// every 20s from 303 to all 10s
		#50 button = 1;
		#50 button = 0;
		 
		#300 // give 300 ns to check the blinking
		slotNums = '{default: 3};
		// at 620ns, should switch to WIN state and blink every 80 ns?
		
		#500 // give 500ns to check the blinking
		
		// go back to RUN @ 1100 ns, displayNums should be all 3s
		#50 button = 1;
		#50 button = 0;
		
		#100 // give 100 ns to check RUN
		
		// @ 1300 ns displayNums should go to 0
		rst = 1;
		#50 rst = 0;
		
		
		#100 $stop;
		
	end
	
	


endmodule
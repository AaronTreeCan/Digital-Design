/*
	Copy this to compile easier:
	vlog  clock_divider.sv slotToNum.sv slot.sv sevenSegDigit.sv displayEncoder.sv slot_fsm.sv slotMachine_top.sv slotMachine_tb.sv
*/
`timescale 1us/1ns
module slotMachine_tb (
	output logic [5:0][7:0] displays,
	output logic buzzer
);
	
	logic clk;
	logic button;
	logic rst;
	
	always begin
		// 50MHz clk ~ simulates actual FPGA clk
		#10ns clk = ~clk;
	end
	
	slotMachine_top #(
		.SPD1(1_000_000), // the slot clks run at 1MHz ~ 1 us cycle time
		.SPD2(1_000_000),
		.SPD3(1_000_000)
	) DUT (
		.clk(clk), .button(button), .rst(rst),
		.displays(displays), .buzzer(buzzer)
	);
	
	initial begin
	
		clk = 0;
		rst = 0;
		button = 0;
		
		#10 rst = 1; // wait 10 seconds and rst
		#1 rst = 0;
		
		#9 button = 1; // wait 10 seconds and begin RUN state
		#1 button = 0;
		
		#9 button = 1; // go to STOP state
		#1 button = 0;
		
		#9 button = 1; // RUN again
		#1 button = 0;
		
		#9 rst = 1; // go to SET state
		#1 rst = 0;
		
		#5 $stop;
	
	end

endmodule
/*
	60 Hz ~ fastest speed visibly to human eye (possibly).
	
	Prefer display[0-1] to be most left slot & display [4-5] to be most right.
	The clk assigned to slot1 will be the clk on the most left. 
	Just for fun, you can make the middle slot the slowest and the others fast.
*/
module slotMachine_top #(
	parameter [19:0] SPD1 = 10, // may need to adjust
	parameter [19:0] SPD2 = 5,
	parameter [19:0] SPD3 = 7
) (
	input logic clk, 	
	input logic button, 
	input logic rst, 
	output logic [5:0][7:0] displays,
	output logic buzzer

);
	
  // CONNECTING CLK DIVIDERS AND SLOTS
  /*
	  outClk wires connect clk divider outputs to slot clk inputs
	  slot wires 'capture' slot outputs 
	  running_signal allows slot_fsm to tell slots when to run
  */
	logic outClk1, outClk2, outClk3;
	logic [2:0][3:0] slots;
	logic running_signal;
	
	// clock dividers
	clock_divider clk1 (.speed(SPD1), .clk(clk), .rst(rst), .outClk_d(outClk1));
	clock_divider clk2 (.speed(SPD2), .clk(clk), .rst(rst), .outClk_d(outClk2));
	clock_divider clk3 (.speed(SPD3), .clk(clk), .rst(rst), .outClk_d(outClk3));
	
	// slot modules
	slot slot1 (.clk(outClk1), .running(running_signal), .rst(rst), .shift_reg(slots[0]));
	slot slot2 (.clk(outClk2), .running(running_signal), .rst(rst), .shift_reg(slots[1]));
	slot slot3 (.clk(outClk3), .running(running_signal), .rst(rst), .shift_reg(slots[2]));
  
  // END
  
  // CONNECTING SLOTS TO SLOT TO NUM CONVERTER
  
	logic [5:0][3:0] slotNums;
	slotToNum converter (.slots(slots), .slotNums(slotNums));
	
  // END
  
  // CONNECTING SLOTS TO FSM & BUZZER
  /*
	  use slotNums as input into slot_fsm
	  slot_fsm uses outClk2 for it's blinking clock
	  displayNums wires 'capture' FSM outputs 
	  
	  The FSM serves as an intermediate between the slot outputs and the 
	  display encoder, in order to add a blinking function
  */
	logic [5:0][3:0] displayNums;
	slot_fsm fsm (
		.slotNums(slotNums), .clk(clk), .rst(rst), .button(button), 
		.blinkClk(outClk2), .displayNums(displayNums), 
		.slotRunning(running_signal), .buzzer(buzzer)
	);

  // END
  
  // CONNECTING FSM TO DISPLAY ENCODER
	displayEncoder slot_display (
		.slot_numbers(displayNums), 
		.displayNums(displays)
	);
	
  // END

endmodule
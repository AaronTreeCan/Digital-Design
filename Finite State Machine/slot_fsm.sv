/*
	Uses FPGA clk for state handling.
	Also uses one of the slot's clocks to implement blinking.
	
	Takes in 3 numbers provided by slots and determines what to output,
	and takes care of state transitions.
	
	In order to prevent multiple state transitions during long button pulses,
	button_edge only captures posedges in button.
*/
module slot_fsm #(parameter BUZFREQ = 523) ( // set to 523 (C Note) or 900_000 (sim)
	input wire [5:0][3:0] slotNums,
	input logic clk,
	input logic rst,
	input logic button,
	input logic blinkClk,
	
	output logic [5:0][3:0] displayNums,
	output logic slotRunning,
	output logic buzzer
);
	
	
  // LOGIC TO CAPTURE POSEDGE OF BUTTON 
	logic button_prev; // flip flop to store previous button
	logic button_edge; // edge triggered button signal
	// store previous button state
	always_ff @(posedge clk) begin 
		if (rst) begin
			button_prev <= 0;
		end
		else begin
			button_prev <= button;
		end
	end
	// button_edge only high if previously 0, and button 1
	always_ff @(posedge clk) begin 
		if (rst) begin
			button_edge <= 0;
		end
		else begin
			if (button_prev == 0 && button == 1) begin
				button_edge <= 1;
			end
			else begin
				button_edge <= 0;
			end
		end
	end
  // END LOGIC
	
	
  // BLINKING LOGIC
  /*
	  By implementing a simple counter from 0-3, we can create two
	  blinking speeds. One that displays only on counter % 2 == 0 
	  and another that displays when counter < 2.
  */
	logic [1:0] counter; // counts up to 3
	always_ff @(posedge blinkClk) begin
		if (rst) begin
			counter <= 0;
		end
		else begin
			if (counter < 3) begin
				counter <= counter + 1;
			end
			else begin
				counter <= 0;
			end
		end
	end
  // END LOGIC
	
	
  // BUZZER LOGIC
  /*
	  We use input clk to create a clk of 523 Hz (the C note). When in WIN
	  state, a multiplexer will pass through buzzerOut. Otherwise, the 
	  multiplexer will pass through the 0.
  */
	logic [19:0] speed = BUZFREQ;
	logic buzzerOut;
	clock_divider buzzerClk (.speed(speed), .clk(clk), .rst(rst), .outClk_d(buzzerOut));
  // END LOGIC
	
	
  // FINITE STATE MACHINE LOGIC
	
	enum {SET, RUN, STOP, WIN} currState, nextState;
	
	// determine what the nextState is (where we should go)
	always_comb begin
		case (currState) 
			SET: begin 
				if (button_edge) begin 
					nextState = RUN;
				end 
				else begin
					nextState = currState;
				end
			end
			RUN: begin
				if (button_edge) begin
					nextState = STOP; 
				end 
				else begin
					nextState = currState;
				end
			end
			STOP: begin 
				// if all slots are equal
				if (
					slotNums[0] == slotNums[2] && slotNums[2] == slotNums[4] &&
					slotNums[1] == slotNums[3] && slotNums[3] == slotNums[5]
				) begin
					nextState = WIN;
				end
				// else set nextState to RUN on press
				else if (button_edge) begin
					nextState = RUN;
				end 
				else begin
					nextState = currState;
				end
			end
			WIN: begin 
				// set nextState back to RUN on press
				if (button_edge) begin
					nextState = RUN;
				end
				else begin
					nextState = currState;
				end
			end
		endcase
	end
	
	// go to next_state on clk cycle
	always @(posedge clk) begin
		if (rst) begin // always go to SET if rst is ever pressed
			currState = SET;
		end 
		else begin
			currState <= nextState;
		end
	end
	
	// determine output based on nextState and currState
	always_comb begin
		case (currState)
			SET: begin
				displayNums = slotNums;
				slotRunning = 0;
				buzzer = 0;
			end
			RUN: begin
				displayNums = slotNums;
				slotRunning = 1;
				buzzer = 0;
			end
			STOP: begin
				// STOP blinks slower
				if (counter < 2) begin
					displayNums = slotNums;
				end
				else begin
					displayNums = '{default: 10}; // 10 is display code for blank
				end
				slotRunning = 0;
				buzzer = 0;
			end
			WIN: begin
				// WIN blinks faster
				if (counter % 2 == 0) begin
					displayNums = slotNums;
				end
				else begin
					displayNums = '{default: 10};
				end
				slotRunning = 0;
				buzzer = buzzerOut;
			end
			default: begin
				displayNums = '{default: 10};
				slotRunning = 0;
				buzzer = 0;
			end
		
		endcase
	
	end

endmodule
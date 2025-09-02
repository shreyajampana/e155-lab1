/*
Shreya Jampana
Email: sjampana@hmc.edu
8/31/25
Lab 1 top-level module to control LEDs and a 7-segment display. It controls two LEDs to display specific logic
operations (XOR and AND), and a third LED to blink at a specific frequency (2.4 Hz). It also points to a submodule
that controls a 7 segment display. 
*/

module lab1_sj(input logic reset,
	input logic [3:0] s,
	output logic [2:0] led,
	output logic [6:0] seg); 
	
	logic clk;
	
	// Defining LED 0 and LED 1 
	assign led[0] = s[1] ^ s[0];
	assign led[1] = s[3] & s[2];
	
	logic [24:0] counter = 0;
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Simple clock divider
	always_ff @(posedge clk)
		begin
			if (reset == 0) begin 
				counter <= 0;
				led[2] = 0;
			end
			
			else if (counter == 10000000) begin
					led[2] = ~led[2];
					counter <= 0;
			end
			
			else counter <= counter + 1;
		end
		
	seven_seg_sj r1(s, seg);
		
endmodule
	
	
	
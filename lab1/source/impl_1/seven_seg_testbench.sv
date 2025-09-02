/*
Shreya Jampana
Email: sjampana@hmc.edu
8/31/25
Testbench for seven segment display module.
*/

module seven_seg_testbench();
	logic clk, reset;
	
	//inputs, outputs, and expected outputs
	logic [3:0] s;
	logic [6:0] seg;
	logic [6:0] seg_expected;
	
	//size of 'int' datatype is 4 bytes, thus 32 bits
	logic [31:0] vectornum, errors;
	
	// number of bits: one 4-bit input + one 7-bit output
	logic [10:0] testvectors[10000:0];

	//Instantiate device under test (DUT)
	// Inputs: reset, s. Outputs: led, seg.
	seven_seg_sj dut(s, seg);
	
	//Generate clock.
	always
		begin
		//Create clock with period of 10 time units. 
		//Set the clk signal HIGH(1) for 5 units, LOW(0) for 5 units 
			clk=1; #5; 
			clk=0; #5;
		end
	

	//Start of test
	initial
		begin
			// Load vectors stored as 0s and 1s (binary) in .tv file.
			$readmemb("seven_seg.tv", testvectors);

			// Initialize the number of vectors applied & the amount of errors detected.
			// Both signals hold 0 at the beginning of the test.
			vectornum=0; 
			errors=0;
		
			// Pulse reset for 22 time units(2.2 cycles) so the reset signal falls after a clk edge.
			// The signal starts HIGH(0) for 22 time units then remains LOW(1) for the rest of the test
			reset=0; #22; 
			reset=1;
		end
		

	always @(posedge clk)
		begin
			// Apply testvectors 1 time unit after rising edge of clock to avoid data changes concurrently with the clock.
			#1;
			// Break the current 11-bit test vector into 1 input and 1 expected output.
			{s, seg_expected} = testvectors[vectornum];
		end
		
	// Check results on falling edge of clk.
	always @(negedge clk)
		if (reset) begin
			// Detect error by checking if outputs from DUT match expectation.
			if (seg !== seg_expected) begin
				// If error is detected, print all 2 inputs, 2 outputs, and 2 expected outputs.
				$display("Error: inputs = %b", {s});
				// {s} create a vector containing one signal.
				$display(" outputs = %b (%b expected)", seg, seg_expected);
				// Increment the count of errors.
				errors = errors + 1;
			end
			
			// In any event, increment the count of vectors.
			vectornum = vectornum + 1;

			// If the current testvector is xxxxx, report the number of vectors applied & errors detected.
			if (testvectors[vectornum] === 11'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);

				$stop;
			end

		end
endmodule
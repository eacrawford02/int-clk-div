`timescale 1ns / 1ps

// Divide clock by an arbitrary integer with a 50% duty cycle
module int_clk_div #(
  parameter D = 3, // Specify integer to divide clock by
  parameter W = 2  // Width of counter
) (
  input  clk,
  output out
);
  // To divide the clock, we can be in one of two states:
  localparam up   = 0, // Increment counter to divide clock on low 
	     down = 1; // Decrement counter to divide clock on high
  logic [(W-1):0] count = 0;
  logic state;
  
  assign out = state; // Since state is a single bit, we can assign it to out

  // Determine next state from present state and counter input
  always @ (clk) begin
    case (state)
      up     : begin
		 count <= count + 1;
		 if (count == D-1)
		   state <= down;
		 else
		   state <= up;
	       end
      down   : begin
		 count <= count - 1;
		 if (count == 1)
		   state <= up;
		 else
		   state <= down;
	       end
      default: state <= up; // Set initial state. We do this here to ensure 
			    // count is held at 0 for a half-cycle after the 
			    // leading clock edge at the start of the 
			    // simulation. If not done, counting will
			    // effectively start from 1 and the output
			    // following the leading edge will be one
			    // half-cycle short
    endcase
  end
endmodule

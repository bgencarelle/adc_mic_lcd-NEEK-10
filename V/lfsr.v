//-----------------------------------------------------
// Design Name : lfsr
// File Name   : lfsr.sv
// Function    : Linear feedback shift register
// Coder�     : Deepak Kumar Tala
//-----------------------------------------------------
module lfsr (
output  reg  [15:0] out     ,  // Output of the counter
input   wire       enable  ,  // Enable  for counter
input   wire       clk     ,  // clock input
input   wire       reset      // reset input
);
//------------Internal Variables--------
wire        linear_feedback;
//-------------Code Starts Here-------
assign linear_feedback = !(out[7] ^ out[3]);

always @(posedge clk)
if (reset) begin // active high reset
  out <= 16'b0 ;
end else if (enable) begin
  out <= {
			out[14],
			out[13],out[12],
			out[11],out[10],
			out[9],out[8],
			out[7],out[6],
			out[6],out[5],
          out[4],out[3],
          out[2],out[1],
          out[0], linear_feedback};
end 

endmodule // End Of Module counter
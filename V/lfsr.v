
module lfsr    (
out32				 ,  // 32 bit 
data			    ,

a_clk					,
clk             ,  // clock input
reset              // reset input
);

//----------Output Ports--------------
output wire  [31:0] out32;
reg  [31:0] out32hold;
reg  [31:0] out32ref;
//------------Input Ports--------------
input signed [31:0] data;//seed value
 input wire a_clk, clk, reset;
//------------Internal Variables--------
reg signed [31:0] out;
wire        linear_feedback;

//-------------Code Starts Here-------
assign linear_feedback = (out[31] ^ out[30]  );

always @(posedge clk)
begin
if (reset) 
	begin // active high reset
  out <= data;
	end
if (out == 32'h0) 
	begin // active high reset
  out <= ~data;
	end
if (out == out32ref) 
	begin // active high reset
  out <= ~data-12'b1;
	end
	else if (!reset) 
	begin 
	out <= {out[30:0], linear_feedback};
	out32ref <= out;
	
	end 
end
	always @(posedge a_clk)
	begin
	out32hold <= (out );
	end
	
	assign out32 = (out32hold);
	
endmodule // End Of Module counter
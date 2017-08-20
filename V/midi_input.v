module midi_input (
input wire [6:0] note_number,
input wire [6:0] velocity,
input wire [2:0] filter,
input wire [13:0] pitch,
input wire reset_n,
input wire note_off,
input wire note_on,
input wire a_clk,
input wire SW[9:0],
output reg [6:0] hex0,
output reg [6:0] hex1,
output wire signed [23:0] String_Mix
);





reg signed [23:0] weighted_noise_C;
reg signed [23:0] weighted_noise_Db;
reg signed [23:0] weighted_noise_D;
reg signed [23:0] weighted_noise_Eb;
reg signed [23:0] weighted_noise_E;
reg signed [23:0] weighted_noise_F;
reg signed [23:0] weighted_noise_Gb;
reg signed [23:0] weighted_noise_G;
reg signed [23:0] weighted_noise_Ab;
reg signed [23:0] weighted_noise_A;
reg signed [23:0] weighted_noise_Bb;
reg signed [23:0] weighted_noise_B;


reg octave_note_C;
reg octave_note_Db;
reg octave_note_D;
reg octave_note_Eb;
reg octave_note_E;
reg octave_note_F;
reg octave_note_Gb;
reg octave_note_G;
reg octave_note_Ab;
reg octave_note_A;
reg octave_note_Bb;
reg octave_note_B;

wire signed [15:0] out24_11;
wire signed [15:0] out24_10;
wire signed [15:0] out24_9;
wire signed [15:0] out24_8;
wire signed [15:0] out24_7;
wire signed [15:0] out24_6;
wire signed [15:0] out24_5;
wire signed [15:0] out24_4;
wire signed [15:0] out24_3;
wire signed [15:0] out24_2;
wire signed [15:0] out24_1;
wire signed [15:0] out24_0;

wire note_on_11;
wire note_on_10;
wire note_on_9;
wire note_on_8;
wire note_on_7;
wire note_on_6;
wire note_on_5;
wire note_on_4;
wire note_on_3;
wire note_on_2;
wire note_on_1;
wire note_on_0;

lfsr  noise(//easier to add more voices, shown to be marginally cheaper
			.out24_11(out24_11),
			.out24_10(out24_10),
			.out24_9(out24_9),
			.out24_8(out24_8),
			.out24_7(out24_7),
			.out24_6(out24_6),
			.out24_5(out24_5),
			.out24_4(out24_4),
			.out24_3(out24_3),
			.out24_2(out24_2),
			.out24_1(out24_1),
			.out24_0(out24_0),
			.clk(MAX10_CLK1_50),
			.a_clk(a_clk),
			.reset(RESET_DELAY_n)
					);
	

always @ (posedge a_clk )
begin:octave_PICKER//reset state
if (reset_n == 1'b0)
	begin
							delay_out_0 <= 10'd734;
							hex0 <= 7'b1111111;//c 
							hex0 <= 7'b1111111;//
							
	end
else if (reset_n != 1'b0)
begin
	
	case(note_number)
	7'd0,7'd12,7'd24,7'd36,7'd48,7'd60,7'd72,7'd84,7'd96,7'd108,7'd120: //C
		begin
							if( note_number == 7'd120)
							begin
							delay_out_0 <= 10'd367;
							end
							else begin
							delay_out_0 <= 10'd734;
							end
							hex0 <= 7'b0111001;//c 
							hex0 <= 7'b1111111;//
							octave_note_C <= note_number;
							weighted_noise_C <= out24_0 * velocity;
		
		end
		
	7'd1,7'd13,7'd25,7'd37,7'd49,7'd61,7'd73,7'd85,7'd97,7'd109,7'd121: //Db
		begin
							if( note_number == 7'd121)
							begin
							delay_out_1 <= 10'd347;
							end
							else begin
							delay_out_1 <= 10'd693;
							end
							hex0 <= 7'b1011110;//d
							hex0 <= 7'b1111100;////b
							octave_note_Db <= note_number;
							weighted_noise_Db <= out24_1 * velocity;
		
		end

	7'd2,7'd14,7'd26,7'd38,7'd50,7'd62,7'd74,7'd86,7'd98,7'd110,7'd122: //D
		begin
							if( note_number == 7'd122)
							begin
							delay_out_2 <= 10'd327;
							end
							else begin
							delay_out_2	<= 10'd654;
							end
							hex0 <= 7'b1011110;//d
							hex0 <= 7'b1111111;//
							octave_note_D <= note_number;
							weighted_noise_D <= out24_2 * velocity;			
		end

	7'd3,7'd15,7'd27,7'd39,7'd51,7'd63,7'd75,7'd87,7'd99,7'd111,7'd123: //Eb
		begin
							if( note_number == 7'd123)
							begin
							delay_out_3 <= 10'd309;
							end
							else begin
							delay_out_3	<= 10'd617;
							end
							hex0 <= 7'b1111001;//e
							hex0 <= 7'b1111100;//b//
							octave_note_Eb <= note_number;
							weighted_noise_Eb <= out24_3	* velocity;
		
		end

	7'd4,7'd16,7'd28,7'd40,7'd52,7'd64,7'd76,7'd88,7'd100,7'd112,7'd124: //E
		begin
							if( note_number == 7'd124)
							begin
							delay_out_4 <= 10'd291;
							end
							else begin
							delay_out_4	<= 10'd582;
							end
							hex0 <= 7'b1111001;//e
							hex0 <= 7'b1111111;////
							octave_note_E <= note_number;
							weighted_noise_E <= out24_4 * velocity;
							end

	7'd5,7'd17,7'd29,7'd41,7'd53,7'd65,7'd77,7'd89,7'd101,7'd113,7'd125: //F
		begin
							if( note_number == 7'd125)
							begin
							delay_out_5 <= 10'd275;
							end
							else begin
							delay_out_5	<= 10'd550;
							end						
							hex0 <= 7'b1110001;//f
							hex0 <= 7'b1111111;////
							octave_note_F <= note_number;
							weighted_noise_F <= out24_5 * velocity;
							end
	
	7'd6,7'd18,7'd30,7'd42,7'd54,7'd66,7'd78,7'd90,7'd102,7'd114,7'd126: //Gb
		begin				
							if( note_number == 7'd126)
							begin
							delay_out_6 <= 10'd259;
							end
							else begin
							delay_out_6	<= 10'd519;
							end
							hex0 <= 7'b1111101;//G
							hex0 <= 7'b1111111;////
							octave_note_Gb <= note_number;
							weighted_noise_Gb <= out24_6 * velocity;
							end

	
	7'd7,7'd19,7'd31,7'd43,7'd55,7'd67,7'd79,7'd91,7'd103,7'd115,7'd127: //G
		begin				
							if( note_number == 7'd127)
							begin
							delay_out_7 <= 10'd245;
							end
							else begin
							delay_out_7	<= 10'd490;
							end
							hex0 <= 7'b1111101;//G
							hex0 <= 7'b1111111;////
							octave_note_G <= note_number;
							weighted_noise_G <= out24_7 * velocity;
							end
	
	7'd8,7'd20,7'd32,7'd44,7'd56,7'd68,7'd80,7'd92,7'd104,7'd116: 			//Ab
		begin
							delay_out_8 <= 10'd462;
							hex0 <= 7'b1110111; //a
							hex0 <= 7'b1111100;//b//
							octave_note_Ab <= note_number;
							weighted_noise_Ab <= out24_8 * velocity;
		end
		
	7'd9,7'd21,7'd33,7'd45,7'd57,7'd69,7'd81,7'd93,7'd105,7'd117: 			//A
		begin
							delay_out_9 <= 10'd436;
							hex0 <= 7'b1110111; //a
							hex0 <= 7'b1111111;////
							octave_note_A <= note_number;
							weighted_noise_A <= out24_9 * velocity;
							end
		
	7'd10,7'd22,7'd34,7'd46,7'd58,7'd70,7'd82,7'd94,7'd106,7'd118: 			//Bb
		begin
							delay_out_10 <= 10'd412;
							hex0 <= 7'b1111100;//b
							hex0 <= 7'b1111100;//b//
							octave_note_Bb <= note_number;
							weighted_noise_Bb <= out24_10 * velocity;
		end
	
	7'd11,7'd23,7'd35,7'd47,7'd59,7'd71,7'd83,7'd95,7'd107,7'd119: 			//B
		begin
							delay_out_11 <= 10'd389;
							hex0 <= 7'b1111100;//b
							hex0 <= 7'b1111111;////
							octave_note_B <= note_number;
							weighted_noise_B <= out24_11 * velocity;	
						end	
endcase
end
end	

wire clock_C;
assign 				clock_C =(reset_n == 1'b0)?  a_clk://C
						((octave_note_C == 7'd108) || (octave_note_C == 7'd120))?a_clk:
						 (octave_note_C == 7'd96) ?div2:
						 (octave_note_C == 7'd84) ?div4:
						 (octave_note_C == 7'd72) ?div8:
						 (octave_note_C == 7'd60) ?div16:
						 (octave_note_C == 7'd48) ?div32:
						 (octave_note_C == 7'd36) ?div64:
						 (octave_note_C == 7'd24) ?div128:
						 (octave_note_C == 7'd12) ?div256:
						 (octave_note_C == 7'd0)  ?div512:a_clk;
//	7'd0,7'd12,7'd24,7'd36,7'd48,7'd60,7'd72,7'd84,7'd96,7'd108,7'd120: //C
						

wire clock_Db;						
assign 				clock_Db =(reset_n == 1'b0)?  a_clk://Db
						((octave_note_Db == 7'd109) || (octave_note_Db == 7'd121))?a_clk:
						 (octave_note_Db == 7'd97) ?div2:
						 (octave_note_Db == 7'd85) ?div4:
						 (octave_note_Db == 7'd73) ?div8:
						 (octave_note_Db == 7'd61) ?div16:
						 (octave_note_Db == 7'd49) ?div32:
						 (octave_note_Db == 7'd37) ?div64:
						 (octave_note_Db == 7'd25) ?div128:
						 (octave_note_Db == 7'd13) ?div256:
						 (octave_note_Db == 7'd1) ?div512:a_clk;
//	7'd1,7'd13,7'd25,7'd37,7'd49,7'd61,7'd73,7'd85,7'd97,7'd109,7'd121: //Db

						
wire clock_D;						
assign 				clock_D =(reset_n == 1'b0)?  a_clk://D
						((octave_note_D == 7'd110) || (octave_note_D == 7'd122))?a_clk:
						 (octave_note_D == 7'd98) ?div2:
						 (octave_note_D == 7'd86) ?div4:
						 (octave_note_D == 7'd74) ?div8:
						 (octave_note_D == 7'd62) ?div16:
						 (octave_note_D == 7'd50) ?div32:
						 (octave_note_D == 7'd38) ?div64:
						 (octave_note_D == 7'd26) ?div128:
						 (octave_note_D == 7'd14) ?div256:
						 (octave_note_D == 7'd2)  ?div512:a_clk;
//	7'd2,7'd14,7'd26,7'd38,7'd50,7'd62,7'd74,7'd86,7'd98,7'd110,7'd122: //D


						
wire clock_Eb;
assign 				clock_Eb =(reset_n == 1'b0)?  a_clk://Eb
						((octave_note_Eb == 7'd111) || (octave_note_Eb == 7'd123))?a_clk:
						 (octave_note_Eb == 7'd99)  ?div2:
						 (octave_note_Eb == 7'd87)  ?div4:
						 (octave_note_Eb == 7'd75)  ?div8:
						 (octave_note_Eb == 7'd63)  ?div16:
						 (octave_note_Eb == 7'd51)  ?div32:
						 (octave_note_Eb == 7'd39)  ?div64:
						 (octave_note_Eb == 7'd27)  ?div128:
						 (octave_note_Eb == 7'd15)  ?div256:
						 (octave_note_Eb == 7'd3)  ?div512:a_clk;
//	7'd3,7'd15,7'd27,7'd39,7'd51,7'd63,7'd75,7'd87,7'd99,7'd111,7'd123: //Eb

wire clock_E;
assign 				clock_E =(reset_n == 1'b0)?  a_clk://E
						((octave_note_E == 7'd112) || (octave_note_E == 7'd124))?a_clk:
						 (octave_note_E == 7'd100)  ?div2:
						 (octave_note_E == 7'd88)  ?div4:
						 (octave_note_E == 7'd76)  ?div8:
						 (octave_note_E == 7'd64)  ?div16:
						 (octave_note_E == 7'd52)  ?div32:
						 (octave_note_E == 7'd40)  ?div64:
						 (octave_note_E == 7'd28)  ?div128:
						 (octave_note_E == 7'd16)  ?div256:
						 (octave_note_E == 7'd4) ?div512:a_clk;
//	7'd4,7'd16,7'd28,7'd40,7'd52,7'd64,7'd76,7'd88,7'd100,7'd112,7'd124: //E

wire clock_F;
assign 				clock_F =(reset_n == 1'b0)?  a_clk://C
						((octave_note_F == 7'd113) || (octave_note_F == 7'd125))?a_clk:
						 (octave_note_F == 7'd101)  ?div2:
						 (octave_note_F == 7'd89) ?div4:
						 (octave_note_F == 7'd77) ?div8:
						 (octave_note_F == 7'd65) ?div16:
						 (octave_note_F == 7'd53) ?div32:
						 (octave_note_F == 7'd41) ?div64:
						 (octave_note_F == 7'd29) ?div128:
						 (octave_note_F == 7'd17) ?div256:
						 (octave_note_F == 7'd5)  ?div512:a_clk;
//	7'd5,7'd17,7'd29,7'd41,7'd53,7'd65,7'd77,7'd89,7'd101,7'd113,7'd125: //F
						

wire clock_Gb;
assign 				clock_G =(reset_n == 1'b0)?  a_clk://C
						((octave_note_Gb == 7'd114) || (octave_note_Gb == 7'd126))?a_clk:
						 (octave_note_Gb == 7'd102) ?div2:
						 (octave_note_Gb == 7'd90)  ?div4:
						 (octave_note_Gb == 7'd78)  ?div8:
						 (octave_note_Gb == 7'd66)  ?div16:
						 (octave_note_Gb == 7'd54)  ?div32:
						 (octave_note_Gb == 7'd42)  ?div64:
						 (octave_note_Gb == 7'd30)  ?div128:
						 (octave_note_Gb == 7'd18)  ?div256:
						 (octave_note_Gb == 7'd6)   ?div512:a_clk;
//	7'd6,7'd18,7'd30,7'd42,7'd54,7'd66,7'd78,7'd90,7'd102,7'd114,7'd126: //Gb


wire clock_G;
assign 				clock_Gb =(reset_n == 1'b0)?  a_clk://G
						((octave_note_G == 7'd115) || (octave_note_G == 7'd127))?a_clk:
						 (octave_note_G == 7'd103) ?div2:
						 (octave_note_G == 7'd91)  ?div4:
						 (octave_note_G == 7'd79)  ?div8:
						 (octave_note_G == 7'd67)  ?div16:
						 (octave_note_G == 7'd55)  ?div32:
						 (octave_note_G == 7'd43)  ?div64:
						 (octave_note_G == 7'd31)  ?div128:
						 (octave_note_G == 7'd19)  ?div256:
						 (octave_note_G == 7'd7)   ?div512:a_clk;
//	7'd7,7'd19,7'd31,7'd43,7'd55,7'd67,7'd79,7'd91,7'd103,7'd115,7'd127: //G


wire clock_Ab;
assign 				clock_Ab =(reset_n == 1'b0)?  a_clk://C
						(octave_note_Ab == 7'd116)? a_clk:
						 (octave_note_Ab == 7'd104) ?div2:
						 (octave_note_Ab == 7'd92)  ?div4:
						 (octave_note_Ab == 7'd80)  ?div8:
						 (octave_note_Ab == 7'd68)  ?div16:
						 (octave_note_Ab == 7'd56)  ?div32:
						 (octave_note_Ab == 7'd44)  ?div64:
						 (octave_note_Ab == 7'd32)  ?div128:
						 (octave_note_Ab == 7'd20)  ?div256:
						 (octave_note_Ab == 7'd8)  ?div512:a_clk;
//	7'd8,7'd20,7'd32,7'd44,7'd56,7'd68,7'd80,7'd92,7'd104,7'd116: 			//Ab						

wire clock_A;
assign 				clock_A =(reset_n == 1'b0)?  a_clk://A
						(octave_note_A == 7'd117)? a_clk:
						 (octave_note_A == 7'd105) ?div2:
						 (octave_note_A == 7'd93)  ?div4:
						 (octave_note_A == 7'd81)  ?div8:
						 (octave_note_A == 7'd69)  ?div16:
						 (octave_note_A == 7'd57)  ?div32:
						 (octave_note_A == 7'd45)  ?div64:
						 (octave_note_A == 7'd33)  ?div128:
						 (octave_note_A == 7'd21)  ?div256:
						 (octave_note_A == 7'd9)   ?div512:a_clk;
//	7'd9,7'd21,7'd33,7'd45,7'd57,7'd69,7'd81,7'd93,7'd105,7'd117: 			//A						

wire clock_Bb;
assign 				clock_Bb =(reset_n == 1'b0)?  a_clk://Bb
						(octave_note_Bb == 7'd118)? a_clk:
						 (octave_note_Bb == 7'd106) ?div2:
						 (octave_note_Bb == 7'd94)  ?div4:
						 (octave_note_Bb == 7'd82)  ?div8:
						 (octave_note_Bb == 7'd70)  ?div16:
						 (octave_note_Bb == 7'd58)  ?div32:
						 (octave_note_Bb == 7'd46)  ?div64:
						 (octave_note_Bb == 7'd34)  ?div128:
						 (octave_note_Bb == 7'd22)  ?div256:
						 (octave_note_Bb == 7'd10)  ?div512:a_clk;			
//	7'd10,7'd22,7'd34,7'd46,7'd58,7'd70,7'd82,7'd94,7'd106,7'd118: 			//Bb
						
wire clock_B;
assign 				clock_B =(reset_n == 1'b0)?  a_clk://C
						(octave_note_B == 7'd119)? a_clk:
						 (octave_note_B == 7'd107)  ?div2:
						 (octave_note_B == 7'd95)  ?div4:
						 (octave_note_B == 7'd83)  ?div8:
						 (octave_note_B == 7'd71)  ?div16:
						 (octave_note_B == 7'd59)  ?div32:
						 (octave_note_B == 7'd47)  ?div64:
						 (octave_note_B == 7'd35)  ?div128:
						 (octave_note_B == 7'd23)  ?div256:
						 (octave_note_B == 7'd11)  ?div512:a_clk;	
//	7'd11,7'd23,7'd35,7'd47,7'd59,7'd71,7'd83,7'd95,7'd107,7'd119: 			//B


wire div2;
wire div4;
wire div8;
wire div16;
wire div32;
wire div64;
wire div128;
wire div256;	
wire div512;			
endmodule
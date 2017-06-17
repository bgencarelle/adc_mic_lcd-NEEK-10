
//================================================//  This code is generated by Terasic System Builder
//================================================
module adc_mic_lcd #(parameter BIT_WIDTH = 24, parameter RANGE = BIT_WIDTH-1, 
							parameter TRUNC_RANGE = 15, parameter TRUNC = RANGE-TRUNC_RANGE)
							//TRUNC instead of 0 makes scaling easier
							(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,
	input 		          		MAX10_CLK3_50,
	
	//////////// KEY //////////
	input 		          		FPGA_RESET_n,
	input 		     [4:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LEDR //////////
	output		     [9:0]		LEDR,

	//////////// HEX //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,

	//////////// Audio //////////
	inout 		          		AUDIO_BCLK,
	output		          		AUDIO_DIN_MFP1,
	input 		          		AUDIO_DOUT_MFP2,
	inout 		          		AUDIO_GPIO_MFP5,
	output		          		AUDIO_MCLK,
	input 		          		AUDIO_MISO_MFP4,
	inout 		          		AUDIO_RESET_n,
	output		          		AUDIO_SCL_SS_n,
	output		          		AUDIO_SCLK_MFP3,
	inout 		          		AUDIO_SDA_MOSI,
	output		          		AUDIO_SPI_SELECT,
	inout 		          		AUDIO_WCLK,//48khz

	//////////// DAC //////////
	inout 		          		DAC_DATA,
	output		          		DAC_SCLK,
	output		          		DAC_SYNC_n,

//	//////////// MTL2 //////////
//	output		     [7:0]		MTL2_B,
//	output		          		MTL2_BL_ON_n,
//	output		          		MTL2_DCLK,
//	output		     [7:0]		MTL2_G,
//	output		          		MTL2_HSD,
//	output		          		MTL2_I2C_SCL,
//	inout 		          		MTL2_I2C_SDA,
//	input 		          		MTL2_INT,
//	output		     [7:0]		MTL2_R,
//	output		          		MTL2_VSD,
//
//	//////////// PS2 //////////
//	inout 		          		PS2_CLK,
//	inout 		          		PS2_CLK2,
//	inout 		          		PS2_DAT,
//	inout 		          		PS2_DAT2,

	//////////// TMD 2x6 GPIO Header, TMD connect to TMD Default //////////
	output 		     [7:0]		GPIO	
	
);

  

//----ON-BOARD-MIC TO DAC&LINE out-----

//================================================//  REG/WIRE declarations
//================================================// ### USER DEFINED
wire signed [15:0]		PWM_OUT;
wire signed [RANGE:0]		MEM0;
wire signed [RANGE:0]		MEM1;
wire signed [RANGE:0]		MEM2;
wire signed [RANGE:0]		MEM3;
wire signed [RANGE:0]		MEM4;
wire signed [RANGE+4:0]		VERB0;

reg signed [RANGE+1:0]		MIX_01;
reg signed [RANGE+1:0]		MIX_23;
reg signed [RANGE+4:0]		MIXMASTER=0;
wire signed [RANGE:0]		SEED_OUT;
wire signed [RANGE:0] 		FILTER_OUT;
wire signed [RANGE:0]		MUX0_OUT;
wire signed [RANGE:0]		MUX1_OUT;
wire signed [RANGE:0] 	MASTER_OUT;
wire 			  			key_0;
reg 			  			GPIOCLK;
wire 	[6:0]	  			HEXR;
wire 	[6:0]	  			HEXL;
//wire [RANGE:0]		SAW_OUT
//wire 

//  ### PREDEFINED 
wire 	[11:0]			ADC_RD ;
wire    					SAMPLE_TR ;  
wire          			ADC_RESPONSE ;
wire  [RANGE:TRUNC]  TODAC ; 
wire          			ROM_CK ; 
wire          			MCLK_48M ; // 48MHZ
wire  [RANGE:TRUNC]   	SUM_AUDIO ; 
wire	[9:0]   			LED ; //mistake in standard implementation
wire          			MTL_CLK ;  // 33MHZ
reg           			RESET_DELAY_n ; 
reg   [31:0]  			DELAY_CNT;        


//================================================//  Structural coding
//================================================// ### KARPLUS AND AUDIO STUFF GOES HERE!!


//pulse_width_modulation_gen pwm1 (//to do: add frequency control)
//    .clk(MAX10_CLK1_50 ), 
//	 .outclk(AUDIO_WCLK),
//	 .reset(~RESET_DELAY_n),
////	 .freq_in(ADCCTRL),
//    .q_pwm(PWM_OUT[15:0])
////  .q_saw(SAW_OUT);	 
//    );
//	 
always @(AUDIO_WCLK)
	begin
	MIXMASTER <={MEM4[23],MEM4[23:1]}+{MEM3[23],MEM3[23:1]}+{MEM2[23],MEM2[23:1]} + {MEM1[23],MEM1[23:1]}+{MEM0[23],MEM0[23:1]};
	end
	

	assign MASTER_OUT = MIXMASTER [23:8];


KP_main mem4(  
			.m_clk(MAX10_CLK1_50),
		  .a_clk(AUDIO_WCLK),
		  .seed_val(24'hfff_6ff),
		  .octave(0),
		  .filtsw(3'b110),
		  .trig(KEY[4]),
		  .shift_register_length(10'd145),
		  .reset_n(RESET_DELAY_n),
        .qout(MEM4)    
        );
KP_main mem3(  
			.m_clk(MAX10_CLK1_50),
		  .a_clk(AUDIO_WCLK),
		  .seed_val(24'hf0f_3ff),
		  .octave(0),
		  .filtsw(3'b110),
		  .trig(KEY[3]),
		  .shift_register_length(10'd194),
		  .reset_n(RESET_DELAY_n),
        .qout(MEM3)    
        ); 
KP_main mem2(  
			.m_clk(MAX10_CLK1_50),
		  .a_clk(AUDIO_WCLK),
		  .seed_val(24'hfff_30f),
		  .octave(0),
		  .filtsw(3'b110),
		  .trig(KEY[2]),
		  .shift_register_length(10'd244),
		  .reset_n(RESET_DELAY_n),
        .qout(MEM2)    
        ); 
KP_main mem1(  
			.m_clk(MAX10_CLK1_50),
		  .a_clk(AUDIO_WCLK),
		  .seed_val(24'hfff_faa),
		  .octave(0),
		  .filtsw(3'b110),
		  .trig(KEY[1]),
		  .shift_register_length(10'd327),
		  .reset_n(RESET_DELAY_n),
        .qout(MEM1)    
        ); 
KP_main mem0(  
			.m_clk(MAX10_CLK1_50),
		  .a_clk(AUDIO_WCLK),
		  .seed_val(24'hf0f_fff),
		  .octave(0),
		  .filtsw(3'b110),
		  .trig(KEY[0]),
		  .shift_register_length(10'd436),
		  .reset_n(RESET_DELAY_n),
        .qout(MEM0)    
        );


ADC_SEG_LED segR(
			.reset_n(RESET_DELAY_n), 
			.clk (AUDIO_MCLK), 
			.adc_rd (MIXMASTER [23:20]),
			.LED(LED), 	
			.HEXR(HEXL)
			); 
ADC_SEG_LED segL(
			.reset_n(RESET_DELAY_n), 
			.clk (AUDIO_MCLK), 
			.adc_rd (MIXMASTER [19:16]),	
			.HEXR(HEXR)
			); 

//--METER TO LED --  
assign LEDR =  LED;
//assign HEX0 = HEXL;
assign HEX1 = HEXR; 
//--RESET DELAY ---

//--I2S PROCESSS  CODEC LINE OUT --

I2S_ASSESS  i2s( 
	.SAMPLE_TR ( SAMPLE_TR),
	.AUDIO_MCLK( AUDIO_MCLK) ,  
	.AUDIO_BCLK( AUDIO_BCLK),
	.AUDIO_WCLK( AUDIO_WCLK),

	.SDATA_OUT ( AUDIO_DIN_MFP1),
	.SDATA_IN  ( AUDIO_DOUT_MFP2),
	.RESET_n   ( RESET_DELAY_n), 
	.ADC_MIC      ( MASTER_OUT), 
	.SW_BYPASS    ( 0),          // 0:on-board mic  , 1 :line-in
	.SW_OBMIC_SIN ( 0),          // 1:sin  , 0 : mic
//	.ROM_ADDR     ( ROM_ADDR), 
	.ROM_CK       ( ROM_CK ),
	.SUM_AUDIO    ( SUM_AUDIO ) 
	
	) ; 


always @(negedge FPGA_RESET_n or posedge MAX10_CLK2_50 )  
begin

if (!FPGA_RESET_n )  
	begin 
     RESET_DELAY_n <=0;
     DELAY_CNT   <=0;
	end 

	else  if ( DELAY_CNT < 32'h0ffff  )  
  begin
  DELAY_CNT<=DELAY_CNT+1'b1; 
  end
 else 
	begin
		RESET_DELAY_n <=1;
	end
	
	
end

//--- MIC  TO  MAX10-ADC  ----

MAX10_ADC   madc(  
	.SYS_CLK ( AUDIO_MCLK   ),
	.SYNC_TR ( SAMPLE_TR    ),
	.RESET_n ( RESET_DELAY_n),
	.ADC_CH  ( 8),
	.DATA    (ADC_RD ) ,
	.DATA_VALID(ADC_RESPONSE),
	.FITER_EN (1) 
 );

//--------------DAC out --------------------
assign      TODAC = {~SUM_AUDIO[RANGE] ,  SUM_AUDIO[RANGE-1:TRUNC] }  ; 
//
DAC16 dac1 (
	.LOAD    ( ROM_CK   ) ,
	.RESET_N ( FPGA_RESET_n ) , 
	.CLK_50  ( AUDIO_MCLK ) , 
	.DATA16  ( TODAC  )  ,
	.DIN     ( DAC_DATA ),
	.SCLK    ( DAC_SCLK ),
	.SYNC    ( DAC_SYNC_n )
	
	);

//-----MCLK GENERATER ----------
assign AUDIO_MCLK  = MCLK_48M ; 

AUDIO_PLL pll (
	.inclk0 (MAX10_CLK1_50),
	.c0     (MCLK_48M) 
	);
	

//---AUDIO CODEC SPI CONFIG ------------------------------------	
//--I2S mode ,  48ksample rate  ,MCLK = 24.567MhZ x 2 
assign AUDIO_GPIO_MFP5  =  1;   //GPIO
assign AUDIO_SPI_SELECT =  1;   //SPI mode
assign AUDIO_RESET_n    =  RESET_DELAY_n ;

AUDIO_SPI_CTL_RD	u1(	
	.iRESET_n ( RESET_DELAY_n) , 
	.iCLK_50( MAX10_CLK1_50),   //50Mhz clock
	.oCS_n ( AUDIO_SCL_SS_n ),   //SPI interface mode chip-select signal
	.oSCLK ( AUDIO_SCLK_MFP3),  //SPI serial clock
	.oDIN  ( AUDIO_SDA_MOSI ),   //SPI Serial data output 
	.iDOUT ( AUDIO_MISO_MFP4)   //SPI serial data input
	
	);



//---MTL2 --- 
//PLL_VGA PP(
//	.areset ( 0),
//	.inclk0 ( MAX10_CLK3_50) ,
//	.c0     ( MTL_CLK),
//	.locked () 
//);	

//--SOUND-WAVE display to MTL2 ----
//assign  MTL2_BL_ON_n = ~RESET_DELAY_n  ; 
//
//SOUND_TO_MTL2  sm(
//	.WAVE      ( SUM_AUDIO),
//	.AUDIO_MCLK( AUDIO_MCLK),
//	.SAMPLE_TR ( SAMPLE_TR),
//	.RESET_n   ( RESET_DELAY_n), 
//	
//	.MTL_CLK  ( MTL_CLK  ), 
//	.MTL2_R   ( MTL2_R   ), 
//	.MTL2_G   ( MTL2_G   ),
//	.MTL2_B   ( MTL2_B   ),
//   .MTL2_HSD ( MTL2_HSD ),
//   .MTL2_VSD ( MTL2_VSD ),
//   .MTL2_DCLK( MTL2_DCLK) , 
//   .SCAL      ( 7), //0:NONE SCA  1: SCALE+1  ... 
//	.DRAW_DOT  ( 0),
//	.START_STOP( 1) 
//);	



endmodule



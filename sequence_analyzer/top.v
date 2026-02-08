`timescale 1ns / 1ps 
 
module TOPTOP( 
    input CLK_48, 
    input SYS_NRST, 
    input BTN_0, 
    input BTN_1, 
    input [3:0] SWITCHES_IN, 
    input SWITCHES_SIDE, 
    output [7:0] AN, 
    output [7:0] CAT, 
    output [15:0] LED_NUM  
    ); 
 
wire RST; 
wire CEO_1Khz; 
wire CEO_1KhzFLTR; 
wire BTN_OR; 
wire BTN_OUT; 
wire BTN_OUT1; 
wire BTN_OUT2; 
wire [3:0] NOM, SEQ; 
wire[7:0] BLANK; 
wire [31:0] HEX_IN; 
 
synchro synch( 
    .CLK_48(CLK_48), 
    .SYS_NRST(~SYS_NRST), 
    .BTN_OR(BTN_OUT), 
    .SEQ(SWITCHES_IN), 
    .HEX_IN(HEX_IN), 
    .RST(RST) 
);     
 
clk_div #(.DIV(100000), .CNT_WDT(17))div( 
    .clk(CLK_48), 
    .rst(RST), 
    .CEO(CEO_1Khz) 
); 
 
LA_DIVIDER #(.DIV(5), .CNT_WDT(2))div_fltr( 
    .clk(CLK_48), 
    .rst(RST), 
    .CEO(CEO_1KhzFLTR) 
); 
 
button_filter fltr0( 
    .CLK(CLK_48), 
    .RST(RST), 
    .CE(CEO_1KhzFLTR), 
    .BTN_IN(BTN_0), 
    .BTN_CEO(BTN_OUT1) 
); 
 
button_filter fltr1( 
    .CLK(CLK_48), 
    .RST(RST), 
    .CE(CEO_1KhzFLTR), 
    .BTN_IN(BTN_1), 
    .BTN_CEO(BTN_OUT2) 
); 
 
sequence_analyzer ANAYZ( 
    .CLK(CLK_48), 
    .RST(RST), 
    .CE(BTN_OUT1), 
    .DAT_I(SWITCHES_IN), 
    .LED(LED_NUM), 
    .NOM_BLANK(BLANK) 
); 
 
LED seg( 
    .CLK_100(CLK_48), 
    .RST(RST), 
    .CE(CEO_1Khz), 
    .HEX_IN(HEX_IN), 
    .BLANK(~LED_NUM), 
    .DP_IN(8'h1), 
    .AN(AN), 
    .CAT(CAT) 
); 
assign BTN_OUT = BTN_OUT1; //|| BTN_OUT2; 
endmodule

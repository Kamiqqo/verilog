`timescale 1ns / 1ps

module test_gen;
    reg M_DATA = 0;
    reg clk = 0;
    reg button = 0;
    reg button_reset = 0;
    wire[7:0] AN;
    wire[6:0] SEG;
//    wire[31:0] NUMBER;
//    wire button_signal;
//    wire button_signal_en;
//    wire reset_signal_en;
//    wire reset_signal;
    TOP_FURRY cntlr(
        .M_DATA(M_DATA),
//        .button_in(button),
        .clk(clk)
//        .button_reset_in(button_reset),
//        .AN(AN),
//        .NUMBER(NUMBER),
//        .SEG(SEG)
//        .button_signal(button_signal),
//        .button_signal_en(button_signal_en),
//        .reset_signal_en(reset_signal_en),
//        .reset_signal(reset_signal)
    );
    always #5 clk = ~ clk;
    initial 
        begin
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 1;#10;
            M_DATA = 0;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 0;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 0;#10;
            M_DATA = 1;#10;
            M_DATA = 1;#10;
            M_DATA = 0;#10;
            M_DATA = 1;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
           
            M_DATA = 1;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 1;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 0;#10;
            M_DATA = 1;#10;
            M_DATA = 0;#10;
    end
endmodule

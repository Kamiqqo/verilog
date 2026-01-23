`timescale 1ns / 1ps

module TOP_FURRY(
    input M_DATA,clk,
//    input button_in, button_reset_in,
    output [7:0] AN,
    output [6:0] SEG
    
//    output reg signed [15:0] Data_in,
//    output wire button_signal_en,
//    output wire button_signal,
//    output wire reset_signal_en,
//    output wire reset_signal,
//    output reg [31:0] NUMBER
    );
    
    wire button_signal, button_signal_en, reset_signal_en, reset_signal;
    reg[7:0] AN_MASK = 8'b11111111;
    reg [31:0] NUMBER;
    reg signed [15:0] Data_in;
    wire valid_FFT;
    reg [31:0] Data_buff = 0;
    reg [3:0] ones_count = 0;
    reg [3:0] ones_prev_count = 0;
    reg [4:0] bit_couter;
    reg input_en = 0;
    reg [2:0] state;
    reg [5:0] i = 0;
    reg[4:0] j = 0;
    reg [3:0] jj = 0;
    reg [4:0] ij = 0;
    reg [4:0] sumij = 0;
    reg [4:0] subij = 0;
    reg fl = 0;
    reg [4:0] fl_count = 0;
    reg start_signal;
    reg signed [15:0] furry = 0;
    wire [8:0] amplitude;
    wire [8:0] amplitude2;
    wire [8:0] amplitude3;
    reg [1:0] state_abel = 0;
    filtercon #(128) dbnc(
        .clk(clk),
        .in_signal(button_in),
        .clock_enable(1'b1),
        .out_signal(button_signal),
        .out_signal_enable(button_signal_en)
    );
    
    filtercon #(128) dbnc_reset(
        .clk(clk),
        .in_signal(button_reset_in),
        .clock_enable(1'b1),
        .out_signal(reset_signal),
        .out_signal_enable(reset_signal_en)
    );
    
    clk_divider #(1024) div(
        .clk(clk),
        .clk_div(clk_div)
    );
        
    SevenSegmentLED led(
        .AN_MASK(AN_MASK),
        .NUMBER(NUMBER),
        .clk(clk_div),
        .RESET(reset_signal),
        .AN(AN),
        .SEG(SEG)
    );

    furry SPECTR(
        .clk(clk),
        .reset(reset_signal),
        .signal_in(Data_in),
        .valid_FFT(valid_FFT),
//        .state(state),
        .start_signal(start_signal),
//        .furry(furry),
        .amplitude(amplitude),
        .amplitude2(amplitude2),
        .amplitude3(amplitude3)
    );
    
    reg flData_in = 0;
    reg flOut = 0;
    reg [8:0] buffamplitude = 0;
    reg [8:0] buffamplitude2 = 0;
    reg [8:0] buffamplitude3 = 0;
    reg [26:0] couuuun_out = 0;
    always@(posedge clk)
        begin
            if(flData_in)
                start_signal <= 1;
            if(i<31 && i!=32) begin
                Data_buff <= Data_buff <<1;
                Data_buff <= {Data_buff[30:0],M_DATA};
                i <= i + 1;
                j<=0;
                jj<=0;
            end
            else
                begin
                case (state_abel) 
                    0: begin if(j < 31) begin /*Data_in <= (Data_buff[31-j]);*/if(j > 3 && j < 29)begin state_abel <= 1;end end else begin i<=32;end
                       j<=j+1; ones_count <= 0;ones_prev_count <= 0;flData_in <= 0;end
                    1: begin 
                            if(jj < 3) 
                                begin
                                    ij = 31 - j; sumij = 31-j+jj; subij = 31 -j - jj;
                                    if(Data_buff[sumij] == 1) 
                                        begin 
                                            ones_count = ones_count + 1;
                                        end
                                    if(Data_buff[subij] == 1) 
                                        begin 
                                            ones_prev_count = ones_prev_count + 1;
                                        end
                                    if(jj==2)
                                        begin
                                            if(j>5)
                                                begin
                                                    if(Data_buff[ij] == 1)
                                                        begin
                                                            ones_prev_count = ones_prev_count + 1;
                                                        end
                                                end
                                                end
                                    state_abel <= 1;
                                    jj<= jj + 1;
                                end
                            else begin state_abel <= 0; jj <= 0; Data_in = (ones_count + ones_prev_count) * 8571 - 30000;flData_in <= 1;end
                            end
                endcase

               end
            couuuun_out <= couuuun_out + 1;
            if(couuuun_out == 27'd134217727)flOut <= 0;
            if(reset_signal)
                begin
                    Data_in <= 0;
                    NUMBER <= 0;
                    AN_MASK <= 8'b11111111;
                    input_en <= 0;
                end
            else if(valid_FFT && !flOut)
                begin
                    flOut <= 1;
                    buffamplitude <= amplitude3;
                    if(flOut)buffamplitude2 <= amplitude3;
                    if(amplitude < 100)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude3%29;
                        end
                    else if(amplitude < 200)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude3%16;
                        end
                    else if(amplitude < 300)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude3%70;
                        end
                    else if(amplitude < 400)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude%90;
                        end
                     else if(amplitude < 500)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude%100;
                        end
                     else if(amplitude < 600)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude3%120;
                        end
                     else if(amplitude < 700)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude%152;
                        end
                     else if(amplitude < 800)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude%179;
                        end
                     else if(amplitude < 900)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude%215;
                        end
                     else if(amplitude < 1000)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude%255;
                        end
                     else if(amplitude >1000)
                        begin
                            AN_MASK <= 8'b11110000;
                            NUMBER <= amplitude%700;
                        end
                end
        end
endmodule
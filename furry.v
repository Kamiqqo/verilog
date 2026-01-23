`timescale 1ns / 1ps

module furry(
   input clk, 
   input reset, 
   input signed [15:0] signal_in, 
   input [16:0] sin_i,cos_i,
   input start_signal, 
   output reg finish_signal, 
   output reg end_flag = 0,
   output reg signed [15:0] furry = 0,
   output reg [8:0] amplitude = 0,
   output reg [8:0] amplitude2 = 0,
   output reg [8:0] amplitude3 = 0,
   output reg valid_FFT = 0
   ); 
   
    reg [63:0] j;
    initial j = 0;

    reg [31:0] cordic_angle1; 
    reg [31:0] cordic_angle2; 
    reg [31:0] cordic_angle3; 
    reg [9:0] trig_table_angle; 
    
    always
    begin
        trig_table_angle = ((1 << 10)*j)/17;
        cordic_angle1 = ((1 << 32)* 1 * j)/17;
        cordic_angle2 = ((1 << 32)* 2 * j)/17;
        cordic_angle3 = ((1 << 32)* 3 * j)/17;
        #10;
        j = j + 1;
    end 
    
    reg [15:0] Xin, Yin;
    wire [16:0] Xout1, Yout1, cos_cordic1, sin_cordic1;
    wire [16:0] Xout2, Yout2, cos_cordic2, sin_cordic2;
    wire [16:0] Xout3, Yout3, cos_cordic3, sin_cordic3;
    initial 
    begin
        Xin = 32000/1.647;
        Yin = 0;
    end
    
    CORDIC HARM1 (
        .clk(clk), 
        .angle(cordic_angle1), 
        .Xin(Xin), 
        .Yin(Yin), 
        .COS_OUT(Xout1), 
        .SIN_OUT(Yout1)
    );
    
    CORDIC HARM2 (
        .clk(clk), 
        .angle(cordic_angle2), 
        .Xin(Xin), 
        .Yin(Yin), 
        .COS_OUT(Xout2), 
        .SIN_OUT(Yout2)
    );
    
    CORDIC HARM3 (
        .clk(clk), 
        .angle(cordic_angle3), 
        .Xin(Xin), 
        .Yin(Yin), 
        .COS_OUT(Xout3), 
        .SIN_OUT(Yout3)
    );
 
    
   assign cos_cordic1 = Xout1;
   assign sin_cordic1 = Yout1;    
   assign cos_cordic2 = Xout2;
   assign sin_cordic2 = Yout2;    
   assign cos_cordic3 = Xout3;
   assign sin_cordic3 = Yout3;
   
   reg [4:0] fl_amp = 0;
   reg [2:0] state = 0; 
   reg signed [31:0] a_a0; 
   reg signed [32:0] a_a;//cos 
   reg signed [32:0] a_b;//sin 
   reg signed [32:0] a_a2;//cos 
   reg signed [32:0] a_b2;//sin 
   reg signed [32:0] a_a3;//cos 
   reg signed [32:0] a_b3;//sin [0:2]
//   reg signed [15:0] furry = 0;
//   reg [15:0] result_real = 1 << 2;
//   reg valid_FFT = 0;
   integer i = 0; 
   
//   CORDIC sincos(
//       .SIN_OUT(sin_i),
//       .COS_OUT(cos_i)
//   );



   initial 
       begin 
           finish_signal<=0; 
           a_a0<=0; 
           a_a <= 0; 
           a_b <= 0; 
           a_a2 <= 0; 
           a_b2 <= 0; 
           a_a3 <= 0; 
           a_b3 <= 0; 
       end 
   always @(posedge clk) 
       begin
           if(finish_signal) end_flag <= 1;
           else end_flag <= 0;
           if(reset) 
               begin 
                   state<=0; 
                   finish_signal<=0; 
                   end_flag <= 0;
                   a_a0<=0; 
                   a_a <= 0; 
                   a_b <= 0; 
                   a_a2 <= 0; 
                   a_b2 <= 0; 
                   a_a3 <= 0; 
                   a_b3 <= 0;
                   amplitude <= 0;
                   amplitude2 <= 0;
                   amplitude3 <= 0;
                   valid_FFT <= 0;
               end 
               else 
                   begin 
                       case(state)  
                           0: begin 
                               finish_signal <= 0; 
//                               valid_FFT <= 0;
                               if(start_signal && signal_in!=0) 
                                   begin 
                                       state <= 1; 
                                   end 
                              end 
                            1:
                                begin
                                    a_a0 <= a_a0 + signal_in; 
                                    a_a <= a_a + (signal_in * cos_cordic1);
                                    a_b <= a_b + (signal_in * sin_cordic1);
                                    a_a2 <= a_a2 + (signal_in * cos_cordic2);
                                    a_b2 <= a_b2 + (signal_in * sin_cordic2);
                                    a_a3 <= a_a3 + (signal_in * cos_cordic3);
                                    a_b3 <= a_b3 + (signal_in * sin_cordic3);
                                    state<= 2;
                                end
                            2:
                                       begin
                                           a_a0<= a_a0 / 17; 
                                           a_a <= (a_a * 2)/ 17; 
                                           a_b <= (a_b * 2)/ 17; 
                                           a_a2 <= (a_b2 * 2)/ 17;
                                           a_b2 <= (a_b2 * 2)/ 17; 
                                           a_a3 <= (a_b3 * 2)/ 17; 
                                           a_b3 <= (a_b3 * 2)/ 17;
                                           state <= 3;
                                end
                            3:
                                begin
                                    furry <= a_a0 + a_a * cos_cordic1 + a_b * sin_cordic1 + a_a2 * cos_cordic2 + a_b2 * sin_cordic2 + a_a3 * cos_cordic3 + a_b3 * sin_cordic3;
                                    if(fl_amp == 16)
                                        begin
                                            amplitude <= ((a_a*a_a + a_b*a_b));
                                            amplitude2 <= ((a_a2*a_a2 + a_b2*a_b2));
                                            amplitude3 <= ((a_a3*a_a3 + a_b3*a_b3));
                                            state <= 0;
                                            finish_signal <= 1;
                                            valid_FFT<=1;
                                        end
                                    else
                                        begin
                                            valid_FFT <= 0;
                                            state <= 0;
                                            finish_signal <= 1;
                                            fl_amp = fl_amp + 1;
                                        end
                                end
                                
                       endcase 
                   end 
       end 
endmodule
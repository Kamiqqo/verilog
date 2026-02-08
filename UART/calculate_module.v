`timescale 1ns / 1ps 
 
module newton( 
    input clk, 
    input reset, 
    input input_en, 
    input signed [3:0] DataIn, 
    output reg signed [3:0] X, 
    output reg valid_newton, 
    output reg failed,valid_in, 
    output reg [2:0] state, 
    output reg [3:0] new_x, top, bot, 
    output reg [3:0] a, b, c, x 
); 
    reg[3:0] counter = 0; 
    parameter wait_start = 0; 
    parameter read_data = 1; 
    parameter calculate = 2; 
    parameter data_out = 3; 
    parameter I = 3; 
    parameter d1 = 4; 
    parameter d2 = 5; 
     
    initial 
        begin 
            state = wait_start; 
            failed<=0; 
            valid_newton<=0; 
            valid_in<=0; 
            x<=0; 
            new_x<=0; 
            top<=0; 
            bot<=0; 
            X<=0; 
            a<=0; 
            b<=0; 
            c<=0;I <=0; 
           end 
    always @(posedge clk) begin 
        if (input_en) begin 
            if (counter < 1) begin 
               a <= DataIn;  
            end 
            else if (counter < 2) begin 
               b <= DataIn;  
            end 
            else if (counter < 3) begin 
               c <= DataIn;  
            end 
            else if (counter < 4) begin 
               x <= DataIn;  
            end 
            counter = counter + 1; 
            if(counter == 4)valid_in =1'd1; 
        end 
always @(posedge clk) begin 
    if(reset)begin 
        state <= wait_start; 
        failed <= 0; 
        valid_newton <= 0; 
        a <= 0;  
        b <= 0; 
        c <= 0; 
        x <= 0;  
        end 
    case(state) 
            wait_start: 
                if(input_en) 
                    state<=read_data; 
                else 
                    state<=state; 
            read_data: 
                if (valid_in)  
                    begin 
                        state <= calculate; 
                    end 
                else 
                    state<= state; 
            calculate: 
                if(valid_in == 1) 
                    begin 
                        state <= d1; 
                        d1: if (i < I) begin 
                        i = i + 1;  
                        state <= d2; 
                        end 
                        else 
                        state <= data_out; 
                        d2: top = ((a*(x**2))+(b*x)+c); 
                        bot = ((2*a*x)+b); 
                        new_x = (x - (top/bot)); 
                        if (bot == 0)  
                            begin 
                                failed <= 1; 
                                valid_newton <= 0;
                            end 
                        else  
                          begin 
                            X <= new_x; 
                            valid_newton <= 1; 
                            failed <= 0; 
                          end 
                        state <= d1 
                    end 
                else 
                    state <= state; 
            data_out: begin
              if(reset) 
                  state <= wait_start; 
              else 
                  state <= state; end
            default: 
              state <= wait_start; 
            endcase   
    end
endmodule

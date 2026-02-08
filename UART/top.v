`timescale 1ns / 1ns 
 
module UART # 
( 
    localparam CLOCK_RATE = 100_000_000, 
    localparam BAUD_RATE = 9600, 
    localparam ERROR_COUNT = 3, 
    localparam DIGIT_COUNT = 4  
) 
( 
 input clk, 
 input RsRx,  
 output RsTx, 
 output siganl_input, 
 output siganl_out,  
    output [7:0] AN, 
    output [6:0] SEG 
); 
wire [7:0] fifo_out_on_plate; 
// FSM 
wire [15:0] FSM_Data_Input;  
wire FSM_Ready_Input;  
wire FSM_Ready_Output;  
wire [15:0] FSM_Data_Output;  
reg [31:0] NUMBER; 
wire [1:0] FSM_Error_Output; 
wire reset = 1'b0; 
reg siganl_out_reg; 
reg siganl_input_reg = 0; 
always @(posedge clk) begin 
    if(FSM_Ready_Input) begin 
        siganl_input_reg <= 1; 
        NUMBER <= fifo_out_on_plate; 
    end 
    else if(FSM_Ready_Output) 
        NUMBER <= FSM_Data_Output; 
        siganl_out_reg <= 1; 
    end 
assign siganl_out = siganl_out_reg; 
assign siganl_input = siganl_input_reg;
// Автомат, занимающийся менеджментом входных данных с UART 
UART_Input_Manager #(.DIGIT_COUNT(DIGIT_COUNT)) uart_input_manager  
( 
 .clk(clk),   // Вход синхросигнала 
 .reset(reset), 
 .RsRx(RsRx), 
 .out(FSM_Data_Input),// Выход со значением для входа основного автомата 
 .ready_out(FSM_Ready_Input), 
 .fifo_out_on_plate(fifo_out_on_plate) // Выход - сигнал о том, что 
данные на выходе <number_out> сформированы 
); 
// Автомат, занимающийся менеджментом выходных данных на UART 
UART_Output_Manager #(.ERROR_COUNT(ERROR_COUNT)) uart_output_manager  
( 
 .clk(clk), // Вход: Синхросигнал 
 .reset(reset), 
 .ready_in(FSM_Ready_Output), // Вход: сигнал о том, что данные для 
отправки по UART сформированы 
 .data_in(FSM_Data_Output),   // Вход: данные для отправки по UART 
 .error_in(FSM_Error_Output), // Вход: данные об ошибках для отправки по 
UART 
 .RsTx(RsTx) 
); 
 
newton aut( 
    .clk(clk), 
    .reset(reset_signal), 
    .input_en(input_en), 
    .DataIn(Data_in), 
    .new_x(new_x), 
    .a(a), 
    .b(b), 
    .c(c), 
    .valid_quad(valid_quad), 
    .failed(is_failed), 
    .valid_in(), 
    .state() 
    ); 
 
     
    always@(posedge clk) 
    begin 
        if (reset_signal) 
        begin 
            Data_in <= 0; 
            NUMBER <= 0; 
            is_data_last <= 0; 
            input_en <= 0; 
            AN_MASK <= 8'b11111111; 
        end 
        else if (FSM_Ready_Input) 
            begin 
                Data_in <= FSM_Data_Input; 
                is_data_last <= 1; 
                data_last<=FSM_Data_Input; 
                input_en<=1; 
            end 
             
         if(valid_quad || Data_in < 0)  
                begin 
                    is_data_last <= 0; 
                    n <= NEXT(n); 
             end 
        else if(Data_in == 0) 
            begin  
                FSM_Error_Output = 1; 
                AN_MASK <= 8'b00000000;  
            end 
        else if(valid_quad && button_out_signal_en) 
            begin 
                FSM_Data_Output = new_x; AN_MASK=~8'b00000001; 
            end 
             
function [2:0] NEXT ( input [2:0] num); 
        begin 
            if(num == 5) 
                NEXT = 1; 
            else 
                NEXT = num + 1; 
        end 
endfunction 
 
 
clk_divider #(1024) div( 
        .clk(clk), 
        .clk_div(clk_div) 
    ); 
 
SevenSegmentLED disp( 
    .AN_MASK(8'b00000000), 
    .NUMBER(NUMBER), 
    .clk(clk_div), 
    .ce(1'b1), 
    .RESET(1'b0), 
    .AN(AN), 
    .SEG(SEG) 
); 
endmodule 

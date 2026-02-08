module UART_RX # 
( 
 parameter CLOCK_RATE = 100_000_000, // Частота ПЛИС - по умолчанию, частота XC7A100T-1CSG324C семейства Artix-7 (в Гц) 
 parameter BAUD_RATE = 9600   // Скорость передачи данных по UART (в бод) 
) 
( 
 input clk,   
 input rx,  
  
 output reg UART_RX_Ready_Out, 
 output reg [7:0] UART_RX_Data_Out  
); 
reg [1:0] state; 
reg [3:0] bit_counter; 
 
reg [$clog2(CLOCK_RATE / BAUD_RATE):0] baud_counter; 
reg baud_flag; 
localparam RESET = 0, WAIT_START_BIT = 1, LOAD_BIT = 2, WAIT_HALF_RATE = 3; 
initial  
begin 
 state = RESET; 
 baud_flag = 0; 
 baud_counter = 0; 
 bit_counter = 0; 
 UART_RX_Data_Out = 0; 
 UART_RX_Ready_Out = 0; 
end 

reg [2:0] major_buf = 3'b111; 
wire major_out = major_buf[0] & major_buf[1] | 
                 major_buf[0] & major_buf[2] | 
                 major_buf[1] & major_buf[2];  
always@(posedge clk) 
    major_buf <= {major_buf[1:0], rx}; 
always@(posedge clk) 
begin 
 case(state) 
    RESET: 
   begin 
    bit_counter <= 0;   
    baud_counter <= 0; 
    UART_RX_Data_Out <= 0; 
              UART_RX_Ready_Out <= 0; 
    state <= WAIT_START_BIT; 
   end 
        WAIT_START_BIT:  
   if (~major_out) 
                state <= LOAD_BIT; 
     
  LOAD_BIT: 
   if (baud_flag)  
    if (bit_counter == 9) 
     begin 
      if (rx)  
       UART_RX_Ready_Out <= 1; 
      state <= RESET; 
     end 
    else 
        begin  
    if (bit_counter != 0) 
         UART_RX_Data_Out <= {major_out, UART_RX_Data_Out[7:1]}; 
         bit_counter <= bit_counter + 1;
         state <= WAIT_HALF_RATE;    
     end  
      
  WAIT_HALF_RATE:
   if (baud_flag) 
    state <= LOAD_BIT; 
 endcase 
 
 if (baud_counter == CLOCK_RATE / BAUD_RATE /2) 
  begin 
   baud_flag <= 1;   
   baud_counter <= 0; 
  end 
 else  
  begin 
   baud_flag <= 0; 
   baud_counter <= baud_counter + 1;
  end 
end  
endmodule

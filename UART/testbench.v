`timescale 1ns/1ns 
module tb_uart; 
 
    localparam CLOCK_RATE = 100_000_000; 
    localparam BAUD_RATE  = 9600; 
    localparam BIT_TIME   = (CLOCK_RATE / BAUD_RATE) * 10;   
 
    reg clk = 0; 
    always #5 clk = ~clk;  
 
    reg RsRx; 
  wire RsTx;     
    wire siganl_input, siganl_out; 
    wire [7:0] AN; 
    wire [6:0] SEG; 
    UART dut ( 
        .clk(clk), 
        .RsRx(RsRx), 
        .RsTx(RsTx), 
        .siganl_input(siganl_input), 
        .siganl_out(siganl_out), 
        .AN(AN), 
        .SEG(SEG) 
    ); 
    reg need_to_see = 0; 
     reg need_to_see_stop = 0; 
    task uart_send_byte; 
        input [7:0] b; 
        integer i; 
        begin 
            RsRx = 0; 
            #(BIT_TIME); 
            for(i = 0; i < 8; i = i + 1) begin 
                RsRx = b[i]; 
                need_to_see = 1; 
                #(BIT_TIME); 
            end 
            RsRx = 1; 
            need_to_see_stop = 1; 
            #(BIT_TIME); 
        end 
    endtask 
 
    task uart_send_string; 
        input [8*32-1:0] str;  
        integer i; 
        reg [7:0] ch; 
        begin 
            for(i = 0; i < 32; i = i + 1) begin 
                ch = str[8*(32-i)-1 -: 8]; 
                if (ch != 0) begin 
                    uart_send_byte(ch); 
                end  
            end 
        end 
    endtask 
 
    initial begin 
        RsRx = 1;  
        #(BIT_TIME*5); 
 
        $display("=== START UART TEST ==="); 
 
        $display("Sending: 1A2F<CR>"); 
 
        uart_send_byte("1"); 
        need_to_see_stop = 0; 
        uart_send_byte("1"); 
        need_to_see_stop = 0; 
         uart_send_byte("2"); 
         need_to_see_stop = 0; 
         uart_send_byte("3"); 
         need_to_see_stop = 0;
         uart_send_byte(8'h0D); 
         #(BIT_TIME * 200); 
         uart_send_byte("1"); 
         need_to_see_stop = 0; 
         uart_send_byte("1"); 
         need_to_see_stop = 0; 
         uart_send_byte("9"); 
         need_to_see_stop = 0; 
         uart_send_byte("3"); 
         need_to_see_stop = 0; 
         uart_send_byte(8'h0D); 
         #(BIT_TIME * 200); 
         uart_send_byte("1"); 
         need_to_see_stop = 0; 
         uart_send_byte("0"); 
         need_to_see_stop = 0; 
         uart_send_byte("1"); 
         need_to_see_stop = 0; 
         uart_send_byte("0"); 
         need_to_see_stop = 0; 
         uart_send_byte(8'h0D); 
         #(BIT_TIME * 200); 
        $display("=== TEST COMPLETE ==="); 
        $stop; 
    end 
endmodule

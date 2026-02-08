module HEX_To_ASCII( 
input  [3:0] HEX_in, 
output reg [7:0] ASCII_out 
); 
always @(*) 
    begin 
        case (HEX_in) 
            4'h0: ASCII_out = 8'h30; 
            4'h1: ASCII_out = 8'h31; 
            4'h2: ASCII_out = 8'h32; 
            4'h3: ASCII_out = 8'h33; 
            4'h4: ASCII_out = 8'h34; 
            4'h5: ASCII_out = 8'h35; 
            4'h6: ASCII_out = 8'h36; 
            4'h7: ASCII_out = 8'h37; 
            4'h8: ASCII_out = 8'h38; 
            4'h9: ASCII_out = 8'h39; 
            4'hA: ASCII_out = 8'h41; 
            4'hB: ASCII_out = 8'h42; 
            4'hC: ASCII_out = 8'h43; 
            4'hD: ASCII_out = 8'h44; 
            4'hE: ASCII_out = 8'h45; 
            4'hF: ASCII_out = 8'h46; 
            default: ASCII_out = 8'h3F; 
        endcase 
    end 
endmodule 

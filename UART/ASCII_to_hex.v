module ASCII_To_HEX( 
    input  [7:0] ASCII_in, 
    output reg [3:0] HEX_out 
); 
always @(*) begin 
    case (ASCII_in) 
        8'h30: HEX_out = 4'h0; 
        8'h31: HEX_out = 4'h1; 
        8'h32: HEX_out = 4'h2; 
        8'h33: HEX_out = 4'h3; 
        8'h34: HEX_out = 4'h4; 
        8'h35: HEX_out = 4'h5; 
        8'h36: HEX_out = 4'h6; 
        8'h37: HEX_out = 4'h7; 
        8'h38: HEX_out = 4'h8; 
        8'h39: HEX_out = 4'h9; 
        8'h41: HEX_out = 4'hA; 
        8'h42: HEX_out = 4'hB; 
        8'h43: HEX_out = 4'hC; 
        8'h44: HEX_out = 4'hD; 
        8'h45: HEX_out = 4'hE; 
        8'h46: HEX_out = 4'hF; 
        8'h61: HEX_out = 4'hA;  
        8'h62: HEX_out = 4'hB; 
        8'h63: HEX_out = 4'hC; 
        8'h64: HEX_out = 4'hD; 
        8'h65: HEX_out = 4'hE; 
        8'h66: HEX_out = 4'hF; 
        default: HEX_out = 4'h0; 
    endcase 
end 
endmodule

module ANALIZATOR_SEQ ( 
  input CLK, RST, 
  input CE, 
  input [3:0] DAT_I, 
  output reg [15:0] LED, 
  output [7:0] NOM_BLANK 
); 
reg [4:0] STATE; 
reg [15:0] NOM; 
 
assign NOM_BLANK = NOM[7:0]; 
always@(posedge CLK, posedge RST) 
    begin 
        if(RST) 
            begin 
                STATE <= 5'd0; 
                NOM <= 16'h0000; 
            end 
        else if(~RST) 
            begin 
                case(STATE) 
                    5'd0:  
                        if(CE)  
                            begin 
                                if(DAT_I == 4) 
                                    begin 
                                        STATE <= 5'd1; 
                                        NOM <= 16'b1; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                            end 
                    5'd1: 
                        if(CE) 
                            begin 
                                if(DAT_I == 7) 
                                    begin 
                                        STATE <= 5'd2; 
                                        NOM <= 16'h2; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                            end 
                    5'd2: 
                        if(CE) 
                            begin 
                                if(DAT_I == 4'hC) 
                                    begin 
                                        STATE <= 5'd3; 
                                        NOM <= 16'h3; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                            end 
                     5'd3: 
                        if(CE) 
                            begin 
                                if(DAT_I == 5) 
                                    begin 
                                        STATE <= 5'd4; 
                                        NOM <= 16'h4; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                            end 
                     5'd4:                        if(CE) 
 
                            begin 
                                if(DAT_I == 3) 
                                    begin 
                                        STATE <= 5'd5; 
                                        NOM <= 16'h5; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd5: 
                        if(CE) 
                            begin 
                                if(DAT_I == 2) 
                                    begin 
                                        STATE <= 5'd6; 
                                        NOM <= 16'h6; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd6: 
                        if(CE) 
                            begin 
                                if(DAT_I == 4'hF) 
                                    begin 
                                        STATE <= 5'd7; 
                                        NOM <= 16'h7; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd7: 
                        if(CE) 
                            begin 
                                if(DAT_I == 3) 
                                    begin 
                                        STATE <= 5'd8; 
                                        NOM <= 16'h8; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd8:                        if(CE) 
 
                            begin 
                                if(DAT_I == 5) 
                                    begin 
                                        STATE <= 5'd9; 
                                        NOM <= 16'h9; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd9: 
                        if(CE) 
                            begin 
                                if(DAT_I == 9) 
                                    begin 
                                        STATE <= 5'd10; 
                                        NOM <= 16'h10; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd10: 
                        if(CE) 
                            begin 
                                if(DAT_I == 2) 
                                    begin 
                                        STATE <= 5'd11; 
                                        NOM <= 16'h11; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd11: 
                        if(CE) 
                            begin 
                                if(DAT_I == 4'hA) 
                                    begin 
                                        STATE <= 5'd12; 
                                        NOM <= 16'h12; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd12:                        if(CE) 
 
                            begin 
                                if(DAT_I == 3) 
                                    begin 
                                        STATE <= 5'd13; 
                                        NOM <= 16'h13; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd13: 
                        if(CE) 
                            begin 
                                if(DAT_I == 4'hB) 
                                    begin 
                                        STATE <= 5'd14; 
                                        NOM <= 16'h14; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd14: 
                        if(CE) 
                            begin 
                                if(DAT_I == 4'h4) 
                                    begin 
                                        STATE <= 5'd15; 
                                        NOM <= 16'h15; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd15: 
                        if(CE) 
                            begin 
                                if(DAT_I == 4'hB) 
                                    begin 
                                        STATE <= 5'd16; 
                                        NOM <= 16'h16; 
                                    end 
                                else begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'b0; 
                                end 
                             end 
                     5'd16:                        if(CE) 
  
                            begin 
                                begin 
                                    STATE <= 5'd0; 
                                    NOM <= 16'h16; 
                                end 
                             end 
                     default: 
                        begin 
                            STATE <= 5'd0; 
                            NOM <= 16'h0; 
                        end 
                endcase 
                case(NOM) 
                    16'h0: LED <= 16'b0000000000000000; 
                    16'h1: LED <= 16'b0000000000000001; 
                    16'h2: LED <= 16'b0000000000000011; 
                    16'h3: LED <= 16'b0000000000000111; 
                    16'h4: LED <= 16'b0000000000001111; 
                    16'h5: LED <= 16'b0000000000011111; 
                    16'h6: LED <= 16'b0000000000111111; 
                    16'h7: LED <= 16'b0000000001111111; 
                    16'h8: LED <= 16'b0000000011111111; 
                    16'h9: LED <= 16'b0000000111111111; 
                    16'h10: LED <= 16'b0000001111111111; 
                    16'h11: LED <= 16'b0000011111111111; 
                    16'h12: LED <= 16'b0000111111111111; 
                    16'h13: LED <= 16'b0001111111111111; 
                    16'h14: LED <= 16'b0011111111111111; 
                    16'h15: LED <= 16'b0111111111111111; 
                    16'h16: LED <= 16'b1111111111111111; 
                     
                    default: LED <= 0; 
                endcase 
            end 
    end 
endmodule 

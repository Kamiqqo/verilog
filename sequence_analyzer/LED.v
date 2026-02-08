`timescale 1ns / 1ps 
 
module SEG( 
    input CLK_100, 
    input RST, 
    input CE, 
    input [31:0] HEX_IN, 
    input [7:0] BLANK, 
    input [7:0] DP_IN, 
    output reg [7:0] AN, 
    output [7:0] CAT//не - reg в ассигне рег в олвейсе 
    ); 
     
reg [3:0] count; 
reg [3:0] HEX_MX; 
reg I_EN; 
reg DP; 
wire [7:0] SEG; 
 
always@(posedge CLK_100, posedge RST) 
if(RST) count <= 0; 
else if(CE) count <= count + 1; 
 
always@* 
    case(count) 
        0: HEX_MX <= HEX_IN[3:0]; 
        1: HEX_MX <= HEX_IN[7:4]; 
        2: HEX_MX <= HEX_IN[11:8]; 
        3: HEX_MX <= HEX_IN[15:12];  
        4: HEX_MX <= HEX_IN[19:16]; 
        5: HEX_MX <= HEX_IN[23:20]; 
        6: HEX_MX <= HEX_IN[27:24]; 
        default: HEX_MX <= HEX_IN[31:28]; 
    endcase 
     
always@* 
    case(count) 
        0: I_EN <= ~BLANK[0]; 
        1: I_EN <= ~BLANK[1]; 
        2: I_EN <= ~BLANK[2]; 
        3: I_EN <= ~BLANK[3];  
        4: I_EN <= ~BLANK[4]; 
5: I_EN <= ~BLANK[5]; 
        6: I_EN <= ~BLANK[6]; 
        default: I_EN <= ~BLANK[7]; 
    endcase 
     
always@* 
    case(count) 
        0: DP <= DP_IN[0]; 
        1: DP <= DP_IN[1]; 
        2: DP <= DP_IN[2]; 
        3: DP <= DP_IN[3];  
        4: DP <= DP_IN[4]; 
        5: DP <= DP_IN[5]; 
        6: DP <= DP_IN[6]; 
        default: DP <= DP_IN[7]; 
    endcase 
     
 
M_7SEG_DECODER_V11 decodr( 
    .I_CODE(HEX_MX), 
    .I_EN(I_EN), 
    .O_SEG_A(SEG[0]), 
    .O_SEG_A(SEG[1]), 
    .O_SEG_A(SEG[2]), 
    .O_SEG_A(SEG[3]), 
    .O_SEG_A(SEG[4]), 
    .O_SEG_A(SEG[5]), 
    .O_SEG_A(SEG[6]) 
); 
assign CAT = {DP, ~SEG}; 
 
 
endmodule 

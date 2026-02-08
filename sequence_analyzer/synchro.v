module synch( 
    input CLK_48, 
    input SYS_NRST, 
    output reg N_ST  
    ); 
     
reg [1:0] SYS_NRST_RG; 
wire RST; 
wire CEO_1Khz; 
reg[7:0] BLANK_SH_RG; 
reg BTN_OR; 
reg [31:4] HEX_IN_SH_RG; 
reg [3:0] SEQ; 
wire[31:0] BLANK; 
wire [31:0] HEX_IN; 
 
 
always@(posedge CLK_48, negedge SYS_NRST)//synchro 
    if(~SYS_NRST) SYS_NRST_RG <= 2'b11; 
    else SYS_NRST_RG <= {SYS_NRST_RG[0],1'b0}; 
assign RST = SYS_NRST_RG[1]; 
 
LV_DIVIDER_V10 #( 
    .CNT_WDT(16),     
    .DIV_VAL(48000)     
)DIVID_1Khz( 
    .CLK(CLK_48), 
    .RST(RST), 
    .CEO(CEO_1Khz) 
 
always@(posedge CLK_48, posedge RST)
if(RST) BLANK_SH_RG <= 8'd0;
else if(BTN_OR) BLANK_SH_RG <= {BLANK_SH_RG[6:0],1'b0}; 
always@(posedge CLK_48, posedge RST)begin 
    if(RST)begin HEX_IN_SH_RG <= 28'd0; BLANK_SH_RG <= 7'h7f;end 
    else if(BTN_OR)begin HEX_IN_SH_RG <= HEX_IN[27:0]; BLANK_SH_RG <= 
BLANK[6:0];end 
 end 
assign  BLANK = {BLANK_SH_RG, 1'b0}; 
assign HEX_IN = {HEX_IN_SH_RG, SEQ}; 
endmodule 

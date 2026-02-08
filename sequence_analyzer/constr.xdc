set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK_48 
}]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz 
create_clock -add -name sys_clk_pin -period 100.00 -waveform {0 5} [get_ports {CLK_48}]; 
 
 
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { 
SWITCHES_IN[0] }];  
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { 
SWITCHES_IN[1] }];  
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { 
SWITCHES_IN[2] }];  
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { 
SWITCHES_IN[3] }];  
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { 
SWITCHES_SIDE[4] }];  
 
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { 
LED_NUM[0] }]; #IO_L18P_T2_A24_15 Sch=led[0] 
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { 
LED_NUM[1] }]; #IO_L24P_T3_RS1_15 Sch=led[1] 
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { 
LED_NUM[2] }]; #IO_L17N_T2_A25_15 Sch=led[2] 
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { 
LED_NUM[3] }]; #IO_L8P_T1_D11_14 Sch=led[3] 
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { 
LED_SEQ[0] }]; #IO_L7P_T1_D09_14 Sch=led[4] 
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { 
LED_SEQ[1] }]; #IO_L18N_T2_A11_D27_14 Sch=led[5] 
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { 
LED_SEQ[2] }]; #IO_L17P_T2_A14_D30_14 Sch=led[6] 
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { 
LED_SEQ[3] }]; #IO_L18P_T2_A12_D28_14 Sch=led[7] 
 
 
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { AN[0] }]; 
#IO_L23P_T3_FOE_B_15 Sch=an[0] 
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { AN[1] }]; 
#IO_L23N_T3_FWE_B_15 Sch=an[1] 
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { AN[2] }]; 
#IO_L24P_T3_A01_D17_14 Sch=an[2] 
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { AN[3] }];  

#IO_L19P_T3_A22_15 Sch=an[3] 
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { AN[4] }]; 
#IO_L8N_T1_D12_14 Sch=an[4] 
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { AN[5] }]; 
#IO_L14P_T2_SRCC_14 Sch=an[5] 
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { AN[6] }]; 
#IO_L23P_T3_35 Sch=an[6] 
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { AN[7] }]; 
#IO_L23N_T3_A02_D18_14 Sch=an[7] 
 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[0]}] 
set_property PACKAGE_PIN T10 [get_ports {CAT[0]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[1]}] 
set_property PACKAGE_PIN R10 [get_ports {CAT[1]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[2]}] 
set_property PACKAGE_PIN K16 [get_ports {CAT[2]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[3]}] 
set_property PACKAGE_PIN K13 [get_ports {CAT[3]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[4]}] 
set_property PACKAGE_PIN P15 [get_ports {CAT[4]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[5]}] 
set_property PACKAGE_PIN T11 [get_ports {CAT[5]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[6]}] 
set_property PACKAGE_PIN L18 [get_ports {CAT[6]}] 
 
set_property IOSTANDARD LVCMOS33 [get_ports {CAT[7]}] 
set_property PACKAGE_PIN H15 [get_ports {CAT[7]}] 
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { BTN_0 }]; 
#IO_L9P_T1_DQS_14 Sch=btnc 
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { BTN_1 
}]; #IO_L4N_T0_D05_14 Sch=btnu 
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { 
SYS_NRST }]; #IO_L12P_T1_MRCC_14 Sch=btnl 

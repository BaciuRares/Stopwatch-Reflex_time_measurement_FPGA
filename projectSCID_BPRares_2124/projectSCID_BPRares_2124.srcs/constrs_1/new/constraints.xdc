# /////////////////////////////////////////////////////////////
# CONSTRAINTS pentru proiectul Stopwatch pe placa Basys 3
# Afișaj 7-segmente, butoane pentru control și LED-uri pentru scor
# /////////////////////////////////////////////////////////////

# ------------------------
# Ceas de sistem - 100 MHz
# ------------------------
set_property PACKAGE_PIN W5 [get_ports {CLK}]
set_property IOSTANDARD LVCMOS33 [get_ports {CLK}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK}]

# ------------------------
# Butoane de control
# ------------------------
# S1 - BTNR: START cronometru
set_property PACKAGE_PIN T17 [get_ports {S1}]
set_property IOSTANDARD LVCMOS33 [get_ports {S1}]

# S2 - BTNC: STOP + scor
set_property PACKAGE_PIN U18 [get_ports {S2}]
set_property IOSTANDARD LVCMOS33 [get_ports {S2}]

# RST - BTNL: RESET complet
set_property PACKAGE_PIN W19 [get_ports {RST}]
set_property IOSTANDARD LVCMOS33 [get_ports {RST}]

# S3 - BTNU: Afișare timp minim (Best)
set_property PACKAGE_PIN T18 [get_ports {S3}]
set_property IOSTANDARD LVCMOS33 [get_ports {S3}]

# S4 - BTND: Afișare timp maxim (Worst)
set_property PACKAGE_PIN U17 [get_ports {S4}]
set_property IOSTANDARD LVCMOS33 [get_ports {S4}]

# ------------------------
# Afișaj 7-segmente: segmente a-g
# ------------------------
set_property PACKAGE_PIN W7 [get_ports {segments[6]}]  ;# g
set_property IOSTANDARD LVCMOS33 [get_ports {segments[6]}]

set_property PACKAGE_PIN W6 [get_ports {segments[5]}]  ;# f
set_property IOSTANDARD LVCMOS33 [get_ports {segments[5]}]

set_property PACKAGE_PIN U8 [get_ports {segments[4]}]  ;# e
set_property IOSTANDARD LVCMOS33 [get_ports {segments[4]}]

set_property PACKAGE_PIN V8 [get_ports {segments[3]}]  ;# d
set_property IOSTANDARD LVCMOS33 [get_ports {segments[3]}]

set_property PACKAGE_PIN U5 [get_ports {segments[2]}]  ;# c
set_property IOSTANDARD LVCMOS33 [get_ports {segments[2]}]

set_property PACKAGE_PIN V5 [get_ports {segments[1]}]  ;# b
set_property IOSTANDARD LVCMOS33 [get_ports {segments[1]}]

set_property PACKAGE_PIN U7 [get_ports {segments[0]}]  ;# a
set_property IOSTANDARD LVCMOS33 [get_ports {segments[0]}]

# Punct zecimal (DP)
set_property PACKAGE_PIN V7 [get_ports {DP}]
set_property IOSTANDARD LVCMOS33 [get_ports {DP}]

# ------------------------
# Anode 7-segmente (activ low)
# ------------------------
set_property PACKAGE_PIN U2 [get_ports {Anodes[0]}]  ;# AN0
set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[0]}]

set_property PACKAGE_PIN U4 [get_ports {Anodes[1]}]  ;# AN1
set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[1]}]

set_property PACKAGE_PIN V4 [get_ports {Anodes[2]}]  ;# AN2
set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[2]}]

set_property PACKAGE_PIN W4 [get_ports {Anodes[3]}]  ;# AN3
set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[3]}]

# ------------------------
# LED-uri 0-9: scor vizual
# ------------------------
set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]

set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]

set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]

set_property PACKAGE_PIN V19 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]

set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]

set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]

set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]

set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]

set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]

set_property PACKAGE_PIN V3 [get_ports {LED[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]

yosys -import
plugin -i sdc
#Import the commands from the plugins to the tcl interpreter
yosys -import

read_verilog set_max_delay.v
# Some of symbiflow expects eblifs with only one module.
synth_xilinx -vpr -flatten -abc9 -nosrl -noclkbuf -nodsp

# -to inter_wire net
set_max_delay 1 -to inter_wire

# -from clk net (quiet)
set_max_delay 2 -quiet -from clk

# -from clk to bottom_inst/I
set_max_delay 3 -from clk -to bottom_inst.I

write_sdc set_max_delay.sdc

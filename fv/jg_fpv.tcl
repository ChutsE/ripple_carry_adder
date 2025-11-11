clear -all

set sepIdx [lsearch $argv ---]
if {$sepIdx == -1 || [expr {$sepIdx + 1}] >= [llength $argv]} {
  puts "-Uso: jg -tcl jg_fpv.tcl --- <nombre_top_module>" 
  exit 1
}
set FV_TOP [lindex $argv [expr {$sepIdx + 1}]]

### add here secundary files for analysis if needed

### ----------------------------------

set RTL_DIR "/home/disdig/ripple_carry_adder/rtl"
set FV_DIR  "/home/disdig/ripple_carry_adder/fv"

foreach f {
  dff.sv
  full_adder.sv
  ripple_carry_adder.sv
} {
  eval analyze -sv $RTL_DIR/$f
}



eval analyze -sv $FV_DIR/aux_logic/flipflop.v
eval analyze -sv $FV_DIR/aux_logic/shift.v
eval analyze -sv $FV_DIR/aux_logic/bus_shift.v
eval analyze -sv $FV_DIR/fv_$FV_TOP.sv

elaborate -top $FV_TOP
get_design_info

clock clk
reset -expression !arst_n

prove -all


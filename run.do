vlib work 
vdel -all 
vlib work 

vlog -f fifo.list +acc -sv 
vsim work.tb 
add wave -r *
run -all
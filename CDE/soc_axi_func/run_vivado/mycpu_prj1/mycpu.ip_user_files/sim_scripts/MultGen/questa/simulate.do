onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib MultGen_opt

do {wave.do}

view wave
view structure
view signals

do {MultGen.udo}

run -all

quit -force

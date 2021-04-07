VC=irun

SEED := $(shell bash -c 'echo $$RANDOM')

V_FLAGS=-64bit -sv -gui -clean -access +rwc +bus_conflict_off -nowarn "NONPRT" -seed random
INC_DIRS=-incdir ../.. -incdir ../../rtl -incdir ../../include -incdir ../../bench

WORK_DIR_ROOT=ncsim
WORK_DIR_HEIR=run
WORK_DIR=$(WORK_DIR_ROOT)/$(WORK_DIR_HEIR)

CMD_FILE=t_go.f

UVM_VERBOSITY=UVM_LOW
UVM_HOME=/home/soft/INCISIVE151/tools/methodology/UVM/CDNS-1.1d/sv
UVM_FLAGS=-uvm -uvmhome $(UVM_HOME) +UVM_VERBOSITY=$(UVM_VERBOSITY) +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR -incdir ${UVM_HOME}/src ${UVM_HOME}/src/uvm_pkg.sv

TOP_FILE=../../bench/tb_top.sv
RTL=../../bench/dds_sin_package.sv
MODEL=../../rtl/dds_sin.sv

help:

create_libs:
	vlib work
	vlib work/test

map_libs:
	vmap test work/test

comp_sv:
	vlog -64 \
	-work def_lib \
	-L test \
	-work def_lib -work def_lib dds_sin_if.sv \
	-work def_lib -work def_lib dds_sin_package.sv \
	-work def_lib tb_top.sv

run_sim:
	vsim -64 -voptargs="+acc" \
	-L test \
	-L def_lib -lib def_lib def_lib.tb_top \
	-do "run -all" \

cr:
	mkdir $(WORK_DIR_ROOT)
	mkdir $(WORK_DIR)

sim:
	#   _____  _____   _____          _____ _____ _   _ 
	#  |  __ \|  __ \ / ____|        / ____|_   _| \ | |
	#  | |  | | |  | | (___         | (___   | | |  \| |
	#  | |  | | |  | |\___ \         \___ \  | | | . ` |
	#  | |__| | |__| |____) |        ____) |_| |_| |\  |
	#  |_____/|_____/|_____/        |_____/|_____|_| \_|
	#                    ______ ______                  
	#                   |______|______|                 

	
	cd $(WORK_DIR); echo "$(V_FLAGS)" > $(CMD_FILE);
	cd $(WORK_DIR); echo "$(INC_DIRS)" >> $(CMD_FILE);
	cd $(WORK_DIR); echo "$(UVM_FLAGS)" >> $(CMD_FILE);
	cd $(WORK_DIR); echo "$(MODEL)" >> $(CMD_FILE);
	cd $(WORK_DIR); echo "$(RTL)" >> $(CMD_FILE);
	cd $(WORK_DIR); echo "$(TOP_FILE)" >> $(CMD_FILE);
	cd $(WORK_DIR); $(VC) -f $(CMD_FILE) #-s -input wave.tcl -run


	#   _____  _____   _____          _____ _____ _   _ 
	#  |  __ \|  __ \ / ____|        / ____|_   _| \ | |
	#  | |  | | |  | | (___         | (___   | | |  \| |
	#  | |  | | |  | |\___ \         \___ \  | | | . ` |
	#  | |__| | |__| |____) |        ____) |_| |_| |\  |
	#  |_____/|_____/|_____/        |_____/|_____|_| \_|
	#                    ______ ______                  
	#                   |______|______|                 


all: \
	create_libs \
	map_libs \
	comp_sv \
	run_sim \
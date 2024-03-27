# Block Name
export BLOCK = calculator

# Include Paths
PATHS = +incdir+../../RTL/ \
        +incdir+../src/

# RTL Paths and Files
export RTL_SRC = ../../RTL
RTL_RUN_FILES = ${VERIF_SCRIPTS}/${BLOCK}_run_rtl_files.f

# Verification Paths and Files
export VERIF_SRC = ../src
VERIF_SCRIPTS = ../scripts
VERIF_RUN_FILES = ${VERIF_SCRIPTS}/${BLOCK}_run_verification_files.f
MODEL = ${VERIF_SRC}/external.cpp
MODEL_BINARY = test.so
TEST = ${BLOCK}_test
CYCLES = 1234
RUN_ARGS_COMMON = -access +r -input ${VERIF_SCRIPTS}/shm.tcl \
      +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

# Commands
compile_model:
	@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o $(MODEL_BINARY)

sim: compile_model
	xrun -64bit -uvm $(PATHS) -f $(VERIF_RUN_FILES) -f $(RTL_RUN_FILES) -sv_lib $(MODEL_BINARY) \
             +UVM_TESTNAME=$(TEST) $(RUN_ARGS_COMMON) +CYCLES=$(CYCLES) $(GUI)

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .bpad/ .simvision/ simvision* xcelium.d .reinvoke.sim simv.daidir *.so *.o *.err

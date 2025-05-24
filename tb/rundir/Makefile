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
VERBOSITY = UVM_MEDIUM
CYCLES = 1234
RUN_ARGS_COMMON = -64bit -uvm -access +r -input ${VERIF_SCRIPTS}/shm.tcl \
      +uvm_set_config_int=*,recording_detail,1 -clean
COV_ARGS = -coverage all -covoverwrite
XCELIUM_HOME = xrun
IMC_HOME = imc

# Commands
compile_model:
	@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o $(MODEL_BINARY)

sim: compile_model
	$(XCELIUM_HOME) $(RUN_ARGS_COMMON) $(COV_ARGS) $(PATHS) -f $(VERIF_RUN_FILES) -f $(RTL_RUN_FILES) \
		-sv_lib $(MODEL_BINARY) +CYCLES=$(CYCLES) +UVM_VERBOSITY=$(VERBOSITY) +UVM_TESTNAME=$(TEST) $(ARGS)

coverage:
	$(IMC_HOME) -load cov_work/scope/test

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .bpad/ .simvision/ simvision* xcelium.d .reinvoke.sim simv.daidir *.so *.o *.err

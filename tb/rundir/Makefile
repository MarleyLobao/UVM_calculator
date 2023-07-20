PATHS = +incdir+../../RTL/ \
        +incdir+../src/

IFS = ../src/calculator_if.sv

PKGS = ../src/calculator_pkg.sv

TOP = ../src/calculator_top.sv

MODEL = ../src/external.cpp

RTL = ../../RTL/calculator.sv

RUN_ARGS_COMMON = -access +r -input ../scripts/shm.tcl \
		  +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

sim:
	@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o test.so
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) -sv_lib test.so \
            +UVM_TESTNAME=calculator_test $(RUN_ARGS_COMMON) +CYCLES=1234

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .bpad/ .simvision/ simvision* xcelium.d .reinvoke.sim simv.daidir *.so *.o *.err

gui:
	@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o test.so
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) -sv_lib test.so \
            +UVM_TESTNAME=calculator_test $(RUN_ARGS_COMMON) +CYCLES=1234 -gui

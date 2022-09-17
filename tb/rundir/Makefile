PATHS = +incdir+../../RTL/ \
        +incdir+../src/

IFS = ../src/calculator_if.sv

PKGS = ../src/calculator_pkg.sv

TOP = ../src/calculator_top.sv

MODEL = ../src/external.cpp

RTL = ../../RTL/calculator.sv

sim:
	@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o test.so
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) -sv_lib test.so \
    +UVM_TESTNAME=calculator_test

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ simvision* xcelium.d simv.daidir *.so *.o *.err

gui:
	@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o test.so
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) -sv_lib test.so \
    +UVM_TESTNAME=calculator_test -gui

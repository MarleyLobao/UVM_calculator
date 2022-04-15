IFS = ../src/calculator_if.sv

PKGS = ../src/calculator_pkg.sv

RTL = ../../RTL/calculator.sv

sim:
	@g++ -g -fPIC -Wall -std=c++0x ../src/external.cpp -shared -o test.so
	xrun -64bit -uvm +incdir+../../RTL/ +incdir+../src $(PKGS) $(IFS) $(RTL) ../src/calculator_top.sv -sv_lib test.so \
    +UVM_TESTNAME=calculator_test

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ simvision* xcelium.d simv.daidir *.so *.o *.err

gui:
	@g++ -g -fPIC -Wall -std=c++0x ../src/external.cpp -shared -o test.so
	xrun -64bit -uvm +incdir+../../RTL/ +incdir+../src $(PKGS) $(IFS) $(RTL) ../src/calculator_top.sv -sv_lib test.so \
    +UVM_TESTNAME=calculator_test -gui

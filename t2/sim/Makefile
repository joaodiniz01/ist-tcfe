# ---------------------------------------------------------
# type "make" command in Unix to create report.pdf 
# ---------------------------------------------------------

all: ../sim/sim1.cir
	../sim/sim2.cir
	../sim/sim3.cir
	../sim/sim45.cir
	ngspice -b $< -o $@


clean:
	@rm -rf *.tex
	
.PHONY: clean


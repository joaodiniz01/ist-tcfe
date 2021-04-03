# ---------------------------------------------------------
# type "make" command in Unix to create report.pdf 
# ---------------------------------------------------------
#all: ../doc/octave.log

../doc/octave.log: AnaliseTeorica.m
	octave $< > $@

clean:
	@rm -f *.tex
	@rm -f *.txt
	@rm -f *.cir
	@rm -f *.eps
	@rm -f *.pdf
	
.PHONY: clean



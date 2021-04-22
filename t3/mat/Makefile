# ---------------------------------------------------------
# type "make" command in Unix to create report.pdf 
# ---------------------------------------------------------
all: | ../doc/octave.log convert

../doc/octave.log: AnaliseTeorica.m
	octave $< > $@
	
convert: 
	ls *.eps | awk '{system("epstopdf "$$0 )}'

clean:
	@rm -f *.tex
	@rm -f *.txt
	@rm -f *.cir
	@rm -f *.eps
	@rm -f *.pdf
	
.PHONY: clean



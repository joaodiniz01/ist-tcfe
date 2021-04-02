# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------	

all: | data.txt open

data.txt:
	echo 96364 | python2.7 t2_datagen.py > mat/data.txt
	sed -i -e '1,8d;20,22d' mat/data.txt
	sed -i 's/Values:  //g' mat/data.txt
	sed -i 's/[^ ]*R[^ ]*//ig' mat/data.txt
	sed -i 's/[^0-9.]*//g' mat/data.txt

open:
	make -C doc
	cp doc/report.pdf 
	
clean:
	@rm -f *.txt
	@rm -f mat/*.txt
	@rm -f mat/*.cir
	@rm -f sim/sim1data.cir
	@rm -f sim/sim2data.cir
	@rm -f sim/sim3data.cir
	@rm -f sim/sim45data.cir
	make -C doc clean

.PHONY: all clean



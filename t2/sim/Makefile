# ---------------------------------------------------------
# type "make" command in Unix to create report.pdf 
# ---------------------------------------------------------

all: ngspice1 ngspice2 ngspice3 ngspice45

ngspice1: ../doc/ngspice1.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > ../doc/$i_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

../doc/ngspice1.log: sim1.cir
	ngspice -b $< -o $@
	
ngspice2: ../doc/ngspice2.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > ../doc/$i_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

../doc/ngspice2.log: sim2.cir
	ngspice -b $< -o $@
	
ngspice3: ../doc/ngspice3.log


../doc/ngspice3.log: sim3.cir
	ngspice -b $< -o $@
	
ngspice45: ../doc/ngspice45.log


../doc/ngspice45.log: sim45.cir
	ngspice -b $< -o $@

	
clean:
	@rm -f sim1data.cir
	@rm -f sim2data.cir
	@rm -f sim3data.cir
	@rm -f sim45data.cir
	@rm -f *.tex
	@rm -f *.ps
	@rm -f *.pdf
	
.PHONY: clean


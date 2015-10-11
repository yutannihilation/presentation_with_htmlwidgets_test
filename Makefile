HTML_FILES = $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))
RMD_FILES  := $(patsubst %.Rmd.tpl, %_ioslides.Rmd ,$(wildcard *.Rmd.tpl)) \
						 $(patsubst %.Rmd.tpl, %_ioslides_noselfcontained.Rmd ,$(wildcard *.Rmd.tpl)) \
						 $(patsubst %.Rmd.tpl, %_slidy.Rmd ,$(wildcard *.Rmd.tpl)) \
						 $(patsubst %.Rmd.tpl, %_slidy_noselfcontained.Rmd ,$(wildcard *.Rmd.tpl)) \
						 $(patsubst %.Rmd.tpl, %_revealjs.Rmd ,$(wildcard *.Rmd.tpl)) \
						 $(patsubst %.Rmd.tpl, %_revealjs_noselfcontained.Rmd ,$(wildcard *.Rmd.tpl))

CACHE_DIRS := $(patsubst %.Rmd, %_cache ,$(wildcard *.Rmd))

FIGURE_DIR := figures/

all: rmd html index

rmd: $(RMD_FILES)

html: $(HTML_FILES)

%_ioslides.Rmd: %.Rmd.tpl
	sed -e "s/OUTPUT_FORMAT/ioslides_presentation/" $< > $@
%_ioslides_noselfcontained.Rmd: %.Rmd.tpl
	sed -e "s/OUTPUT_FORMAT/ioslides_presentation:\n    self_contained: false/" $< > $@
%_slidy.Rmd: %.Rmd.tpl
	sed -e "s/OUTPUT_FORMAT/slidy_presentation/" $< > $@
%_slidy_noselfcontained.Rmd: %.Rmd.tpl
	sed -e "s/OUTPUT_FORMAT/slidy_presentation:\n    self_contained: false/" $< > $@
%_revealjs.Rmd: %.Rmd.tpl
	sed -e "s/OUTPUT_FORMAT/revealjs::revealjs_presentation/" $< > $@
%_revealjs_noselfcontained.Rmd: %.Rmd.tpl
	sed -e "s/OUTPUT_FORMAT/revealjs::revealjs_presentation:\n    self_contained: false/" $< > $@

%.html: %.Rmd
	R --slave -e "try(rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8'))"

.PHONY: genRmd index clean

index:
	R --slave -e "rmarkdown::render('README.md', output_file = 'index.html', encoding = 'UTF-8')"

:
	sed 's/OUTPUT_FORMAT/revealjs::revealjs_presentation/'

clean:
	$(RM) *.html *_*.md *.Rmd
	$(RM) -r *_cache/ *_files/

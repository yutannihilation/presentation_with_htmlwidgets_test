HTML_FILES := $(patsubst %.Rmd, %_ioslides.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_ioslides_noselfcontained.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_slidy.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_slidy_noselfcontained.html ,$(wildcard *.Rmd))\
              $(patsubst %.Rmd, %_revealjs.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_revealjs_noselfcontained.html ,$(wildcard *.Rmd))

CACHE_DIRS := $(patsubst %.Rmd, %_cache ,$(wildcard *.Rmd))

FIGURE_DIR := figures/

all: html

html: $(HTML_FILES) index

%_ioslides.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'ioslides_presentation', output_options = list( \
				self_contained = TRUE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_ioslides_noselfcontained.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'ioslides_presentation', output_options = list( \
				self_contained = FALSE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_slidy.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'slidy_presentation', output_options = list( \
				self_contained = TRUE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_slidy_noselfcontained.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'slidy_presentation', output_options = list( \
				self_contained = FALSE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_revealjs.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'revealjs::revealjs_presentation', output_options = list( \
				self_contained = TRUE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_revealjs_noselfcontained.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'revealjs::revealjs_presentation', output_options = list( \
				self_contained = FALSE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

.PHONY: index clean

index:
	R --slave -e "rmarkdown::render('README.md', output_file = 'index.html', encoding = 'UTF-8')"

clean:
	$(RM) *.html *_*.md
	$(RM) -r *_cache/ *_files/
